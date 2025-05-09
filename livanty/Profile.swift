
import SwiftUI

struct ProfileView: View {
    var body: some View {
        ScrollView (.vertical){
            VStack (spacing: 20) {
                // PROFILE IMAGES
                Circle()
                    .frame(width: 135)
                    .offset(y: -100)
                
                // NAME & INFO
                VStack {
                    Text("Juan Hubert")
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .offset(y: -95)
                        .font(.system(size: 24, weight:.bold))
                    
                    Text("Healing itu ga perlu jauh, yang penting kebersamaannya!")
                        .offset(y: -90)
                }
                .multilineTextAlignment(.center)
                
                
                //FUN FACT
                RoundedRectangle(cornerRadius:15)
                        .frame(height: 90)
                        .foregroundStyle(.gray)
                        .offset(y:-85)
                
                //WISHLIST
                Text("Top 3 Wishlist")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(size: 20, weight:.bold))
                
                HStack{
                    Rectangle()
                        .frame(width: 115, height: 115)
                    Rectangle()
                        .frame(width: 115, height: 115)
                    Rectangle()
                        .frame(width: 115, height: 115)
                }
            }
            .padding()
            .offset(y: 75)
            .background(
                RoundedRectangle(cornerRadius: 160)
                    .fill(Color.white)
                    .shadow(color: .black.opacity(0.1), radius: 10, x:0, y:-5)
                    .frame(width:410, height:700)
                    .offset(y:140)
            )
        }
    }
}

#Preview {
    ProfileView()
}
