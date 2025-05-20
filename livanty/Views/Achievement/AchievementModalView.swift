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
                "Mendapatkan nilai sempurna dalam Independent School Benchmarking 2024",
            date: "2024",
            icon: "star.fill",
            isHighlighted: true
        ),
        Achievement(
            title: "Peraih nilai tertinggi jurusan IPA kelas 12",
            description:
                "Mencapai nilai tertinggi di seluruh jurusan IPA pada kelas 12 SMAK Karitas III",
            date: "2023-2024",
            icon: "1.circle",
            isHighlighted: false
        ),
        Achievement(
            title:
                "Peraih rata-rata nilai satuan pendidikan terbaik peringkat pertama kelas 12",
            description:
                "Mendapatkan peringkat 1 dengan rata-rata nilai tertinggi di kelas 12 SMAK Karitas III",
            date: "2023-2024",
            icon: "trophy",
            isHighlighted: false
        ),
        Achievement(
            title: "Juara 3 bulu tangkis Dean's Cup 2023",
            description:
                "Meraih posisi ketiga dalam kompetisi bulu tangkis Dean's Cup",
            date: "2023",
            icon: "figure.badminton",
            isHighlighted: false
        ),
        Achievement(
            title: "Juara 2 lomba Badminton internal SMA 2022",
            description:
                "Meraih posisi kedua dalam kompetisi bulu tangkis tingkat sekolah",
            date: "2022",
            icon: "figure.badminton",
            isHighlighted: false
        ),
        Achievement(
            title:
                "Peraih rata-rata nilai satuan pendidikan terbaik peringkat pertama kelas 11",
            description:
                "Mendapatkan peringkat 1 dengan rata-rata nilai tertinggi di kelas 11 SMAK Karitas III",
            date: "2022-2023",
            icon: "trophy",
            isHighlighted: false
        ),
        Achievement(
            title:
                "Peraih rata-rata nilai satuan pendidikan terbaik peringkat pertama kelas 10",
            description:
                "Mendapatkan peringkat 1 dengan rata-rata nilai tertinggi di kelas 10 SMAK Karitas III",
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
