//
//  ParticleSystem.swift
//  livanty
//
//  Created by M Naufal Badruttamam on 13/05/25.
//
import SwiftUI
import Combine

// Sistem partikel untuk latar belakang dinamis dengan optimasi
class ParticleSystem {
  var particles: [Particle] = []
  var colors: [Color] = []
  var screenSize: CGSize = .zero

  struct Particle: Identifiable {
    let id: Int
    var position: CGPoint
    var size: CGFloat
    var opacity: Double
    var speed: Double
    var direction: CGPoint
  }

  // Metode diperbarui untuk mendukung jumlah partikel yang dapat dikonfigurasi
  func start(with colors: [Color], screenSize: CGSize, count: Int = 30) {
    self.colors = colors
    self.screenSize = screenSize

    // Hapus partikel yang ada
    particles.removeAll()
    
    // Initialize particles dengan jumlah yang dapat dikonfigurasi
    for i in 0..<count {
      let particle = Particle(
        id: i,
        position: CGPoint(
          x: CGFloat.random(in: 0...screenSize.width),
          y: CGFloat.random(in: 0...screenSize.height)
        ),
        size: CGFloat.random(in: 5...15),
        opacity: Double.random(in: 0.1...0.3),
        speed: Double.random(in: 0.5...1.5),
        direction: CGPoint(
          x: CGFloat.random(in: -1...1),
          y: CGFloat.random(in: -1...1)
        )
      )
      particles.append(particle)
    }
  }

  // Metode diperbarui untuk mendukung kecepatan maksimum yang berbeda
  func update(maxSpeed: Double = 1.5) {
    // Update posisi partikel dengan optimasi
    for i in 0..<particles.count {
      // Terapkan batas kecepatan berdasarkan parameter
      let actualSpeed = min(particles[i].speed, maxSpeed)
      
      // Pindahkan partikel dengan kecepatan yang sesuai
      particles[i].position.x += particles[i].direction.x * CGFloat(actualSpeed)
      particles[i].position.y += particles[i].direction.y * CGFloat(actualSpeed)

      // Pantul dari dinding dengan optimasi cek yang lebih efisien
      if particles[i].position.x < 0 || particles[i].position.x > screenSize.width {
        particles[i].direction.x *= -1
        // Koreksi posisi untuk menghindari pantul berulang
        particles[i].position.x = max(0, min(screenSize.width, particles[i].position.x))
      }

      if particles[i].position.y < 0 || particles[i].position.y > screenSize.height {
        particles[i].direction.y *= -1
        // Koreksi posisi untuk menghindari pantul berulang
        particles[i].position.y = max(0, min(screenSize.height, particles[i].position.y))
      }

      // Sesekali ubah opacity dengan peluang yang lebih rendah (3% daripada 5%)
      if Int.random(in: 0...100) < 3 {
        particles[i].opacity = Double.random(in: 0.1...0.3)
      }
    }
  }

  func updateColors(with newColors: [Color]) {
    self.colors = newColors
  }
  
  // Method untuk mengurangi jumlah partikel secara dinamis
  func reduceParticles(to count: Int) {
    if particles.count > count {
      particles = Array(particles.prefix(count))
    }
  }
}
