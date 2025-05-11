//
//  ActivityItemView.swift
//  livanty
//
//  Created by M Naufal Badruttamam on 11/05/25.
//

import SwiftUI

struct ActivityItemView: View {
    let activity: Activity
    let showConnector: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .top, spacing: 10) {
                ZStack {
                    Image(systemName: activity.icon)
                        .font(.system(size: 25))
                        .foregroundColor(.white)
                        .frame(width: 50, height: 50)
                        .background(Color.primaryOrange)
                        .clipShape(Circle())
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(activity.title)
                        .font(.system(size: 18, weight: .bold))
                    
                    Text(activity.description)
                        .font(.system(size: 16))
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.vertical, 8)
            
            if showConnector {
                ConnectorView()
                    .frame(height: 24)
            }
        }
    }
}

#Preview {
    ActivityItemView(
        activity: Activity(
            name: "Pagi",
            title: "Kuliah",
            description: "Bangun pukul 7 pagi dan mengikuti perkuliahan",
            icon: "sunrise.fill"
        ),
        showConnector: true
    )
}
