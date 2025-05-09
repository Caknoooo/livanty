//
//  Learning.swift
//  livanty
//
//  Created by M Naufal Badruttamam on 09/05/25.
//

import SwiftUI

struct Learning: View {
    var body: some View {
        
        HStack {
            VStack(alignment: .center) {
                Image("ArcSaber")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 150)
                Text("ArcSaber")
            }
            .padding()
            .border(Color.cyan, width: 2)
            
            VStack {
                Image("ArcSaber")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 150)
                Text("ArcSaber")
            }
            .padding()
            .border(Color.cyan, width: 2)
        }
        
        HStack {
            VStack {
                Image("ArcSaber")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 150)
                Text("ArcSaber")
            }
            .padding()
            .border(Color.cyan, width: 2)
            
            VStack {
                Image("ArcSaber")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 150)
                Text("ArcSaber")
            }
            .padding()
            .border(Color.cyan, width: 2)
        }
        
        HStack {
            VStack {
                Image("ArcSaber")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 150)
                Text("ArcSaber")
            }
            .padding()
            .border(Color.cyan, width: 2)
            
            VStack {
                Image("ArcSaber")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 150)
                Text("ArcSaber")
            }
            .padding()
            .border(Color.cyan, width: 2)
        }
        
    }
}

#Preview {
    Learning()
}
