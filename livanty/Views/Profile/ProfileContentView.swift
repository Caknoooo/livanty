//
//  ProfileContentView.swift
//  livanty
//
//  Created by M Naufal Badruttamam on 12/05/25.
//

import SwiftUI

struct ProfileContentView: View {
    @Binding var showStory: Bool
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                VStack(spacing: 16) {
                    ProfileHeaderView()
                        .padding(.top, 16)
                        .padding(.horizontal)
                    ProfileActionButtonsView()
                        .padding(.horizontal)
                    ProfileTagsView()
                        .padding(.horizontal)
                    ProfileJourneyView(
                        showStory: $showStory,
                        startStoryTimer: {
                            
                        }
                    )
                        .padding(.horizontal)
                    FAQView()
                        .padding(.horizontal)
                        .padding(.bottom, 60)
                }
            }
            .navigationTitle("@livantyefatania_")
        }
    }
}

// MARK: - Preview Provider
struct ProfileContentView_Previews: PreviewProvider {
    @State static var showStory = false
    
    static var previews: some View {
        ProfileContentView(showStory: $showStory)
    }
}
