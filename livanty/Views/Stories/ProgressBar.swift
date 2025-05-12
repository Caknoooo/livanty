//
//  ProgressBar.swift
//  livanty
//
//  Created by M Naufal Badruttamam on 12/05/25.
//

import SwiftUI

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

#Preview {
    ProgressBar(progress: 0.7)
        .frame(width: 100)
        .padding()
        .background(Color.black)
}
