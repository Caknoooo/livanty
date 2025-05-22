//
//  AchievementModalView.swift
//  livanty
//
//  Created by M Naufal Badruttamam on 12/05/25.
//

import SwiftUI

struct AchievementModalView: View {
    @Binding var isPresented: Bool

    let achievements = [
        Achievement(
            title: "Full Score Achievement – ISB 2024",
            description:
                "Achieved perfect score in Independent School Benchmarking 2024",
            date: "2024",
            icon: "star.fill",
            isHighlighted: true
        ),
        Achievement(
            title: "Highest score in Science major for 12th grade",
            description:
                "Achieved the highest score across all Science majors in 12th grade at SMAK Karitas III",
            date: "2023-2024",
            icon: "1.circle",
            isHighlighted: false
        ),
        Achievement(
            title:
                "First rank recipient for best education unit average score in 12th grade",
            description:
                "Achieved 1st rank with the highest average score in 12th grade at SMAK Karitas III",
            date: "2023-2024",
            icon: "trophy",
            isHighlighted: false
        ),
        Achievement(
            title: "3rd place in badminton at Dean's Cup 2023",
            description:
                "Secured third position in the Dean's Cup badminton competition",
            date: "2023",
            icon: "figure.badminton",
            isHighlighted: false
        ),
        Achievement(
            title:
                "2nd place in High School internal Badminton competition 2022",
            description:
                "Secured second position in the school-level badminton competition",
            date: "2022",
            icon: "figure.badminton",
            isHighlighted: false
        ),
        Achievement(
            title:
                "First rank recipient for best education unit average score in 11th grade",
            description:
                "Achieved 1st rank with the highest average score in 11th grade at SMAK Karitas III",
            date: "2022-2023",
            icon: "trophy",
            isHighlighted: false
        ),
        Achievement(
            title:
                "First rank recipient for best education unit average score in 10th grade",
            description:
                "Achieved 1st rank with the highest average score in 10th grade at SMAK Karitas III",
            date: "2021-2022",
            icon: "trophy",
            isHighlighted: false
        ),
    ]

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Achievements & Certifications")
                            .font(.title2)
                            .fontWeight(.bold)

                        Text(
                            "Prestasi dan sertifikasi yang diraih selama perjalanan akademik dan profesional"
                        )
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.white)

                    Rectangle()
                        .fill(Color.gray.opacity(0.2))
                        .frame(height: 8)

                    VStack(spacing: 0) {
                        ForEach(achievements) { achievement in
                            AchievementItemView(achievement: achievement)

                            if achievement.id != achievements.last?.id {
                                Divider()
                                    .padding(.leading, 56)
                            }
                        }
                    }
                    .background(Color.white)
                    .cornerRadius(8)
                    .padding(.bottom, 20)
                }
                .background(Color.gray.opacity(0.1))
            }
            .padding(.top)
        }
    }
}

#Preview {
    AchievementModalView(isPresented: .constant(true))
}
