//
//  Achievement.swift
//  livanty
//
//  Created by M Naufal Badruttamam on 12/05/25.
//
import SwiftUI

struct Achievement: Identifiable {
    var id = UUID()
    var title: String
    var description: String
    var date: String
    var icon: String
    var isHighlighted: Bool = false
}
