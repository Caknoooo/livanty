//
//  StoryView.swift
//  livanty
//
//  Created by M Naufal Badruttamam on 11/05/25.
//

import SwiftUI

struct StoryView: View {
    @Binding var isPresented: Bool
    @Binding var currentIndex: Int
    @Binding var progress: CGFloat
    @Binding var isHold: Bool
    var stopTimer: () -> Void
    
    let activities = [
        Activity(name: "Pagi", title: "Kuliah", description: "Bangun pukul 7 pagi dan mengikuti perkuliahan hingga siang hari", icon: "sunrise.fill"),
        Activity(name: "Siang", title: "Apple Academy", description: "Berpartisipasi dalam kegiatan Apple Academy dengan penuh semangat", icon: "applelogo"),
        Activity(name: "Sore", title: "Olahraga", description: "Menjaga gaya hidup sehat dengan bermain badminton, basket, atau berlari", icon: "figure.run"),
        Activity(name: "Malam", title: "Freelance & Organisasi", description: "Aktif dalam organisasi dan menyelesaikan tanggung jawab sebagai freelancer", icon: "laptopcomputer")
    ]
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
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
                }
                .edgesIgnoringSafeArea(.all)
                
                VStack {
                    HStack(spacing: 4) {
                        ForEach(0..<activities.count, id: \.self) { index in
                            ProgressBar(progress: index == currentIndex ? progress : (index < currentIndex ? 1 : 0))
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 10)
                    
                    // Story content
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
                            
                            // Konten cerita
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
                            
                        }
                        .padding(.bottom, 10)
                    }
                }
                
                // Tap areas to navigate
                HStack {
                    // Left area - previous story
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
                    
                    // Middle area - pause/play
                    Rectangle()
                        .fill(Color.clear)
                        .frame(width: geometry.size.width / 3)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            isHold = isHold == false ? true : false
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
                        .padding()
                    }
                    Spacer()
                }
            }.frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
}

struct StoryViewPreview: PreviewProvider {
    @State static var isPresented = true
    @State static var currentIndex = 0
    @State static var progress: CGFloat = 0.5
    @State static var isHold = false
    
    static var previews: some View {
        StoryView(
            isPresented: $isPresented,
            currentIndex: $currentIndex,
            progress: $progress,
            isHold: $isHold,
            stopTimer: {}
        )
    }
}
