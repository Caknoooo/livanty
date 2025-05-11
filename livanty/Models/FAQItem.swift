//
//  FAQIten.swift
//  livanty
//
//  Created by M Naufal Badruttamam on 11/05/25.
//

import Foundation

struct FAQItem: Identifiable {
    let id = UUID()
    let question: String
    let answer: String
    var isExpanded: Bool = false
}
