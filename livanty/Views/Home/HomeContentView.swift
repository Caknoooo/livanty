import Combine
import SwiftUI

struct HomeContentView: View {
  // States
  @State private var rotationY: Double = 0
  @State private var rotationX: Double = 0
  @State private var cardScale: CGFloat = 1.0
  @State private var isAnimating = false
  @State private var dragAmount = CGSize.zero
  @State private var expandDetails = false
  @State private var activeCardIndex = 0
  @State private var hoverPosition: CGPoint = .zero
  @State private var animationPhase = 0
  @State private var particleSystem = ParticleSystem()
  @State private var isPulsingButton = false
  @State private var activeAchievementIndex = 0
  @State private var showAchievementSheet = false

  // Navigation state
  @State private var navigationPath = NavigationPath()

  @State private var timerInterval: Double = 0.05
  let achievementTimer = Timer.publish(every: 4, on: .main, in: .common).autoconnect()
  @State private var timer: AnyCancellable?

  let personalCards = [
    PersonalCard(
      id: 0,
      title: "SPORTS ENTHUSIAST",
      subtitle: "Badminton, Running & Basketball",
      gradientColors: [Color.primaryOrange, Color(hex: "FF5F6D")],
      mainIcon: "figure.basketball",
      backgroundPatternIcons: ["figure.badminton", "figure.run", "figure.basketball"],
      imageName: "sports_image",
      description:
        "An active sports enthusiast who enjoys various physical activities. Plays recreational badminton with friends, maintains a casual running routine, and occasionally joins basketball games for fun and fitness.",
      achievements: [
        Achievements(
          id: 0,
          title: "Badminton Player",
          description:
            "Enjoys regular badminton sessions with friends and participates in casual games for fun and exercise.",
          icon: "figure.badminton",
          color: Color.primaryOrange
        ),
        Achievements(
          id: 1,
          title: "Casual Runner",
          description:
            "Maintains a regular running routine for fitness and mental well-being, enjoying outdoor activities.",
          icon: "figure.run",
          color: Color(hex: "FF5F6D")
        ),
        Achievements(
          id: 2,
          title: "Basketball Fan",
          description:
            "Enjoys occasional basketball games with friends, appreciating the team dynamics and fun atmosphere.",
          icon: "figure.basketball",
          color: Color.primaryOrange
        ),
      ],
      stats: [
        Stat(value: "3", label: "Activities"),
        Stat(value: "Weekly", label: "Exercise"),
        Stat(value: "Fun", label: "Priority"),
      ],
      quote:
        "Sports isn't about being the best—it's about staying active, having fun, and enjoying the journey to better health.",
      particleCount: 30
    ),
    PersonalCard(
      id: 1,
      title: "MUSIC LOVER",
      subtitle: "Songs & Playlists",
      gradientColors: [Color(hex: "614385"), Color(hex: "516395")],
      mainIcon: "music.note",
      backgroundPatternIcons: ["music.note", "music.note", "heart.fill"],
      imageName: "music_image",
      description:
        "A passionate music enthusiast with a taste for emotional and meaningful songs. Music is a daily companion and source of inspiration.",
      achievements: [
        Achievements(
          id: 0,
          title: "Favorite Tracks",
          description:
            "Curated collection of beloved songs including 'Love Yourself', 'Drunk Text', 'Birds of a Feather', and 'APT.'",
          icon: "heart.fill",
          color: Color(hex: "614385")
        ),
        Achievements(
          id: 1,
          title: "Emotional Ballads",
          description:
            "Deeply connected with meaningful lyrics in songs like 'Double Take', 'Die with a Smile', 'Breathe', and 'Just Give Me a Reason'.",
          icon: "music.note.list",
          color: Color(hex: "516395")
        ),
        Achievements(
          id: 2,
          title: "Movie Soundtracks",
          description:
            "Appreciates powerful movie soundtrack songs like 'Rewrite the Stars' and other cinematic music that tells a story.",
          icon: "speaker.wave.3.fill",
          color: Color(hex: "614385")
        ),
      ],
      stats: [
        Stat(value: "10+", label: "Playlists"),
        Stat(value: "100+", label: "Favorites"),
        Stat(value: "Daily", label: "Listening"),
      ],
      quote:
        "Music gives voice to emotions we can't express, and connects us to memories we cherish forever.",
      particleCount: 15
    ),
  ]

  let maxRotation: Double = 30

  var body: some View {
    NavigationStack(path: $navigationPath) {
      mainContentView
        .navigationDestination(for: String.self) { destination in
          if destination == "profile" {
            ProfileContentView()
          }
        }
        .navigationBarHidden(true)
        .onAppear {
          initializeOnAppear()
        }
        .onDisappear {
          timer?.cancel()
        }
        .onReceive(achievementTimer) { _ in
          updateAchievementIndex()
        }
    }
  }

  // MARK: - Extracted Views
  private var mainContentView: some View {
    ZStack {
      backgroundView
      mainContentStack

      if showAchievementSheet {
        achievementDetailView
      }
    }
  }

  private var backgroundView: some View {
    GeometryReader { geometry in
      ZStack {
        gradientBackground
        patternIconsView(geometry: geometry)
        particlesView
      }
    }
    .onAppear {
      isAnimating = true
    }
  }

  private var gradientBackground: some View {
    LinearGradient(
      gradient: Gradient(colors: [
        currentCard.gradientColors[0].opacity(0.3),
        currentCard.gradientColors[1].opacity(0.3),
      ]),
      startPoint: .topLeading,
      endPoint: .bottomTrailing
    )
    .edgesIgnoringSafeArea(.all)
  }

  private func patternIconsView(geometry: GeometryProxy) -> some View {
    ForEach(0..<min(20, currentCard.backgroundPatternIcons.count * 5), id: \.self) { index in
      Image(
        systemName: currentCard.backgroundPatternIcons[
          index % currentCard.backgroundPatternIcons.count]
      )
      .font(.system(size: CGFloat.random(in: activeCardIndex == 0 ? 20...40 : 20...30)))
      .foregroundColor(
        currentCard.gradientColors[index % 2]
          .opacity(CGFloat.random(in: 0.03...0.06))
      )
      .position(
        x: CGFloat.random(in: 0...geometry.size.width),
        y: CGFloat.random(in: 0...geometry.size.height)
      )
      .rotationEffect(.degrees(isAnimating ? Double.random(in: 0...360) : 0))
      .animation(
        Animation.linear(duration: Double.random(in: activeCardIndex == 0 ? 20...40 : 30...40))
          .repeatForever(autoreverses: false)
          .delay(Double.random(in: 0...5)),
        value: isAnimating
      )
    }
  }

  private var particlesView: some View {
    ForEach(particleSystem.particles.prefix(currentCard.particleCount), id: \.id) { particle in
      Circle()
        .fill(
          currentCard.gradientColors[particle.id % 2]
            .opacity(particle.opacity)
        )
        .frame(width: particle.size, height: particle.size)
        .position(particle.position)
        .blur(radius: particle.size / 3)
    }
  }

  private var mainContentStack: some View {
    VStack(spacing: 15) {
      headerView

      Spacer()

      cardView

      Spacer()

      instructionText

      exploreButton
    }
  }

  private var headerView: some View {
    HStack {
      VStack(alignment: .leading, spacing: 4) {
        Text("Personal Profile")
          .font(.title3)
          .fontWeight(.bold)

        Text("Explore both sides")
          .font(.subheadline)
          .foregroundColor(.secondary)
      }

      Spacer()

      themeSelector
    }
    .padding(.horizontal, 25)
    .padding(.top, 60)
  }

  private var themeSelector: some View {
    HStack(spacing: 5) {
      ForEach(0..<personalCards.count, id: \.self) { index in
        themeButton(for: index)
      }
    }
    .onAppear {
      isPulsingButton = true
    }
  }

  private func themeButton(for index: Int) -> some View {
    Button(action: {
      handleThemeButtonTap(index: index)
    }) {
      ZStack {
        Circle()
          .fill(
            activeCardIndex == index
              ? personalCards[index].gradientColors[0] : Color.gray.opacity(0.3)
          )
          .frame(width: 40, height: 40)

        Image(systemName: personalCards[index].mainIcon)
          .foregroundColor(.white)
          .font(.system(size: 18))
      }
      .overlay(
        Circle()
          .stroke(
            activeCardIndex == index
              ? personalCards[index].gradientColors[0] : Color.clear,
            lineWidth: 2
          )
          .scaleEffect(activeCardIndex == index && isPulsingButton ? 1.2 : 1.0)
          .opacity(activeCardIndex == index && isPulsingButton ? 0 : 1)
          .animation(
            Animation.easeInOut(duration: 1.5)
              .repeatForever(autoreverses: false),
            value: isPulsingButton
          )
      )
    }
  }

  private var cardView: some View {
    ZStack {
      cardStack

      cardIndicator
    }
    .padding(.bottom, 20)
  }

  private var cardStack: some View {
    ZStack {
      cardShadow

      interactiveCard
    }
  }

  private var cardShadow: some View {
    RoundedRectangle(cornerRadius: 30)
      .fill(Color.black.opacity(0.2))
      .blur(radius: 20)
      .frame(width: 320, height: 500)
      .offset(y: 20)
      .opacity(0.4)
  }

  private var interactiveCard: some View {
    Interactive3DCard(
      card: currentCard,
      rotationX: $rotationX,
      rotationY: $rotationY,
      scale: $cardScale,
      expandDetails: $expandDetails,
      activeAchievement: $activeAchievementIndex,
      onTapAchievement: {
        showAchievementSheet = true
      }
    )
    .frame(width: 320, height: 500)
    .scaleEffect(cardScale)
    .rotation3DEffect(
      .degrees(rotationY),
      axis: (x: 0, y: 1, z: 0),
      perspective: 0.5
    )
    .rotation3DEffect(
      .degrees(rotationX),
      axis: (x: 1, y: 0, z: 0),
      perspective: 0.5
    )
    .gesture(
      DragGesture()
        .onChanged { value in
          handleCardDrag(value: value)
        }
        .onEnded { _ in
          withAnimation(.spring()) {
            rotationY = 0
            rotationX = 0
          }
        }
    )
    .onTapGesture {
      withAnimation(.spring()) {
        expandDetails.toggle()
      }
    }
  }

  private var cardIndicator: some View {
    HStack(spacing: 8) {
      ForEach(0..<personalCards.count, id: \.self) { index in
        Circle()
          .fill(
            activeCardIndex == index ? currentCard.gradientColors[0] : Color.gray.opacity(0.3)
          )
          .frame(width: 8, height: 8)
      }
    }
    .offset(y: 270)
  }

  private var instructionText: some View {
    Text("Tap to expand • Drag to rotate")
      .font(.caption)
      .foregroundColor(.secondary)
      .opacity(isAnimating ? 0.5 : 1.0)
      .animation(
        Animation.easeInOut(duration: 1.2)
          .repeatForever(autoreverses: true),
        value: isAnimating
      )
  }

  private var exploreButton: some View {
    Button(action: {
      navigationPath.append("profile")
    }) {
      HStack {
        Text("Explore Full Profile")
          .font(.headline)
          .foregroundColor(.white)

        Image(systemName: "arrow.right.circle")
          .foregroundStyle(.white)
      }
      .frame(maxWidth: .infinity)
      .padding()
      .background(
        LinearGradient(
          gradient: Gradient(colors: currentCard.gradientColors),
          startPoint: .leading,
          endPoint: .trailing
        )
      )
      .cornerRadius(20)
      .shadow(
        color: currentCard.gradientColors[0].opacity(0.5),
        radius: 20,
        x: 0,
        y: 10
      )
      .overlay(
        RoundedRectangle(cornerRadius: 20)
          .strokeBorder(
            LinearGradient(
              gradient: Gradient(colors: [.white.opacity(0.6), .white.opacity(0)]),
              startPoint: .topLeading,
              endPoint: .bottomTrailing
            ),
            lineWidth: 1
          )
      )
    }
    .padding(.horizontal, 25)
    .padding(.bottom, 30)
  }

  private var achievementDetailView: some View {
    AchievementDetailView(
      achievement: currentCard.achievements[activeAchievementIndex],
      gradientColors: currentCard.gradientColors,
      isShowing: $showAchievementSheet
    )
    .transition(.move(edge: .bottom))
    .zIndex(3)
  }

  // MARK: - Helper Methods

  private func handleThemeButtonTap(index: Int) {
    withAnimation(.spring()) {
      if activeCardIndex != index {
        rotationY = 0
        rotationX = 0

        activeCardIndex = index

        updateTimerInterval()

        cardScale = 0.9
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
          withAnimation(.spring()) {
            cardScale = 1.0
          }
        }

        particleSystem.start(
          with: personalCards[index].gradientColors,
          screenSize: UIScreen.main.bounds.size,
          count: personalCards[index].particleCount
        )
      }
    }
  }

  private func handleCardDrag(value: DragGesture.Value) {
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height

    rotationY = Double(value.translation.width) / Double(width) * maxRotation * 6
    rotationX = -Double(value.translation.height) / Double(height) * maxRotation * 3
  }

  private func initializeOnAppear() {
    particleSystem.start(
      with: currentCard.gradientColors,
      screenSize: UIScreen.main.bounds.size,
      count: currentCard.particleCount
    )

    updateTimerInterval()
  }

  private func updateAchievementIndex() {
    withAnimation(.easeInOut) {
      activeAchievementIndex = (activeAchievementIndex + 1) % currentCard.achievements.count
    }
  }

  private func updateTimerInterval() {
    timer?.cancel()

    timerInterval = activeCardIndex == 0 ? 0.05 : 0.1

    timer = Timer.publish(every: timerInterval, on: .main, in: .common)
      .autoconnect()
      .sink { _ in
        particleSystem.update(maxSpeed: activeCardIndex == 0 ? 1.5 : 0.8)
      }
  }

  var currentCard: PersonalCard {
    personalCards[activeCardIndex]
  }
}

struct HomeContentView_Previews: PreviewProvider {
  static var previews: some View {
    HomeContentView()
  }
}
