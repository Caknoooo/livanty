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
                        HStack(alignment: .top) {
                            ZStack {
                                Image(systemName: "person.fill")
                                    .resizable()
                                    .padding(2)
                                    .frame(width: 84, height: 84)
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
                            }
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Livanty Efatania Dendy")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                
                                Text("Universitas Ciputra • Student")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                
                                HStack {
                                    Image(systemName: "location")
                                        .foregroundColor(.gray)
                                    Text("Surabaya")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                                .padding(.top, 2)
                            }
                            .padding(.leading, 8)
                        }
                        .border(Color.gray, width: 1) //
                        .padding()
                        
                        // Action buttons
                        HStack(spacing: 12) {
                            Button(action: {}) {
                                HStack {
                                    Image(systemName: "trophy")
                                    Text("Achievement")
                                }
                                .padding(.horizontal, 20)
                                .padding(.vertical, 10)
                                .background(.primaryOrange)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                            }
                            
                            ForEach(["instagram_logo", "linkedin_logo", "apple_logo"], id: \.self) { imageName in
                                Button(action: {}) {
                                    Image(imageName)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 20, height: 20)
                                        .frame(width: 40, height: 40)
                                        .background(Color.gray.opacity(0.1))
                                        .foregroundColor(.orange)
                                        .cornerRadius(8)
                                }
                            }
                        }
                        .border(Color.gray, width: 1) //
                        .padding(.horizontal)
                        
                        VStack(spacing: 8) {
                            HStack(spacing: 8) {
                                FoodTagView(emoji: "🏸", text: "Badminton")
                                FoodTagView(emoji: "🏀", text: "Basket")
                                FoodTagView(emoji: "🏃", text: "Lari")
                            }
                            
                            HStack(spacing: 10) {
                                FoodTagView(emoji: "🎬", text: "Nonton")
                                FoodTagView(emoji: "👨‍🍳", text: "Masak")
                            }
                        }
                        .border(Color.gray, width: 1) //
                        .padding(.vertical, 8)
                        
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
                            .border(Color.gray, width: 1) //
                            .padding(.horizontal)
                            
                            ZigzagRoadmapView()
                        }
                        
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

struct FoodTagView: View {
    let emoji: String
    let text: String
    
    var body: some View {
        HStack(spacing: 4) {
            Text(emoji)
            Text(text)
                .font(.system(size: 14))
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                .background(Color.white)
        )
    }
}

struct BottomTabBar: View {
    var body: some View {
        HStack(spacing: 0) {
            ForEach(["house", "person.crop.circle"], id: \.self) { icon in
                Button(action: {}) {
                    VStack(spacing: 2) {
                        Image(systemName: icon)
                            .font(.system(size: 30))
                            .foregroundColor(icon == "person.crop.circle" ? .primaryOrange : .black)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                }
            }
        }
        .background(Color.white)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: -2)
    }
}

struct ZigzagRoadmapView: View {
    let activities = [
        Activity(name: "Pagi", title: "Kuliah", description: "Bangun pukul 7 pagi dan mengikuti perkuliahan hingga siang hari", icon: "sunrise.fill"),
        Activity(name: "Siang", title: "Apple Academy", description: "Berpartisipasi dalam kegiatan Apple Academy dengan penuh semangat", icon: "applelogo"),
        Activity(name: "Sore", title: "Olahraga", description: "Menjaga gaya hidup sehat dengan bermain badminton, basket, atau berlari", icon: "figure.run"),
        Activity(name: "Malam", title: "Freelance & Organisasi", description: "Aktif dalam organisasi dan menyelesaikan tanggung jawab sebagai freelancer", icon: "laptopcomputer")
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach(0..<activities.count, id: \.self) { index in
                ActivityItemView(activity: activities[index], showConnector: index < activities.count - 1)
            }
        }
        .border(Color.gray, width: 1) //
        .padding(.horizontal)
    }
}

struct Activity: Identifiable {
    let id = UUID()
    let name: String
    let title: String
    let description: String
    let icon: String
    
    var storyContent: String {
        switch title {
        case "Kuliah":
            return "Setiap pagi aku bangun jam 7, menyiapkan diri dengan semangat untuk kuliah di Universitas Ciputra. Kampusku memiliki lingkungan yang inspiratif dan dosen-dosen yang supportif. Aku mengambil jurusan yang aku minati dan selalu berusaha aktif di kelas, berdiskusi dengan teman-teman, dan mengerjakan tugas dengan penuh dedikasi. Jadwal kuliah yang padat membuatku belajar mengelola waktu dengan baik."
        case "Apple Academy":
            return "Siang hari adalah waktu berharga di Apple Academy. Ini adalah kesempatan emas untuk belajar pengembangan aplikasi dari para ahli industri. Di sini, aku berkolaborasi dengan teman-teman berbakat dalam project inovatif, dari ide hingga implementasi. Setiap sesi di Academy memperluas pengetahuanku tentang teknologi Apple dan mengajarkanku cara berpikir 'think different' ala Apple. Pengalaman ini sangat berharga untuk karirku ke depan."
        case "Olahraga":
            return "Sore hari adalah waktu untuk bergerak! Aku sangat menikmati bermain badminton dan basket dengan teman-teman. Terkadang aku juga berlari di sekitar kampus atau taman kota untuk menjaga kebugaran. Olahraga bukan hanya tentang kesehatan fisik bagiku, tapi juga cara untuk refreshing pikiran setelah seharian belajar. Momen-momen ini juga memperkuat persahabatan dengan teman-teman sepermainan."
        case "Freelance & Organisasi":
            return "Malam hari adalah waktuku untuk mengembangkan skill profesional dan sosial. Sebagai freelancer, aku mengerjakan berbagai proyek desain dan pengembangan aplikasi yang menantang. Selain itu, keterlibatanku dalam organisasi kampus mengajarkan leadership dan teamwork. Meski jadwalku padat, aku selalu menikmati setiap tanggung jawab karena passion yang kumiliki. Ini semua membentuk jati diriku yang multitalenta."
        default:
            return ""
        }
    }
    
    var storyBackgroundName: String {
        switch title {
        case "Kuliah": return "campus_background"
        case "Apple Academy": return "apple_academy_background"
        case "Olahraga": return "sports_background"
        case "Freelance & Organisasi": return "work_background"
        default: return ""
        }
    }
}

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
                StraightConnectorView()
                    .frame(height: 24)
            }
        }
    }
}

struct StraightConnectorView: View {
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                let height = geometry.size.height
                
                path.move(to: CGPoint(x: 25, y: 0))
                path.addLine(to: CGPoint(x: 25, y: height))
            }
            .stroke(Color.primaryOrange, style: StrokeStyle(lineWidth: 2, dash: [4, 4]))
        }
    }
}

// Story View untuk fitur Story Telling
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

struct ProgressBar: View {
    var progress: CGFloat
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .foregroundColor(Color.white.opacity(0.3))
                    .cornerRadius(2)
                
                Rectangle()
                    .foregroundColor(.white)
                    .frame(width: geometry.size.width * progress)
                    .cornerRadius(2)
            }
        }
        .frame(height: 4)
    }
}

struct FAQItem: Identifiable {
    let id = UUID()
    let question: String
    let answer: String
    var isExpanded: Bool = false
}

struct FAQView: View {
    @State private var faqItems: [FAQItem] = [
        FAQItem(
            question: "What is Livanty's daily routine?",
            answer: "Livanty follows a disciplined daily routine. She sleeps from 12 AM to 7 AM, attends university classes until afternoon, participates in Apple Academy activities during the afternoon, and dedicates her evenings to organizational activities and freelance responsibilities."
        ),
        FAQItem(
            question: "What sports does Livanty enjoy?",
            answer: "Livanty maintains a healthy lifestyle by regularly playing badminton, basketball, and running with her younger sibling. These activities help her stay fit and balanced despite her busy schedule."
        ),
        FAQItem(
            question: "What roles does Livanty have in organizations?",
            answer: "Livanty holds important positions in various organizations. She serves as the Finance and Fundraising Coordinator for the Student Union ISB and as Treasurer for the Leadcamp 2025 committee."
        ),
        FAQItem(
            question: "What is Livanty's personality type?",
            answer: "Livanty has an ENFJ-T personality type. This aligns with her friendly, open, and sociable nature, making her easily accepted in any environment and a pleasant companion for discussions and collaborations."
        ),
        FAQItem(
            question: "How does Livanty manage her busy schedule?",
            answer: "Livanty excels at time management, balancing university classes, Apple Academy activities, organizational roles, freelance work, and regular exercise. Her disciplined approach to scheduling allows her to remain productive despite having multiple commitments."
        ),
        FAQItem(
            question: "What makes Livanty inspirational?",
            answer: "Livanty's combination of leadership spirit, strong work ethic, and excellent time management makes her inspirational. She consistently fulfills her responsibilities across academics, organizations, and professional work while maintaining a healthy lifestyle."
        )
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("FAQ")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.black)
                .padding(.top, 24)
                .padding(.bottom, 10)
            
            LazyVStack(alignment: .leading, spacing: 0) {
                ForEach(0..<faqItems.count, id: \.self) { index in
                    FAQItemView(
                        item: $faqItems[index]
                    )
                    
                    if index < faqItems.count - 1 {
                        Divider()
                            .padding(.horizontal)
                    }
                }
            }
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.white)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.gray.opacity(0.2), lineWidth: 1)
            )
        }
        .border(Color.gray, width: 1) //
        .padding(.horizontal)
        .padding(.bottom, 30)
    }
}

struct FAQItemView: View {
    @Binding var item: FAQItem
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Button(action: {
                withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                    item.isExpanded.toggle()
                }
            }) {
                HStack(alignment: .center) {
                    Text(item.question)
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.black)
                        .multilineTextAlignment(.leading)
                        .padding(.vertical, 16)
                    
                    Spacer()
                    
                    Image(systemName: "chevron.down")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(Color.primaryOrange)
                        .rotationEffect(Angle(degrees: item.isExpanded ? 180 : 0))
                        .frame(width: 24, height: 24)
                }
            }
            .buttonStyle(PlainButtonStyle())
            .padding(.horizontal)
            
            if item.isExpanded {
                Text(item.answer)
                    .font(.system(size: 15))
                    .foregroundColor(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.horizontal)
                    .padding(.bottom, 16)
                    .transition(.opacity.combined(with: .move(edge: .top)))
            }
        }
        .background(item.isExpanded ? Color.gray.opacity(0.05) : Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    ContentView()
}
