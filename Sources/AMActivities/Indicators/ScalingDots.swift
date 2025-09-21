import SwiftUI

/// An animated row of scaling dots.
///
/// `ScalingDots` creates a sequence of dots that continuously scale up and down
/// in size to produce a pulsing or "bouncing" animation effect.
/// The animation can be deterministic (staggered delays) or randomized to create
/// a more dynamic, organic motion.
///
/// - Parameters:
///   - count: The number of dots to display. For example, `3` produces a classic
///     pulsing typing indicator.
///   - spacing: The amount of horizontal spacing between each dot, in points.
///   - randomize: A Boolean flag that controls whether each dot uses randomized
///     delays and durations (`true`) or evenly staggered deterministic values (`false`).
///   - animationDuration: The base duration (in seconds) for one scale animation cycle.
///     Lower values make the scaling faster; higher values make it slower.
///
/// Example:
/// ```swift
/// ScalingDots(
///     count: 3,
///     spacing: 12,
///     randomize: false,
///     animationDuration: 0.6
/// )
/// .frame(width: 250, height: 50)
/// ```
///
/// Example with randomized animation:
/// ```swift
/// ScalingDots(
///     count: 3,
///     spacing: 12,
///     randomize: true,
///     animationDuration: 0.5
/// )
/// .frame(width: 250, height: 50)
/// ```
struct ScalingDots: View {
  let count: Int
  let spacing: CGFloat
  let randomize: Bool
  let animationDuration: Double

  var body: some View {
    HStack(spacing: spacing) {
      ForEach(0 ..< count, id: \.self) { index in
        ScalingDot(
          index: index,
          count: count,
          randomize: randomize,
          duration: animationDuration
        )
      }
    }
  }
}

private struct ScalingDot: View {
  let index: Int
  let count: Int
  let randomize: Bool
  let duration: Double

  @State private var animate = false

  private var animationDelay: Double {
    randomize ? Double.random(in: 0 ... 0.8)
      : Double(index) * 0.2
  }

  private var animationDuration: Double {
    randomize ? Double.random(in: duration * 0.6 ... duration * 1.4)
      : duration
  }

  var body: some View {
    Circle()
      .scaleEffect(animate ? 0.4 : 1.0)
      .animation(
        .easeInOut(duration: animationDuration)
          .repeatForever()
          .delay(animationDelay),
        value: animate
      )
      .onAppear { animate = true }
  }
}

#Preview {
  VStack(spacing: 40) {
    LinearGradient(
      colors: [.red, .orange, .yellow, .green, .blue, .purple],
      startPoint: .leading,
      endPoint: .trailing
    ).mask {
      ScalingDots(
        count: 3,
        spacing: 12,
        randomize: false,
        animationDuration: 0.6
      )
      .frame(width: 250, height: 50)
    }

    LinearGradient(
      colors: [.red, .orange, .yellow, .green, .blue, .purple],
      startPoint: .leading,
      endPoint: .trailing
    ).mask {
      ScalingDots(
        count: 3,
        spacing: 12,
        randomize: true,
        animationDuration: 0.6
      )
      .frame(width: 250, height: 50)
    }
  }
}
