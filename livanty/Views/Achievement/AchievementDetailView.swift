import SwiftUI

struct AchievementDetailView: View {
    var achievement: Achievements
    var gradientColors: [Color]
    @Binding var isShowing: Bool

    @State private var dragAmount = CGSize.zero
    @State private var contentOpacity = 0.0

    @State private var relatedSkills: [String] = []

    var body: some View {
        ZStack {
            Color.black.opacity(0.5)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    closeView()
                }
                .allowsHitTesting(contentOpacity > 0.5)

            VStack(spacing: 0) {
                RoundedRectangle(cornerRadius: 3)
                    .fill(Color.white.opacity(0.3))
                    .frame(width: 40, height: 5)
                    .padding(.top, 10)
                    .padding(.bottom, 15)

                VStack(alignment: .leading, spacing: 20) {
                    HStack(spacing: 15) {
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
                                .frame(width: 60, height: 60)

                            Image(systemName: achievement.icon)
                                .font(.system(size: 30))
                                .foregroundColor(.white)
                        }

                        VStack(alignment: .leading, spacing: 4) {
                            Text(achievement.title)
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(.white)

                            Text("Achievement")
                                .font(.subheadline)
                                .foregroundColor(.white.opacity(0.7))
                        }

                        Spacer()

                        Button(action: {
                            closeView()
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .font(.system(size: 28))
                                .foregroundColor(.white.opacity(0.7))
                        }
                    }

                    LazyVStack(alignment: .leading, spacing: 15) {
                        Text("DETAILS")
                            .font(.caption)
                            .fontWeight(.bold)
                            .tracking(1)
                            .foregroundColor(.white.opacity(0.7))

                        Text(achievement.description)
                            .font(.body)
                            .foregroundColor(.white)
                            .lineSpacing(5)

                        Text("SKILLS INVOLVED")
                            .font(.caption)
                            .fontWeight(.bold)
                            .tracking(1)
                            .foregroundColor(.white.opacity(0.7))
                            .padding(.top, 10)

                        LazyHStack(spacing: 10) {
                            ForEach(relatedSkills, id: \.self) { skill in
                                skillTag(for: skill)
                            }
                        }
                        .padding(.top, 5)
                    }
                    .padding(.top, 15)

                    Spacer()
                }
                .padding(.horizontal, 25)
                .padding(.bottom, 25)
                .opacity(contentOpacity)
            }
            .frame(maxWidth: .infinity, maxHeight: 450)
            .background(
                RoundedRectangle(cornerRadius: 30)
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                achievement.color.opacity(0.7),
                                achievement.color.opacity(0.5),
                            ]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 30)
                            .fill(Color.white.opacity(0.05))
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 30)
                            .strokeBorder(
                                LinearGradient(
                                    gradient: Gradient(colors: [
                                        Color.white.opacity(0.7),
                                        Color.white.opacity(0.1),
                                    ]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ),
                                lineWidth: 1
                            )
                    )
                    .shadow(
                        color: Color.black.opacity(0.2),
                        radius: 20,
                        x: 0,
                        y: 10
                    )
            )
            .offset(y: 300 + dragAmount.height)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        if value.translation.height > 0 {
                            dragAmount = value.translation
                        }
                    }
                    .onEnded { value in
                        if value.translation.height > 100 {
                            closeView()
                        } else {
                            withAnimation(.spring()) {
                                dragAmount = .zero
                            }
                        }
                    }
            )
        }
        .onAppear {
            relatedSkills = getRelatedSkills()

            withAnimation(.easeIn.delay(0.3)) {
                contentOpacity = 1.0
            }
        }
    }

    private func skillTag(for skill: String) -> some View {
        Text(skill)
            .font(.caption)
            .foregroundColor(.white)
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(
                Capsule()
                    .fill(achievement.color.opacity(0.3))
                    .overlay(
                        Capsule()
                            .stroke(
                                achievement.color.opacity(0.6),
                                lineWidth: 1
                            )
                    )
            )
    }

    func getRelatedSkills() -> [String] {
        switch achievement.title {
        case "Basketball MVP":
            return ["Leadership", "Teamwork", "Agility", "Strategy"]
        case "10K Running":
            return ["Endurance", "Discipline", "Consistency", "Goal Setting"]
        case "Fitness Training":
            return ["Coaching", "Nutrition", "Exercise Science", "Motivation"]
        case "Lead Vocalist":
            return [
                "Performance", "Vocal Range", "Composition", "Stage Presence",
            ]
        case "Guitar Mastery":
            return ["Music Theory", "Fingerpicking", "Improvisation", "Rhythm"]
        case "Music Production":
            return [
                "Audio Engineering", "Composition", "Sound Design", "Mixing",
            ]
        case "Badminton Champion":
            return ["Precision", "Agility", "Strategy", "Endurance"]
        case "5K Running":
            return ["Endurance", "Consistency", "Pacing", "Technique"]
        case "Basketball Team":
            return ["Teamwork", "Coordination", "Strategy", "Athleticism"]
        case "Favorite Tracks":
            return ["Curation", "Discovery", "Appreciation"]
        case "Soundtrack Fan":
            return ["Appreciation", "Collection", "Emotion"]
        case "Emotional Hits":
            return ["Lyrics", "Emotion", "Connection"]
        default:
            return ["Expertise", "Dedication", "Practice", "Skill"]
        }
    }

    func closeView() {
        withAnimation(.spring(dampingFraction: 0.7)) {
            dragAmount.height = 300
            contentOpacity = 0
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            isShowing = false
        }
    }
}

struct AchievementDetailView_Previews: PreviewProvider {
    @State static var isShowing = true

    static var previews: some View {
        Group {
            AchievementDetailView(
                achievement: Achievements(
                    id: 0,
                    title: "Badminton Champion",
                    description:
                        "Won the university badminton tournament and represented the campus in regional competitions.",
                    icon: "figure.badminton",
                    color: Color(hex: "FF8C00")
                ),
                gradientColors: [Color(hex: "FF8C00"), Color(hex: "FF5F6D")],
                isShowing: $isShowing
            )
            .previewDisplayName("Athlete Achievement")

            AchievementDetailView(
                achievement: Achievements(
                    id: 1,
                    title: "Favorite Tracks",
                    description:
                        "Curated collection of favorite songs including popular hits and indie discoveries.",
                    icon: "heart.fill",
                    color: Color(hex: "614385")
                ),
                gradientColors: [Color(hex: "614385"), Color(hex: "516395")],
                isShowing: $isShowing
            )
            .previewDisplayName("Music Achievement")
            .environment(\.colorScheme, .dark)
        }
    }
}
