//
//  BottomBar.swift
//  livanty
//
//  Created by M Naufal Badruttamam on 11/05/25.
//

import SwiftUI

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

#Preview {
    BottomTabBar()
}
