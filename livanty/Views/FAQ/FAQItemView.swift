//
//  FAQItemView.swift
//  livanty
//
//  Created by M Naufal Badruttamam on 11/05/25.
//

import SwiftUI

struct FAQItemView: View {
    @Binding var item: FAQItem
    
    var body: some View {
        Button(action: {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                item.isExpanded.toggle()
            }
        }) {
            VStack(alignment: .leading, spacing: 0) {
                HStack(alignment: .center) {
                    Text(item.question)
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.black)
                        .multilineTextAlignment(.leading)
                        .padding(.vertical, 16)
                    
                    Spacer()
                    
                    Image(systemName: "chevron.down")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(Color.primaryOrange)
                        .rotationEffect(Angle(degrees: item.isExpanded ? 180 : 0))
                        .frame(width: 24, height: 24)
                }
                .padding(.horizontal)
                
                if item.isExpanded {
                    Text(item.answer)
                        .font(.system(size: 15))
                        .foregroundColor(.secondary)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.horizontal)
                        .padding(.bottom, 16)
                        .transition(.opacity.combined(with: .move(edge: .top)))
                }
            }
            .frame(maxWidth: .infinity)
            .background(item.isExpanded ? Color.gray.opacity(0.05) : Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct FAQItemViewPreview: PreviewProvider {
    @State static var item = FAQItem(
        question: "What is Livanty's daily routine?",
        answer: "Livanty follows a disciplined daily routine...",
        isExpanded: true
    )
    
    static var previews: some View {
        FAQItemView(item: $item)
            .padding()
    }
}
