import SwiftUI

struct ProfileContentView: View {
    @State private var showStory = false
    @State private var currentStoryIndex = 0
    @State private var storyProgress: CGFloat = 0
    @State private var isStoryHold = false
    
    var body: some View {
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
                        currentStoryIndex = 0
                        storyProgress = 0
                        isStoryHold = false
                    }
                )
                    .padding(.horizontal)
                FAQView()
                    .padding(.horizontal)
                    .padding(.bottom, 60)
            }
        }
        .navigationTitle("@livantyefatania_")
        .navigationBarTitleDisplayMode(.inline)
        .tint(Color.primaryOrange)
        .fullScreenCover(isPresented: $showStory) {
            StoryFullScreenView(
                isPresented: $showStory,
                currentIndex: $currentStoryIndex,
                progress: $storyProgress,
                isHold: $isStoryHold
            )
        }
    }
}

struct ProfileContentView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileContentView()
    }
}
