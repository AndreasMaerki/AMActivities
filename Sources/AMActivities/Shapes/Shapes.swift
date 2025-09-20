import SwiftUI

/// A custom sparkle-like shape:
/// - A tall vertical diamond
/// - A wide horizontal diamond
/// - Four smaller diagonals for a hint of shimmer
struct SparklesShape: Shape {
  func path(in rect: CGRect) -> Path {
    var path = Path()

    let center = CGPoint(x: rect.midX, y: rect.midY)
    let long = min(rect.width, rect.height) * 0.45
    let short = long * 0.4
    let tiny = long * 0.2

    // Vertical diamond
    path.move(to: CGPoint(x: center.x, y: center.y - long))
    path.addLine(to: CGPoint(x: center.x + short, y: center.y))
    path.addLine(to: CGPoint(x: center.x, y: center.y + long))
    path.addLine(to: CGPoint(x: center.x - short, y: center.y))
    path.closeSubpath()

    // Horizontal diamond
    path.move(to: CGPoint(x: center.x - long, y: center.y))
    path.addLine(to: CGPoint(x: center.x, y: center.y - short))
    path.addLine(to: CGPoint(x: center.x + long, y: center.y))
    path.addLine(to: CGPoint(x: center.x, y: center.y + short))
    path.closeSubpath()

    // Top-left small diamond
    path.move(to: CGPoint(x: center.x - short, y: center.y - short))
    path.addLine(to: CGPoint(x: center.x, y: center.y - tiny))
    path.addLine(to: CGPoint(x: center.x + short, y: center.y - short))
    path.addLine(to: CGPoint(x: center.x, y: center.y - (short + tiny)))
    path.closeSubpath()

    // Bottom-right small diamond
    path.move(to: CGPoint(x: center.x + short, y: center.y + short))
    path.addLine(to: CGPoint(x: center.x, y: center.y + tiny))
    path.addLine(to: CGPoint(x: center.x - short, y: center.y + short))
    path.addLine(to: CGPoint(x: center.x, y: center.y + (short + tiny)))
    path.closeSubpath()

    return path
  }
}

struct StarShape: Shape {
  /// number of points (e.g. 5 for the classic star)
  var points: Int = 5

  func path(in rect: CGRect) -> Path {
    guard points >= 2 else { return Path() }

    let center = CGPoint(x: rect.midX, y: rect.midY)
    let radius = min(rect.width, rect.height) / 2
    let innerRadius = radius * 0.4 // adjust for "fatness" of the star

    var path = Path()

    // angle between star points
    let angleIncrement = .pi * 2 / Double(points)

    // start pointing upwards
    let startAngle = -Double.pi / 2

    var firstPoint: CGPoint? = nil

    for i in 0 ..< (points * 2) {
      // alternate between outer radius and inner radius
      let r = (i % 2 == 0) ? radius : innerRadius
      let angle = startAngle + Double(i) * (angleIncrement / 2)

      let pt = CGPoint(
        x: center.x + CGFloat(cos(angle) * r),
        y: center.y + CGFloat(sin(angle) * r)
      )

      if i == 0 {
        path.move(to: pt)
        firstPoint = pt
      } else {
        path.addLine(to: pt)
      }
    }

    // Close the star by coming back to first point
    if let firstPoint {
      path.addLine(to: firstPoint)
    }

    return path
  }
}

struct DiamondShape: Shape {
  func path(in rect: CGRect) -> Path {
    let center = CGPoint(x: rect.midX, y: rect.midY)
    let radius = min(rect.width, rect.height) / 2

    var path = Path()

    // start at the top point
    path.move(to: CGPoint(x: center.x, y: center.y - radius))

    // right
    path.addLine(to: CGPoint(x: center.x + radius, y: center.y))

    // bottom
    path.addLine(to: CGPoint(x: center.x, y: center.y + radius))

    // left
    path.addLine(to: CGPoint(x: center.x - radius, y: center.y))

    path.closeSubpath()
    return path
  }
}

struct FancyDiamondShape: Shape {
  func path(in rect: CGRect) -> Path {
    let w = rect.width
    let h = rect.height

    // Outer Points
    let top = CGPoint(x: w * 0.5, y: 0)
    let upperL = CGPoint(x: w * 0.2, y: h * 0.35)
    let upperR = CGPoint(x: w * 0.8, y: h * 0.35)
    let midL = CGPoint(x: w * 0.05, y: h * 0.65)
    let midR = CGPoint(x: w * 0.95, y: h * 0.65)
    let bottom = CGPoint(x: w * 0.5, y: h)

    var path = Path()

    // --- Outer diamond shape ---
    path.move(to: top)
    path.addLine(to: upperR)
    path.addLine(to: midR)
    path.addLine(to: bottom)
    path.addLine(to: midL)
    path.addLine(to: upperL)
    path.closeSubpath()

    // --- Facet lines ---
    // Top triangle facets
    path.move(to: top)
    path.addLine(to: CGPoint(x: w * 0.35, y: h * 0.35))
    path.move(to: top)
    path.addLine(to: CGPoint(x: w * 0.65, y: h * 0.35))

    // Cross line across top section
    path.move(to: upperL)
    path.addLine(to: upperR)

    // Inner cuts towards bottom
    path.move(to: upperL)
    path.addLine(to: bottom)
    path.move(to: upperR)
    path.addLine(to: bottom)

    return path
  }
}

import SwiftUI

struct FlareFlowerShape: Shape {
  var petals: Int = 8
  var petalRatio: CGFloat = 0.4 // how much the petals stick inward/outward

  func path(in rect: CGRect) -> Path {
    let center = CGPoint(x: rect.midX, y: rect.midY)
    let radius = min(rect.width, rect.height) / 2
    var path = Path()

    for i in 0 ..< petals {
      let angle = (Double(i) / Double(petals)) * (.pi * 2)
      let midAngle = angle + (.pi / Double(petals)) // halfway between points

      // Outer petal tip
      let outer = CGPoint(
        x: center.x + cos(angle) * radius,
        y: center.y + sin(angle) * radius
      )

      // Inner dip between petals
      let inner = CGPoint(
        x: center.x + cos(midAngle) * radius * petalRatio,
        y: center.y + sin(midAngle) * radius * petalRatio
      )

      if i == 0 {
        path.move(to: outer)
      } else {
        path.addLine(to: outer)
      }

      path.addLine(to: inner)
    }
    path.closeSubpath()

    return path
  }
}
