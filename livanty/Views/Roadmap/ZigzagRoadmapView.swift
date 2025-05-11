//
//  ZigzagRoadmapView.swift
//  livanty
//
//  Created by M Naufal Badruttamam on 11/05/25.
//

import SwiftUI

struct ZigzagRoadmapView: View {
    let activities = [
        Activity(name: "Pagi", title: "Kuliah", description: "Bangun pukul 7 pagi dan mengikuti perkuliahan hingga siang hari", icon: "sunrise.fill"),
        Activity(name: "Siang", title: "Apple Academy", description: "Berpartisipasi dalam kegiatan Apple Academy dengan penuh semangat", icon: "applelogo"),
        Activity(name: "Sore", title: "Olahraga", description: "Menjaga gaya hidup sehat dengan bermain badminton, basket, atau berlari", icon: "figure.run"),
        Activity(name: "Malam", title: "Freelance & Organisasi", description: "Aktif dalam organisasi dan menyelesaikan tanggung jawab sebagai freelancer", icon: "laptopcomputer")
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach(0..<activities.count, id: \.self) { index in
                ActivityItemView(activity: activities[index], showConnector: index < activities.count - 1)
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    ZigzagRoadmapView()
}
