import SwiftUI

struct AchievementCardView: View {
  var achievement: Achievements
  var isActive: Bool
  var gradientColors: [Color]
  var onTap: () -> Void
  
  @State private var cachedIconView: AnyView? = nil
  @State private var cachedBackgroundView: AnyView? = nil

  var body: some View {
    Button(action: onTap) {
      HStack(spacing: 15) {
        iconView()
          .frame(width: 50, height: 50)

        VStack(alignment: .leading, spacing: 4) {
          Text(achievement.title)
            .font(.subheadline)
            .fontWeight(.semibold)
            .foregroundColor(.white)

          Text(achievement.description)
            .font(.caption)
            .foregroundColor(.white)
            .lineLimit(2)
            .truncationMode(.tail)
        }

        Spacer()

        if isActive || achievement.title.contains("Favorite") == false {
          Image(systemName: "chevron.right.circle.fill")
            .foregroundColor(achievement.color.opacity(0.7))
            .font(.system(size: 20))
            .opacity(isActive ? 1 : 0.5)
        }
      }
      .padding(.horizontal, 15)
      .padding(.vertical, 10)
      .background(
        backgroundView()
      )
    }
    .buttonStyle(PlainButtonStyle())
  }
  
  private func iconView() -> AnyView {
    if let cached = cachedIconView {
      return cached
    }
    
    let view = AnyView(
      ZStack {
        Circle()
          .fill(
            LinearGradient(
              gradient: Gradient(colors: [
                achievement.color.opacity(0.7),
                achievement.color,
              ]),
              startPoint: .topLeading,
              endPoint: .bottomTrailing
            )
          )

        Image(systemName: achievement.icon)
          .font(.system(size: 22))
          .foregroundColor(.white)
      }
    )
    
    DispatchQueue.main.async {
      self.cachedIconView = view
    }
    
    return view
  }
  
  private func backgroundView() -> AnyView {
    if let cached = cachedBackgroundView {
      return cached
    }
    
    let view = AnyView(
      RoundedRectangle(cornerRadius: 15)
        .frame(width: 400, height: 80)
        .overlay(
          RoundedRectangle(cornerRadius: 15)
            .stroke(
              LinearGradient(
                gradient: Gradient(
                  colors: isActive
                    ? [.white.opacity(0.4), .white.opacity(0.1)] : [.clear, .clear]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
              ),
              lineWidth: 1
            )
            .fill(Color.white.opacity(0.4))
        )
        .shadow(
          color: isActive ? achievement.color.opacity(0.5) : Color.clear,
          radius: 10,
          x: 0,
          y: 5
        )
    )
    
    DispatchQueue.main.async {
      self.cachedBackgroundView = view
    }
    
    return view
  }
}

struct AchievementCardView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AchievementCardView(
                achievement: Achievements(
                    id: 0,
                    title: "Badminton Champion",
                    description: "Won the university badminton tournament and represented the campus in regional competitions.",
                    icon: "figure.badminton",
                    color: Color(hex: "FF8C00")
                ),
                isActive: true,
                gradientColors: [Color(hex: "FF8C00"), Color(hex: "FF5F6D")],
                onTap: {}
            )
            .previewLayout(.sizeThatFits)
            .padding()
            .previewDisplayName("Athletics Card (Active)")

            AchievementCardView(
                achievement: Achievements(
                    id: 0,
                    title: "5K Running",
                    description: "Maintains a daily 5K running routine and completed several campus marathons with impressive timing.",
                    icon: "figure.run",
                    color: Color(hex: "FF5F6D")
                ),
                isActive: false,
                gradientColors: [Color(hex: "FF8C00"), Color(hex: "FF5F6D")],
                onTap: {}
            )
            .previewLayout(.sizeThatFits)
            .padding()
            .previewDisplayName("Athletics Card (Inactive)")
            
            AchievementCardView(
                achievement: Achievements(
                    id: 1,
                    title: "Favorite Tracks",
                    description: "Curated collection of favorite songs including popular hits and indie discoveries.",
                    icon: "heart.fill",
                    color: Color(hex: "614385")
                ),
                isActive: true,
                gradientColors: [Color(hex: "614385"), Color(hex: "516395")],
                onTap: {}
            )
            .previewLayout(.sizeThatFits)
            .padding()
            .background(Color(.systemGray6))
            .previewDisplayName("Music Card (Active)")
            
            AchievementCardView(
                achievement: Achievements(
                    id: 2,
                    title: "Soundtrack Fan",
                    description: "Appreciates movie soundtracks and instrumental compositions.",
                    icon: "music.note.list",
                    color: Color(hex: "516395")
                ),
                isActive: false,
                gradientColors: [Color(hex: "614385"), Color(hex: "516395")],
                onTap: {}
            )
            .previewLayout(.sizeThatFits)
            .padding()
            .background(Color(.systemGray6))
            .environment(\.colorScheme, .dark)
            .previewDisplayName("Music Card (Inactive, Dark Mode)")
        }
    }
}
