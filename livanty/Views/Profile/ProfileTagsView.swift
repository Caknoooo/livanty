//
//  ProfileTagsView.swift
//  livanty
//
//  Created by M Naufal Badruttamam on 11/05/25.
//

import SwiftUI

struct ProfileTagsView: View {
    var body: some View {
        VStack(spacing: 8) {
            HStack(spacing: 8) {
                TagView(emoji: "🏸", text: "Badminton")
                TagView(emoji: "🏀", text: "Basket")
                TagView(emoji: "🏃", text: "Lari")
            }
            
            HStack(spacing: 10) {
                TagView(emoji: "🎬", text: "Nonton")
                TagView(emoji: "👨‍🍳", text: "Masak")
            }
        }
    }
}

#Preview {
    ProfileTagsView()
}
