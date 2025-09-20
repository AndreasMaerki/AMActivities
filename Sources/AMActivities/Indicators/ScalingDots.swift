import SwiftUI

/// An animated row of scaling dots, styled with a horizontal gradient mask.
///
/// `ScalingDots` creates a sequence of dots that continuously scale up and down
/// in size to produce a pulsing or "bouncing" animation effect.
/// The animation can be deterministic (staggered delays) or randomized to create
/// a more dynamic, organic motion.
///
/// A horizontal `LinearGradient` fill is applied across the entire row of dots
/// and then masked to the animated dots, producing colorful effects.
///
/// - Parameters:
///   - count: The number of dots to display. For example, `3` produces a classic
///     pulsing typing indicator.
///   - spacing: The amount of horizontal spacing between each dot, in points.
///   - randomize: A Boolean flag that controls whether each dot uses randomized
///     delays and durations (`true`) or evenly staggered deterministic values (`false`).
///   - colors: An array of `Color` values used to create the `LinearGradient`
///     that fills the dots. Colors blend smoothly across the row.
///   - animationDuration: The base duration (in seconds) for one scale animation cycle.
///     Lower values make the scaling faster; higher values make it slower.
///
/// Example:
/// ```swift
/// ScalingDots(
///     count: 3,
///     spacing: 12,
///     randomize: false,
///     colors: [.red, .orange, .yellow, .green, .blue, .purple],
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
///     colors: [.pink, .cyan, .purple],
///     animationDuration: 0.5
/// )
/// .frame(width: 250, height: 50)
/// ```
struct ScalingDots: View {
  let count: Int
  let spacing: CGFloat
  let randomize: Bool
  let colors: [Color]
  let animationDuration: Double

  var body: some View {
    LinearGradient(
      gradient: Gradient(colors: colors),
      startPoint: .leading,
      endPoint: .trailing
    )
    .mask {
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
    ScalingDots(
      count: 3,
      spacing: 12,
      randomize: false,
      colors: [.red, .orange, .yellow, .green, .blue, .purple],
      animationDuration: 0.6
    )
    .frame(width: 250, height: 50)

    ScalingDots(
      count: 3,
      spacing: 12,
      randomize: true,
      colors: [.pink, .cyan, .purple],
      animationDuration: 0.5
    )
    .frame(width: 250, height: 50)
  }
}
