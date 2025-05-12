//
//  BottomBar.swift
//  livanty
//
//  Created by M Naufal Badruttamam on 11/05/25.
//

import SwiftUI

struct BottomTabBar: View {
    @State private var selectedTab = 0
    @State private var showStory = false
    @State private var currentStoryIndex = 0
    @State private var storyProgress: CGFloat = 0
    @State private var isPaused = false
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeContentView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
                .tag(0)
            
            ProfileContentView(showStory: $showStory)
                .tabItem {
                    Image(systemName: "person.crop.circle")
                    Text("Profile")
                }
                .tag(1)
        }
        .accentColor(.primaryOrange)
        .fullScreenCover(isPresented: $showStory) {
            StoryFullScreenView(
                isPresented: $showStory,
                currentIndex: $currentStoryIndex,
                progress: $storyProgress,
                isHold: $isPaused
            )
        }
    }
}

#Preview {
    BottomTabBar()
}
