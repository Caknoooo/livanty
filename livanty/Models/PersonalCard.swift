//
//  PersonalCard.swift
//  livanty
//
//  Created by M Naufal Badruttamam on 13/05/25.
//

import SwiftUI

// Model untuk kartu personal dengan properti tambahan untuk optimasi performa
struct PersonalCard: Identifiable {
  var id: Int
  var title: String
  var subtitle: String
  var gradientColors: [Color]
  var mainIcon: String
  var backgroundPatternIcons: [String]
  var imageName: String
  var description: String
  var achievements: [Achievements]
  var stats: [Stat]
  var quote: String
  var particleCount: Int // Menambahkan kontrol jumlah partikel per kartu
}

// Model untuk pencapaian
struct Achievements: Identifiable {
  var id: Int
  var title: String
  var description: String
  var icon: String
  var color: Color
}

// Model untuk statistik
struct Stat {
  var value: String
  var label: String
}
