import SwiftUI

public enum SpokeType: Sendable {
  case bar
  case circle
  case ellipse
}

struct FlickerRing: View {
  let count: Int
  let animationDuration: Double
  let spokeType: SpokeType

  var body: some View {
    GeometryReader { geometry in
      TimelineView(.animation(minimumInterval: nil)) { timeline in
        let phase = (
          timeline.date.timeIntervalSinceReferenceDate.truncatingRemainder(
            dividingBy: animationDuration
          )
        ) / animationDuration

        ZStack {
          ForEach(0 ..< count, id: \.self) { index in
            FlickeringBarItem(
              index: index,
              count: count,
              size: geometry.size,
              globalPhase: phase,
              type: spokeType
            )
          }
        }
        .frame(width: geometry.size.width, height: geometry.size.height)
      }
    }
  }
}

private struct FlickeringBarItem: View {
  let index: Int
  let count: Int
  let size: CGSize
  let globalPhase: Double
  let type: SpokeType

  // MARK: Layout variables

  private var baseHeight: CGFloat { size.height / 3.8 }
  private var thickness: CGFloat { size.height / 10 }
  private var radius: CGFloat { size.width / 2 - baseHeight / 2 }

  // Rotation angle for each bar (CW)
  private var angle: CGFloat {
    2 * .pi / CGFloat(count) * CGFloat(index)
  }

  // Position around a circle
  private var position: CGPoint {
    CGPoint(
      x: radius * cos(angle),
      y: radius * sin(angle)
    )
  }

  // MARK: Opacity logic

  private var barPhase: Double {
    Double(index) / Double(count)
  }

  private var relativePhase: Double {
    var diff = globalPhase - barPhase
    if diff < 0 { diff += 1 }
    return diff
  }

  private var opacity: Double {
    let fadeRatio = 0.35 // Adjust this for fade length (0..1)

    if relativePhase < (1 - fadeRatio) {
      return 1.0
    } else if relativePhase < 1.0 {
      let progress = (relativePhase - (1 - fadeRatio)) / fadeRatio
      return (cos(progress * .pi) + 1) / 2
    } else {
      return 0.0
    }
  }

  // MARK: Height logic

  private var diminishedHeight: CGFloat {
    let minHeightRatio: CGFloat = 0.8
    let oscillation = (cos(relativePhase * .pi) + 1) / 2
    let currentRatio = minHeightRatio + (1 - minHeightRatio) * oscillation
    return baseHeight * currentRatio
  }

  var body: some View {
    Group {
      switch type {
      case .bar:
        Capsule()
          .frame(width: thickness, height: diminishedHeight)
          .rotationEffect(.radians(angle + .pi / 2))
      case .circle:
        Circle()
          .scale(0.9)
          .frame(width: diminishedHeight, height: diminishedHeight)
      case .ellipse:
        Ellipse()
          .frame(width: thickness, height: diminishedHeight)
          .rotationEffect(.radians(angle + .pi / 2))
      }
    }
    .opacity(opacity)
    .offset(x: position.x, y: position.y)
  }
}

#Preview {
  AngularGradient(colors: [.red, .blue, .yellow, .red], center: .center)
    .mask {
      FlickerRing(
        count: 10,
        animationDuration: 1,
        spokeType: .bar
      )
    }
    .frame(width: 300, height: 300)
}
