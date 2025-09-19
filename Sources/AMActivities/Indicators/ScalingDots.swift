import SwiftUI

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
