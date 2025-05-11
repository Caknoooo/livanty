import SwiftUI

// MARK: - Track Model
struct Track: Identifiable {
    let id = UUID()
    let title: String
    let artist: String
    let imageName: String
    let songFile: String
    let lyrics: String
    let FeaturedSong: String
}

// MARK: - Main View
struct Profile: View {
    @State private var selectedTrack: Int = 0
    @State private var isPlaying: Bool = false
    
    let tracks = [
        Track(title: "Born to Be", artist: "Dreamers", imageName: "GrayBox", songFile: "summer_vibes.mp3", lyrics: "From the bustling streets of Makassar to the warm embrace of family, Felicia's roots are deeply anchored in her hometown. This song celebrates the unique blend of culture and personality she carries — a city that birthed her dreams and fueled her drive. The rhythm is a mix of energy and nostalgia, like the vibrant markets and rain-soaked afternoons that shaped who she is. With a heart full of hope and a head full of aspirations, this track is the anthem of someone who will always carry her beginnings with her, no matter where she goes.", FeaturedSong: "Trust In God - Elevation Worship"),
        
        Track(title: "The City of Heroes", artist: "Bruce Wayne", imageName: "GrayBox", songFile: "summer_vibes.mp3", lyrics: "Life has a funny way of changing course, and for Felicia, that meant pivoting from a law degree to finding her true calling in the world of communication. This song is a journey of self-discovery, of breaking free from the expectations that once seemed like her destiny. With a playful beat and a hint of rebellion, it's the sound of embracing unexpected paths and finding joy in the unknown. A celebration of growth, change, and the boldness it takes to redefine your future.", FeaturedSong: "Trust In God"),
        
        Track(title: "Kodaks and Fujifilms", artist: "1998", imageName: "GrayBox", songFile: "summer_vibes.mp3", lyrics: "Behind every captivating film is more than just a script or camera angles — it's the wardrobe that brings the characters to life. This song is Felicia's love letter to the power of costume design in storytelling. It's the upbeat, fashion-forward jam that makes you think of those key moments in movies where a single outfit says more than words ever could. With energetic beats and a playful flair, it's a reminder that sometimes, the right outfit makes all the difference in how we see ourselves and others.", FeaturedSong: "Trust In God"),
        
        Track(title: "Java Chip", artist: "Cozy Crew", imageName: "GrayBox", songFile: "TrustInGod.mp3", lyrics: "Whether it's strolling around the city with a cup of javachip in hand or diving into late-night conversations about life, love, and everything in between, this track captures the essence of Felicia's favorite moments. The melody flows like an easy-going chat with a close friend, heartfelt and easy to listen to, with each word leaving a lasting impression. It's the perfect song to accompany those quiet moments where you reflect on life's big questions — and maybe snack on something sweet along the way.", FeaturedSong: "Trust In God"),
        
        Track(title: "The Man Above", artist: "The Mystics", imageName: "GrayBox", songFile: "TrustInGod.mp3", lyrics: "Faith runs deep for Felicia, and this track is all about finding strength in her belief and her purpose. Inspired by the verse from Colossians 3:23, this song is a declaration of living with intention, giving your best, and always putting your heart into everything you do. With a gentle yet empowering rhythm, it's the soundtrack to Felicia's life motto: work for something bigger than yourself and do it with joy.", FeaturedSong: "Trust In God - Elevation Worship"),
        
        Track(title: "Overthinker's Anthem", artist: "The Deep Thinkers", imageName: "GrayBox", songFile: "summer_vibes.mp3", lyrics: "Part extrovert, part introvert, Felicia's mind is always racing with thoughts, feelings, and reflections on everything from casual conversations to deep existential musings. This track is a cathartic release for anyone who spends a little too much time in their head. With a smooth yet reflective melody, it captures that feeling of replaying moments, analyzing every word, and navigating the space between self-doubt and self-assurance. It's a song for the overthinkers — a reminder that it's okay to feel all the feels.", FeaturedSong: "Trust In God"),
        
        Track(title: "Second Child", artist: "Lady Love", imageName: "GrayBox", songFile: "summer_vibes.mp3", lyrics: "Felicia's family is her rock, and this track is a tribute to the two people who shaped her life the most: her mother and her brother. With a warm, soulful tune, it's a celebration of the values they instilled in her — resilience, discipline, faith, and ambition. This song is about being guided by wisdom and love, and it's the perfect anthem for anyone who's been blessed with family who builds you up and helps you navigate life's challenges.", FeaturedSong: "Trust In God"),
        
        Track(title: "Dream On", artist: "Dreamers", imageName: "GrayBox", songFile: "summer_vibes.mp3", lyrics: "Felicia's future is all about creating and managing meaningful projects, but more than that, she's dreaming of a life filled with love, connection, and family. This track is an ode to those aspirations, capturing the heart of someone who strives to make a difference in the world while building a loving home. With an optimistic beat and a hopeful tone, it's about following your dreams, building a legacy, and one day raising a family that reflects all of the love and care she's put into the world.", FeaturedSong: "Trust In God")
    ]

    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color.white, Color(red: 1.0, green: 0.1, blue: 0.6)]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()

                VStack {
                    ScrollView {
                        Image("GrayBox")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 250, height: 250)
                            .opacity(0.9)
                            .offset(y: -9)
                            .padding(.top, 20)

                        VStack(alignment: .leading, spacing: 24) {
                            Text("🎧 Felicia's Playlist")
                                .font(.largeTitle).bold()
                                .foregroundColor(.black)
                                .padding(.top, 30)

                            HStack(spacing: 8) {
                                Image("GrayBox")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20, height: 20)
                                    .clipShape(Circle())
                                    .opacity(0.9)

                                Text("Wilkez")
                                    .font(.body)
                                    .foregroundColor(.black)
                            }

                            ForEach(tracks.indices, id: \.self) { index in
                                Button(action: {
                                    selectedTrack = index
                                    isPlaying = true
                                }) {
                                    NavigationLink(destination:
                                        TrackSwipeView(
                                            tracks: tracks,
                                            initialTrackIndex: index,  // Pass the current index
                                            selection: $selectedTrack,
                                            isPlaying: $isPlaying
                                        )
                                    ) {
                                        HStack(spacing: 16) {
                                            Image(tracks[index].imageName)
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: 80, height: 80)
                                                .cornerRadius(10)
                                            
                                            VStack(alignment: .leading) {
                                                Text(tracks[index].title)
                                                    .font(.headline)
                                                    .foregroundColor(.black)
                                                
                                                Text(tracks[index].artist)
                                                    .font(.body)
                                                    .foregroundColor(.black)
                                            }
                                            .frame(maxWidth: .infinity, alignment: .leading)

                                            // Show a playing indicator for the currently selected track
                                            if selectedTrack == index && isPlaying {
                                                Image(systemName: "speaker.wave.3.fill")
                                                    .foregroundColor(.pink)
                                                    .font(.title3)
                                                    .padding(.trailing, 8)
                                            }
                                        }
                                        .padding()
                                        .background(
                                            RoundedRectangle(cornerRadius: 16)
                                                .fill(selectedTrack == index ? Color.white.opacity(0.95) : Color.white)
                                                .shadow(color: selectedTrack == index ? Color.pink.opacity(0.5) : Color.clear, radius: 4)
                                        )
                                    }
                                }
                            }
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 70) // Add padding at the bottom for the mini player
                    }
                    
                    Spacer()
                }
                
                // MARK: - Mini Player (Always Visible at Bottom)
                VStack {
                    Spacer()
                    // Mini player
                    HStack {
                        Image(tracks[selectedTrack].imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .cornerRadius(8)
                        
                        VStack(alignment: .leading) {
                            Text(tracks[selectedTrack].title)
                                .font(.subheadline).bold()
                                .foregroundColor(.white)
                            
                            Text(tracks[selectedTrack].artist)
                                .font(.caption)
                                .foregroundColor(.white.opacity(0.7))
                        }
                        .padding(.leading, 8)
                        
                        Spacer()
                        
                        Button(action: {
                            isPlaying.toggle()
                        }) {
                            Image(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill")
                                .resizable()
                                .frame(width: 35, height: 35)
                                .foregroundColor(.white)
                        }
                        
                        Button(action: {
                            if selectedTrack < tracks.count - 1 {
                                selectedTrack += 1
                            }
                        }) {
                            Image(systemName: "forward.fill")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.white)
                        }
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.black.opacity(0.7))
                            .shadow(color: Color.pink.opacity(0.3), radius: 5, x: 0, y: -3)
                    )
                    .cornerRadius(20)
                    .padding(.horizontal)
                    .padding(.bottom, 8)
                }
            }
        }
    }
}

struct TrackSwipeView: View {
    let tracks: [Track]
    let initialTrackIndex: Int  // Initial track index to display
    @Binding var selection: Int
    @Binding var isPlaying: Bool
    @State private var currentTime: TimeInterval = 0
    @State private var duration: TimeInterval = 180
    
    // Navigation environment variable
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color.white, Color(red: 1.0, green: 0.1, blue: 0.6)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack {
                ScrollView {
                    VStack(spacing: 0) {
                        // MARK: - Header
                        ZStack {
                            HStack {
                                Button(action: {
                                    presentationMode.wrappedValue.dismiss() // Go back to previous screen
                                }) {
                                    Image(systemName: "chevron.left")
                                        .foregroundColor(.black)
                                        .font(.title2)
                                }
                                Spacer()
                            }
                            .padding(.horizontal)
                            
                            Text("Felicia's Playlist")
                                .font(.title2).bold()
                                .foregroundColor(.black)
                                .frame(maxWidth: .infinity)
                            
                            Spacer() // Maintain spacing on the right
                        }
                        .padding(.bottom, 10)
                        .navigationBarBackButtonHidden(true)
                        .navigationBarHidden(true)
                        
                        // TabView with Tracks
                        TabView(selection: $selection) {
                            ForEach(tracks.indices, id: \.self) { index in
                                VStack(spacing: 10) {
                                    Spacer()
                                    
                                    Image(tracks[index].imageName)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 300, height: 300)
                                        .cornerRadius(20)
                                        .shadow(radius: 10)
                                    
                                    Text(tracks[index].title)
                                        .font(.title2).bold()
                                        .foregroundColor(.white)
                                        .padding(.top, 10)
                                    
                                    Text(tracks[index].artist)
                                        .font(.subheadline)
                                        .foregroundColor(.white.opacity(0.7))
                                    
                                    Spacer()
                                }
                                .tag(index)
                            }
                        }
                        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                        .frame(height: 420)
                        .onAppear {
                            // Set selection to initialTrackIndex when view appears
                            selection = initialTrackIndex
                        }
                        .onChange(of: selection) { newValue in
                            // Reset time when changing tracks
                            currentTime = 0
                        }
                    }
                    
                    // MARK: - Player Controls
                    VStack(spacing: 20) {
                        Slider(value: $currentTime, in: 0...duration)
                            .accentColor(.black)
                            .padding(.horizontal, 20)
                            .disabled(true) // Since we're just doing UI, disable actual interaction
                        
                        HStack {
                            Text(timeString(from: currentTime))
                            Spacer()
                            Text(timeString(from: duration))
                        }
                        .foregroundColor(.black.opacity(0.6))
                        .font(.caption)
                        .padding(.horizontal, 20)
                        
                        HStack(spacing: 40) {
                            Button(action: {
                                if selection > 0 {
                                    selection -= 1
                                }
                            }) {
                                Image(systemName: "backward.fill")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .padding(.bottom, 20)
                                    .foregroundColor(.white)
                            }
                            
                            Button(action: { isPlaying.toggle() }) {
                                Image(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill")
                                    .resizable()
                                    .frame(width: 70, height: 70)
                                    .padding(.bottom, 20)
                                    .foregroundColor(.white)
                            }
                            
                            Button(action: {
                                if selection < tracks.count - 1 {
                                    selection += 1
                                }
                            }) {
                                Image(systemName: "forward.fill")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .padding(.bottom, 20)
                                    .foregroundColor(.white)
                            }
                        }
                        .foregroundColor(.black)
                        
                        // MARK: - Lyrics Section 1
                        VStack(spacing: 10) {
                            Text("Lyrics")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding(.bottom, 5)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            ForEach(tracks[selection].lyrics.components(separatedBy: "\n"), id: \.self) { line in
                                Text(line)
                                    .foregroundColor(.white)
                                    .font(.body)
                                    .padding(.vertical, 2)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.pink.opacity(0.9))
                        )
                        .padding(.horizontal)
                        
                        // MARK: - Featured Song Section
                        VStack(spacing: 10) {
                            Text("Featured Song")
                                .font(.headline)
                                .foregroundColor(.pink)
                                .padding(.bottom, 5)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            ForEach(tracks[selection].FeaturedSong.components(separatedBy: "\n").reversed(), id: \.self) { line in
                                Text(line)
                                    .foregroundColor(.black)
                                    .font(.body)
                                    .padding(.vertical, 2)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.white.opacity(0.7))
                        )
                        .padding(.horizontal)
                        .padding(.bottom, 80) // Add padding for mini player
                    }
                }
                
                Spacer()
            }
            
            // MARK: - Mini Player (Always Visible at Bottom)
            VStack {
                Spacer()
                // Mini player
                HStack {
                    Image(tracks[selection].imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .cornerRadius(8)
                    
                    VStack(alignment: .leading) {
                        Text(tracks[selection].title)
                            .font(.subheadline).bold()
                            .foregroundColor(.white)
                        
                        Text(tracks[selection].artist)
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.7))
                    }
                    .padding(.leading, 8)
                    
                    Spacer()
                    
                    Button(action: {
                        isPlaying.toggle()
                    }) {
                        Image(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill")
                            .resizable()
                            .frame(width: 35, height: 35)
                            .foregroundColor(.white)
                    }
                    
                    Button(action: {
                        if selection < tracks.count - 1 {
                            selection += 1
                        }
                    }) {
                        Image(systemName: "forward.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.white)
                    }
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.black.opacity(0.7))
                        .shadow(color: Color.pink.opacity(0.3), radius: 5, x: 0, y: -3)
                )
                .cornerRadius(20)
                .padding(.horizontal)
                .padding(.bottom, 8)
            }
        }
    }
    
    // Helper for time display
    private func timeString(from time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%d:%02d", minutes, seconds)
    }
}

// MARK: - Preview
#Preview {
    Profile()
}
