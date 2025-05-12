//
//  HomeContentView.swift
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
                    // Tambahkan konten home di sini
                }
                .padding()
            }
            .navigationTitle("Home")
        }
    }
}

#Preview {
    HomeContentView()
}
