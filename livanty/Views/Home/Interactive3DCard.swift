import SwiftUI

struct Interactive3DCard: View {
  var card: PersonalCard
  @Binding var rotationX: Double
  @Binding var rotationY: Double
  @Binding var scale: CGFloat
  @Binding var expandDetails: Bool
  @Binding var activeAchievement: Int
  var onTapAchievement: () -> Void

  @State private var cardOpacity: Double = 0
  @State private var contentOpacity: Double = 0
  @State private var shimmerOffset: CGFloat = -0.25
  
  @State private var cachedAchievementViews: [Int: AnyView] = [:]

  var body: some View {
    ZStack {
      RoundedRectangle(cornerRadius: 30)
        .fill(Color.white.opacity(0.1))
        .background(
          RoundedRectangle(cornerRadius: 30)
            .fill(
              LinearGradient(
                gradient: Gradient(colors: [
                  Color.white.opacity(0.5),
                  Color.white.opacity(0.2),
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
              )
            )
            .blur(radius: 0.5)
        )
        .overlay(
          RoundedRectangle(cornerRadius: 30)
            .fill(
              LinearGradient(
                gradient: Gradient(colors: [
                  .clear,
                  .white.opacity(card.title == "MUSIC LOVER" ? 0.15 : 0.2),
                  .clear,
                ]),
                startPoint: UnitPoint(x: shimmerOffset, y: shimmerOffset),
                endPoint: UnitPoint(x: 1 + shimmerOffset, y: 1 + shimmerOffset)
              )
            )
        )
        .overlay(
          RoundedRectangle(cornerRadius: 30)
            .strokeBorder(
              LinearGradient(
                gradient: Gradient(colors: [
                  .white.opacity(0.6),
                  .white.opacity(0.1),
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
              ),
              lineWidth: 1.5
            )
        )
        .shadow(color: Color.black.opacity(0.15), radius: 20, x: 0, y: 10)
        .shadow(color: Color.white.opacity(0.2), radius: 5, x: -5, y: -5)

      VStack(spacing: 0) {
        ZStack(alignment: .bottom) {
            GeometryReader { geometry in
                Image(card.imageName)
                  .resizable()
                  .aspectRatio(contentMode: .fill)
                  .frame(width: geometry.size.width, height: geometry.size.height)
                  .clipShape(RoundedRectangle(cornerRadius: 30))
                  .overlay(
                    LinearGradient(
                      gradient: Gradient(colors: [
                        .clear,
                        Color.black.opacity(0.5),
                      ]),
                      startPoint: .top,
                      endPoint: .bottom
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 30))
                  )
                  .offset(
                    x: CGFloat(rotationY) * (card.title == "MUSIC LOVER" ? -0.3 : -0.5),
                    y: CGFloat(rotationX) * (card.title == "MUSIC LOVER" ? 0.3 : 0.5)
                  )
            }

          VStack(alignment: .leading, spacing: 5) {
            ZStack {
              HStack {
                ZStack {
                  Circle()
                    .fill(
                      LinearGradient(
                        gradient: Gradient(colors: card.gradientColors),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                      )
                    )
                    .frame(width: 40, height: 40)

                  Image(systemName: card.mainIcon)
                    .font(.system(size: 18))
                    .foregroundColor(.white)
                }

                VStack(alignment: .leading, spacing: 2) {
                  Text(card.title)
                    .font(.system(size: 24, weight: .bold, design: .rounded))
                    .foregroundColor(.white)

                  Text(card.subtitle)
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.8))
                }

                Spacer()
              }
            }
            .padding(.bottom, 5)
          }
          .padding(20)
        }
        .frame(height: expandDetails ? 130 : 180)
        .animation(.spring(), value: expandDetails)

        HStack(spacing: 0) {
          ForEach(card.stats, id: \.label) { stat in
            VStack(spacing: 4) {
              Text(stat.value)
                .font(.system(size: 20, weight: .bold, design: .rounded))
                .foregroundColor(card.gradientColors[0])

              Text(stat.label)
                .font(.caption)
                .foregroundColor(.secondary)
            }
            .frame(maxWidth: .infinity)
          }
        }
        .padding(.vertical, 15)
        .background(Color.white.opacity(0.1))

        if expandDetails {
          ScrollView(showsIndicators: false) {
            LazyVStack(alignment: .leading, spacing: 15) {
              Text(card.description)
                .font(.subheadline)
                .foregroundColor(Color(.label))
                .lineSpacing(4)
                .padding(.horizontal, 20)
                .padding(.top, 15)
                .opacity(contentOpacity)

              VStack(alignment: .leading, spacing: 10) {
                Text("ACHIEVEMENTS")
                  .font(.caption)
                  .fontWeight(.bold)
                  .foregroundColor(Color.secondary)
                  .tracking(1)
                  .padding(.horizontal, 20)

                ZStack {
                  ForEach(0..<card.achievements.count, id: \.self) { index in
                    if abs(index - activeAchievement) <= 1 {
                      achievementCardView(for: index)
                        .offset(x: CGFloat(index - activeAchievement) * 450)
                        .opacity(abs(index - activeAchievement) <= 1 ? 1 : 0)
                        .scaleEffect(activeAchievement == index ? 1 : 0.9)
                        .animation(.spring(), value: activeAchievement)
                    }
                  }
                }
                .frame(height: 80)
                .padding(.horizontal, 10)
                .opacity(contentOpacity)

                HStack(spacing: 8) {
                  ForEach(0..<card.achievements.count, id: \.self) { index in
                    Circle()
                      .fill(
                        activeAchievement == index ? card.gradientColors[0] : Color.gray.opacity(0.3)
                      )
                      .frame(width: 6, height: 6)
                  }
                }
                .padding(.top, 5)
                .padding(.horizontal, 20)
                .opacity(contentOpacity)
              }
              .padding(.top, 10)

              HStack {
                RoundedRectangle(cornerRadius: 2)
                  .fill(
                    LinearGradient(
                      gradient: Gradient(colors: card.gradientColors),
                      startPoint: .top,
                      endPoint: .bottom
                    )
                  )
                  .frame(width: 3, height: 40)

                Text(card.quote)
                  .font(.system(.footnote, design: .serif))
                  .italic()
                  .foregroundColor(.secondary)
                  .fixedSize(horizontal: false, vertical: true)
                  .lineLimit(3)
                  .padding(.leading, 5)
              }
              .padding(.horizontal, 20)
              .padding(.top, 10)
              .padding(.bottom, 20)
              .opacity(contentOpacity)
            }
          }
          .opacity(expandDetails ? 1 : 0)
        } else {
          Spacer()
            .frame(height: 0)
        }
      }
    }
    .onAppear {
      withAnimation(.easeInOut(duration: 0.8)) {
        cardOpacity = 1
      }

      withAnimation(.easeInOut(duration: 1.2).delay(0.4)) {
        contentOpacity = 1
      }

      let shimmerDuration = card.title == "MUSIC LOVER" ? 4.0 : 3.0
      withAnimation(
        Animation.easeInOut(duration: shimmerDuration)
          .repeatForever(autoreverses: false)
      ) {
        shimmerOffset = 1.25
      }
    }
  }
  
  private func achievementCardView(for index: Int) -> AnyView {
    if let cachedView = cachedAchievementViews[index] {
      return cachedView
    } else {
      let view = AnyView(
        AchievementCardView(
          achievement: card.achievements[index],
          isActive: activeAchievement == index,
          gradientColors: card.gradientColors,
          onTap: {
            activeAchievement = index
            onTapAchievement()
          }
        )
      )
      
      cachedAchievementViews[index] = view
      return view
    }
  }
}
struct Interactive3DCard_Previews: PreviewProvider {
    @State static var rotationX: Double = 0
    @State static var rotationY: Double = 0
    @State static var scale: CGFloat = 1.0
    @State static var expandDetails: Bool = true
    @State static var activeAchievement: Int = 0
    
    static var previewCards: [PersonalCard] = [
        PersonalCard(
          id: 0,
          title: "SPORTS ENTHUSIAST",
          subtitle: "Badminton, Running & Basketball",
          gradientColors: [Color.orange, Color.red],
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
              color: Color.orange
            ),
            Achievements(
              id: 1,
              title: "Casual Runner",
              description:
                "Maintains a regular running routine for fitness and mental well-being, enjoying outdoor activities.",
              icon: "figure.run",
              color: Color.red
            ),
            Achievements(
              id: 2,
              title: "Basketball Fan",
              description:
                "Enjoys occasional basketball games with friends, appreciating the team dynamics and fun atmosphere.",
              icon: "figure.basketball",
              color: Color.blue
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
          gradientColors: [Color.purple, Color.blue],
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
              color: Color.purple
            ),
            Achievements(
              id: 1,
              title: "Emotional Ballads",
              description:
                "Deeply connected with meaningful lyrics in songs like 'Double Take', 'Die with a Smile', 'Breathe', and 'Just Give Me a Reason'.",
              icon: "music.note.list",
              color: Color.blue
            ),
            Achievements(
              id: 2,
              title: "Movie Soundtracks",
              description:
                "Appreciates powerful movie soundtrack songs like 'Rewrite the Stars' and other cinematic music that tells a story.",
              icon: "speaker.wave.3.fill",
              color: Color.purple
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
    
    static var previews: some View {
        Group {
            // Sports Enthusiast Card Preview
            Interactive3DCard(
                card: previewCards[0],
                rotationX: .constant(0),
                rotationY: .constant(0),
                scale: .constant(1.0),
                expandDetails: .constant(true),
                activeAchievement: .constant(0),
                onTapAchievement: {}
            )
            .frame(width: 350, height: 600)
            .background(Color(.systemBackground))
            .previewDisplayName("Sports Enthusiast Card (Expanded)")
            
            // Sports Enthusiast Card Collapsed Preview
            Interactive3DCard(
                card: previewCards[0],
                rotationX: .constant(0),
                rotationY: .constant(0),
                scale: .constant(1.0),
                expandDetails: .constant(false),
                activeAchievement: .constant(0),
                onTapAchievement: {}
            )
            .frame(width: 350, height: 300)
            .background(Color(.systemBackground))
            .previewDisplayName("Sports Enthusiast Card (Collapsed)")
            
            Interactive3DCard(
                card: previewCards[1],
                rotationX: .constant(0),
                rotationY: .constant(0),
                scale: .constant(1.0),
                expandDetails: .constant(true),
                activeAchievement: .constant(0),
                onTapAchievement: {}
            )
            .frame(width: 350, height: 600)
            .background(Color(.systemBackground))
            .previewDisplayName("Music Lover Card (Expanded)")
            
            Interactive3DCard(
                card: previewCards[1],
                rotationX: .constant(0),
                rotationY: .constant(0),
                scale: .constant(1.0),
                expandDetails: .constant(true),
                activeAchievement: .constant(1),
                onTapAchievement: {}
            )
            .frame(width: 350, height: 600)
            .background(Color(.systemBackground))
            .environment(\.colorScheme, .dark)
            .previewDisplayName("Music Lover Card (Dark Mode)")
            
            // Sports Card with rotation simulation
            Interactive3DCard(
                card: previewCards[0],
                rotationX: .constant(5),
                rotationY: .constant(10),
                scale: .constant(0.95),
                expandDetails: .constant(false),
                activeAchievement: .constant(0),
                onTapAchievement: {}
            )
            .frame(width: 350, height: 300)
            .background(Color(.systemBackground))
            .previewDisplayName("Sports Card (With Rotation)")
        }
    }
}
