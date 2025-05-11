//
//  ProfileJourneyView.swift
//  livanty
//
//  Created by M Naufal Badruttamam on 11/05/25.
//

import SwiftUI

struct ProfileJourneyView: View {
    @Binding var showStory: Bool
    var startStoryTimer: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("My Journey")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Spacer()
                
                Button(action: {
                    showStory = true
                    startStoryTimer()
                }) {
                    HStack {
                        Image(systemName: "play.fill")
                        Text("Start Story")
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(.primaryOrange)
                    .foregroundColor(.white)
                    .cornerRadius(20)
                }
            }
            .padding(.horizontal)
            
            ZigzagRoadmapView()
        }
    }
}

struct ProfileJourneyViewPreview: PreviewProvider {
    @State static var showStory = false
    
    static var previews: some View {
        ProfileJourneyView(
            showStory: $showStory,
            startStoryTimer: {}
        )
    }
}
