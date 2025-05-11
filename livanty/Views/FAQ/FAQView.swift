//
//  FAQView.swift
//  livanty
//
//  Created by M Naufal Badruttamam on 11/05/25.
//

import SwiftUI

struct FAQView: View {
    @State private var faqItems: [FAQItem] = [
        FAQItem(
            question: "What is Livanty's daily routine?",
            answer: "Livanty follows a disciplined daily routine. She sleeps from 12 AM to 7 AM, attends university classes until afternoon, participates in Apple Academy activities during the afternoon, and dedicates her evenings to organizational activities and freelance responsibilities."
        ),
        FAQItem(
            question: "What sports does Livanty enjoy?",
            answer: "Livanty maintains a healthy lifestyle by regularly playing badminton, basketball, and running with her younger sibling. These activities help her stay fit and balanced despite her busy schedule."
        ),
        FAQItem(
            question: "What roles does Livanty have in organizations?",
            answer: "Livanty holds important positions in various organizations. She serves as the Finance and Fundraising Coordinator for the Student Union ISB and as Treasurer for the Leadcamp 2025 committee."
        ),
        FAQItem(
            question: "What is Livanty's personality type?",
            answer: "Livanty has an ENFJ-T personality type. This aligns with her friendly, open, and sociable nature, making her easily accepted in any environment and a pleasant companion for discussions and collaborations."
        ),
        FAQItem(
            question: "How does Livanty manage her busy schedule?",
            answer: "Livanty excels at time management, balancing university classes, Apple Academy activities, organizational roles, freelance work, and regular exercise. Her disciplined approach to scheduling allows her to remain productive despite having multiple commitments."
        ),
        FAQItem(
            question: "What makes Livanty inspirational?",
            answer: "Livanty's combination of leadership spirit, strong work ethic, and excellent time management makes her inspirational. She consistently fulfills her responsibilities across academics, organizations, and professional work while maintaining a healthy lifestyle."
        )
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("FAQ")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.black)
                .padding(.top, 24)
                .padding(.bottom, 10)
            
            LazyVStack(alignment: .leading, spacing: 0) {
                ForEach(0..<faqItems.count, id: \.self) { index in
                    FAQItemView(
                        item: $faqItems[index]
                    )
                    
                    if index < faqItems.count - 1 {
                        Divider()
                            .padding(.horizontal)
                    }
                }
            }
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.white)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.gray.opacity(0.2), lineWidth: 1)
            )
        }
        .padding(.horizontal)
        .padding(.bottom, 30)
    }
}

#Preview {
    FAQView()
}
