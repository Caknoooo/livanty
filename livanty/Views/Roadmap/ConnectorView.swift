//
//  ConnectorView.swift
//  livanty
//
//  Created by M Naufal Badruttamam on 11/05/25.
//

import SwiftUI

struct ConnectorView: View {
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                let height = geometry.size.height
                
                path.move(to: CGPoint(x: 25, y: 0))
                path.addLine(to: CGPoint(x: 25, y: height))
            }
            .stroke(Color.primaryOrange, style: StrokeStyle(lineWidth: 2, dash: [4, 4]))
        }
    }
}

#Preview {
    ConnectorView()
        .frame(height: 100)
}
