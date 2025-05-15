//
//  AchievementItemView.swift
//  livanty
//
//  Created by M Naufal Badruttamam on 12/05/25.
//
import SwiftUI

struct AchievementItemView: View {
    let achievement: Achievement
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            Image(systemName: achievement.icon)
                .font(.system(size: 24))
                .foregroundColor(.primaryOrange)
                .frame(width: 40, height: 40)
                .background(Circle().fill(Color.gray.opacity(0.1)))
                .padding(.top, 4)
            
            VStack(alignment: .leading, spacing: 6) {
                Text(achievement.title)
                    .font(.headline)
                    .foregroundColor(achievement.isHighlighted ? .primaryOrange : .primary)
                
                Text(achievement.description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
                
                Text(achievement.date)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            Spacer()
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 16)
        .background(achievement.isHighlighted ? Color.orange.opacity(0.05) : Color.clear)
        .cornerRadius(8)
    }
}

#Preview {
    AchievementItemView(achievement: Achievement(
        title: "Apple Developer Academy Graduate",
        description: "Berhasil menyelesaikan program Apple Developer Academy dengan proyek akhir mendapatkan nilai A+",
        date: "Mei 2025",
        icon: "applelogo",
        isHighlighted: true
    ))
}
