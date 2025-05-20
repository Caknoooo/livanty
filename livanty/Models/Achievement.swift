//
//  Achievement.swift
//  livanty
//
//  Created by M Naufal Badruttamam on 12/05/25.
//
import SwiftUI

struct Achievement: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let date: String
    let icon: String
    let isHighlighted: Bool
}
