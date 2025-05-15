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
            title: "Apple Developer Academy Graduate",
            description: "Berhasil menyelesaikan program Apple Developer Academy dengan proyek akhir mendapatkan nilai A+",
            date: "Mei 2025",
            icon: "applelogo",
            isHighlighted: true
        ),
        Achievement(
            title: "Hackathon Winner",
            description: "Juara 1 pada Hackathon Nasional dengan mengembangkan aplikasi inovatif untuk membantu pelajar",
            date: "Maret 2025",
            icon: "medal",
            isHighlighted: false
        ),
        Achievement(
            title: "Certified iOS Developer",
            description: "Mendapatkan sertifikasi resmi sebagai iOS Developer yang diakui internasional",
            date: "Februari 2025",
            icon: "checkmark.seal",
            isHighlighted: false
        ),
        Achievement(
            title: "Student of the Month",
            description: "Dipilih sebagai mahasiswa terbaik bulan ini berdasarkan prestasi akademik dan non-akademik",
            date: "Januari 2025",
            icon: "star",
            isHighlighted: false
        ),
        Achievement(
            title: "Best App Design Award",
            description: "Memenangkan penghargaan untuk desain aplikasi terbaik dalam kompetisi desain UI/UX",
            date: "Desember 2024",
            icon: "paintbrush",
            isHighlighted: false
        )
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Achievements & Certifications")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Text("Prestasi dan sertifikasi yang diraih selama perjalanan akademik dan profesional")
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
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                isPresented = false
            }) {
                Image(systemName: "xmark")
                    .font(.system(size: 17, weight: .bold))
                    .foregroundColor(.gray)
                    .padding(8)
                    .background(Circle().fill(Color.gray.opacity(0.1)))
            })
        }
    }
}

#Preview {
    AchievementModalView(isPresented: .constant(true))
}
