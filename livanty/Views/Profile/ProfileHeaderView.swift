//
//  ProfileHeaderView.swift
//  livanty
//
//  Created by M Naufal Badruttamam on 11/05/25.
//

import SwiftUI

struct ProfileHeaderView: View {
    var body: some View {
        HStack(alignment: .top) {
            ZStack {
                Image("profile_photo")
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
    }
}

#Preview {
    ProfileHeaderView()
}
