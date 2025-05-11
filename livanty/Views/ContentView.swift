import SwiftUI

struct ContentView: View {
    @State private var showStory = false
    @State private var currentStoryIndex = 0
    @State private var storyProgress: CGFloat = 0
    @State private var storyTimer: Timer?
    @State private var isPaused = false
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                VStack() {
                    HStack {
                        Text("livantyefatania_")
                            .font(.title)
                        Spacer()
                        Image(systemName: "gearshape.fill")
                    }
                    .padding()
                    
                    Spacer()
                    
                    VStack(spacing: 16) {
                        ProfileHeaderView()
                        ProfileActionButtonsView()
                        ProfileTagsView()
                        ProfileJourneyView(
                            showStory: $showStory,
                            startStoryTimer: startStoryTimer
                        )
                        FAQView()
                    }
                }
            }
            // Bottom tab bar
            .overlay(
                BottomTabBar(),
                alignment: .bottom
            )
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
    }
}

#Preview {
    ContentView()
}
