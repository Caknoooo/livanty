//
//  BottomBar.swift
//  livanty
//
//  Created by M Naufal Badruttamam on 11/05/25.
//

import SwiftUI

struct BottomTabBar: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeContentView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
                .tag(0)
            
            ProfileContentView()
                .tabItem {
                    Image(systemName: "person.crop.circle")
                    Text("Profile")
                }
                .tag(1)
        }
        .accentColor(.primaryOrange)
    }
}

#Preview {
    BottomTabBar()
}
