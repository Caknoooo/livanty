//
//  ProfileActionButtonsView.swift
//  livanty
//
//  Created by M Naufal Badruttamam on 11/05/25.
//

import SwiftUI

struct ProfileActionButtonsView: View {
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
        .padding(.horizontal)
    }
}

#Preview {
    ProfileActionButtonsView()
}
