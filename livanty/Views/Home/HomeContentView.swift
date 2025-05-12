//
//  HomeView.swift
//  livanty
//
//  Created by M Naufal Badruttamam on 12/05/25.
//

import SwiftUI

struct HomeContentView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Text("Home Screen")
                        .font(.largeTitle)
                        .padding()
                    
                    ForEach(0..<5) { index in
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.gray.opacity(0.2))
                            .frame(height: 100)
                            .padding(.horizontal)
                            .overlay(
                                Text("Content Item \(index + 1)")
                            )
                    }
                }
                .padding(.bottom, 20)
            }
            .navigationTitle("Home")
        }
    }
}

#Preview {
    HomeContentView()
}
