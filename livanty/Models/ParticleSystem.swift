//
//  ParticleSystem.swift
//  livanty
//
//  Created by M Naufal Badruttamam on 13/05/25.
//
import SwiftUI
import Combine

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

  func start(with colors: [Color], screenSize: CGSize, count: Int = 30) {
    self.colors = colors
    self.screenSize = screenSize

    particles.removeAll()
    
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

  func update(maxSpeed: Double = 1.5) {
    for i in 0..<particles.count {
      let actualSpeed = min(particles[i].speed, maxSpeed)
      
      particles[i].position.x += particles[i].direction.x * CGFloat(actualSpeed)
      particles[i].position.y += particles[i].direction.y * CGFloat(actualSpeed)

      if particles[i].position.x < 0 || particles[i].position.x > screenSize.width {
        particles[i].direction.x *= -1
        particles[i].position.x = max(0, min(screenSize.width, particles[i].position.x))
      }

      if particles[i].position.y < 0 || particles[i].position.y > screenSize.height {
        particles[i].direction.y *= -1
        particles[i].position.y = max(0, min(screenSize.height, particles[i].position.y))
      }

      if Int.random(in: 0...100) < 3 {
        particles[i].opacity = Double.random(in: 0.1...0.3)
      }
    }
  }

  func updateColors(with newColors: [Color]) {
    self.colors = newColors
  }
  
  func reduceParticles(to count: Int) {
    if particles.count > count {
      particles = Array(particles.prefix(count))
    }
  }
}
