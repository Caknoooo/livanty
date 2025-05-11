//
//  ProgressBar.swift
//  livanty
//
//  Created by M Naufal Badruttamam on 11/05/25.
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
    ProgressBar(progress: 0.5)
        .frame(width: 100)
}
