//
//  StoryFullScreenView.swift
//  livanty
//
//  Created by M Naufal Badruttamam on 12/05/25.
//

import SwiftUI

struct StoryFullScreenView: View {
    @Binding var isPresented: Bool
    @Binding var currentIndex: Int
    @Binding var progress: CGFloat
    @Binding var isHold: Bool
    
    @State private var storyTimer: Timer?
    
    let activities = [
        Activity(name: "Morning", title: "College", description: "Wake up at 7 AM and attend lectures until noon", icon: "sunrise.fill"),
        Activity(name: "Afternoon", title: "Apple Academy", description: "Participate in Apple Academy activities with enthusiasm", icon: "applelogo"),
        Activity(name: "Evening", title: "Exercise", description: "Maintain a healthy lifestyle by playing badminton, basketball, or running", icon: "figure.run"),
        Activity(name: "Night", title: "Freelance & Organization", description: "Active in organizations and completing responsibilities as a freelancer", icon: "laptopcomputer")
    ]
    
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                ZStack {
                    if currentIndex < activities.count {
                        Image(activities[currentIndex].storyBackgroundName)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .clipped()
                            .overlay(
                                LinearGradient(
                                    gradient: Gradient(colors: [
                                        Color.black.opacity(0.7),
                                        Color.black.opacity(0.3),
                                        Color.black.opacity(0.7)
                                    ]),
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            )
                    }
                    
                    VStack {
                        Spacer()
                            .frame(height: 50)
                        
                        HStack(spacing: 4) {
                            ForEach(0..<activities.count, id: \.self) { index in
                                ProgressBar(progress: index == currentIndex ? progress : (index < currentIndex ? 1 : 0))
                            }
                        }
                        .padding(.horizontal)
                        
                        if currentIndex < activities.count {
                            VStack(alignment: .leading, spacing: 20) {
                                HStack {
                                    ZStack {
                                        Circle()
                                            .fill(Color.primaryOrange)
                                            .frame(width: 60, height: 60)
                                        
                                        Image(systemName: activities[currentIndex].icon)
                                            .font(.system(size: 30))
                                            .foregroundColor(.white)
                                    }
                                    
                                    VStack(alignment: .leading) {
                                        Text(activities[currentIndex].name)
                                            .font(.headline)
                                            .foregroundColor(.gray)
                                        
                                        Text(activities[currentIndex].title)
                                            .font(.title)
                                            .fontWeight(.bold)
                                            .foregroundColor(.white)
                                    }
                                    .padding(.leading, 10)
                                    
                                    Spacer()
                                }
                                .padding(.horizontal)
                                .padding(.top, 20)
                                
                                Spacer()
                                
                                ZStack(alignment: .center) {
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(Color.black.opacity(0.7))
                                        .padding(.horizontal)
                                    
                                    Text(activities[currentIndex].storyContent)
                                        .font(.body)
                                        .foregroundColor(.white)
                                        .multilineTextAlignment(.center)
                                        .padding(30)
                                }
                                .frame(height: geometry.size.height / 2.5)
                                .padding(.bottom, 50)
                            }
                        }
                    }
                    
                    HStack {
                        Rectangle()
                            .fill(Color.clear)
                            .frame(width: geometry.size.width / 3)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                if currentIndex > 0 {
                                    currentIndex -= 1
                                    progress = 0
                                }
                            }
                        
                        Rectangle()
                            .fill(Color.clear)
                            .frame(width: geometry.size.width / 3)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                isHold.toggle()
                            }
                            .overlay(
                                isHold ?
                                    Image(systemName: "pause.circle.fill")
                                        .font(.system(size: 50))
                                        .foregroundColor(.white.opacity(0.8))
                                    : nil
                            )
                        
                        Rectangle()
                            .fill(Color.clear)
                            .frame(width: geometry.size.width / 3)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                if currentIndex < activities.count - 1 {
                                    currentIndex += 1
                                    progress = 0
                                } else {
                                    stopTimer()
                                    isPresented = false
                                }
                            }
                    }
                    
                    VStack {
                        HStack {
                            Spacer()
                            
                            Button(action: {
                                stopTimer()
                                isPresented = false
                            }) {
                                Image(systemName: "xmark")
                                    .font(.system(size: 22, weight: .bold))
                                    .foregroundColor(.white)
                                    .padding(8)
                            }
                            .padding(.top, 60)
                            .padding(.trailing, 16)
                        }
                        Spacer()
                    }
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
            }
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            startTimer()
        }
        .onDisappear {
            stopTimer()
        }
    }
    
    func startTimer() {
        currentIndex = 0
        progress = 0
        
        storyTimer?.invalidate()
        storyTimer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { _ in
            if isHold { return }
            
            progress += 0.005
            
            if progress >= 1.0 {
                progress = 0
                currentIndex += 1
                
                if currentIndex >= activities.count {
                    stopTimer()
                    isPresented = false
                }
            }
        }
    }
    
    func stopTimer() {
        storyTimer?.invalidate()
        storyTimer = nil
    }
}

struct StoryFullScreenView_Previews: PreviewProvider {
    @State static var isPresented = true
    @State static var currentIndex = 0
    @State static var progress: CGFloat = 0.5
    @State static var isHold = false
    
    static var previews: some View {
        StoryFullScreenView(
            isPresented: $isPresented,
            currentIndex: $currentIndex,
            progress: $progress,
            isHold: $isHold
        )
    }
}
