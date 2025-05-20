//
//  ZigzagRoadmapView.swift
//  livanty
//
//  Created by M Naufal Badruttamam on 11/05/25.
//

import SwiftUI

struct ZigzagRoadmapView: View {
    let activities = [
        Activity(name: "Morning", title: "College", description: "Wake up at 7 AM and attend lectures until noon", icon: "sunrise.fill"),
        Activity(name: "Afternoon", title: "Apple Academy", description: "Participate in Apple Academy activities with enthusiasm", icon: "applelogo"),
        Activity(name: "Evening", title: "Exercise", description: "Maintain a healthy lifestyle by playing badminton, basketball, or running", icon: "figure.run"),
        Activity(name: "Night", title: "Freelance & Organization", description: "Active in organizations and completing responsibilities as a freelancer", icon: "laptopcomputer")
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach(0..<activities.count, id: \.self) { index in
                ActivityItemView(activity: activities[index], showConnector: index < activities.count - 1)
            }
        }
    }
}

#Preview {
    ZigzagRoadmapView()
}
