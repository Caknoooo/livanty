//
//  ProfileContentView.swift
//  livanty
//
//  Created by M Naufal Badruttamam on 12/05/25.
//

import SwiftUI

struct ProfileContentView: View {
    @State private var showStory = false
    @State private var currentStoryIndex = 0
    @State private var storyProgress: CGFloat = 0
    @State private var storyTimer: Timer?
    @State private var isPaused = false
    @State private var isNavbarButton = false
    
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
                        startStoryTimer: startStoryTimer
                    )
                        .padding(.horizontal)
                    FAQView()
                        .padding(.horizontal)
                        .padding(.bottom, 60)
                }
            }
            .navigationTitle("@livantyefatania_")
            .navigationBarHidden(isNavbarButton)
            .overlay(
                ZStack {
                    if showStory {
                        Color.black.edgesIgnoringSafeArea(.all)
                        
                        StoryView(
                            isPresented: $showStory,
                            currentIndex: $currentStoryIndex,
                            progress: $storyProgress,
                            isHold: $isPaused,
                            stopTimer: stopStoryTimer
                        )
                    }
                }
            )
        }
    }
    
    func startStoryTimer() {
        currentStoryIndex = 0
        storyProgress = 0
        isNavbarButton = true
        
        storyTimer?.invalidate()
        storyTimer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { _ in
            if self.isPaused { return }
            
            storyProgress += 0.005
            
            if storyProgress >= 1.0 {
                storyProgress = 0
                currentStoryIndex += 1
                
                if currentStoryIndex >= 4 {
                    stopStoryTimer()
                    showStory = false
                }
            }
        }
    }
    
    func pauseTimer() {
        self.isPaused = self.isPaused == true ? false : true
    }
    
    func stopStoryTimer() {
        storyTimer?.invalidate()
        storyTimer = nil
        isNavbarButton = false
    }
}

// MARK: - Preview Provider
#Preview {
    ProfileContentView()
}
