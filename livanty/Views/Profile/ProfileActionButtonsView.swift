import SwiftUI

struct SocialButton: View {
    let socialMedia: SocialMedia
    
    var body: some View {
        Link(destination: socialMedia.url) {
            Image(socialMedia.imageName)
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

struct ProfileActionButtonsView: View {
    let socialMedias: [SocialMedia] = [
        SocialMedia(
            imageName: "instagram_logo",
            url: URL(string: "https://instagram.com/livantyefatania_")!
        ),
        SocialMedia(
            imageName: "linkedin_logo",
            url: URL(string: "https://www.linkedin.com/in/livanty-efatania-dendy-392986304/")!
        ),
        SocialMedia(
            imageName: "apple_logo",
            url: URL(string: "https://developer.apple.com/")!
        )
    ]
    
    var body: some View {
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
            ForEach(socialMedias) { socialMedia in
                SocialButton(socialMedia: socialMedia)
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    ProfileActionButtonsView()
}
