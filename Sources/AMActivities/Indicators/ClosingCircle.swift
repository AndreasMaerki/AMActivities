import SwiftUI

struct ClosingCircle: View {
  @State private var progress: CGFloat = 0.0
  @State private var rotation: Angle = .degrees(0)

  private let animationDuration: Double
  private let arcLength: CGFloat = 1.1
  private let lineWidth: CGFloat
  private let strokeStyle: StrokeStyle

  /// Initializes the activity indicator.
  /// - Parameters:
  ///   - animationDuration: The duration of one full rotation cycle in seconds. Affects spin speed.
  ///   - lineWidth: The line width of the circle.
  /// Example usage:
  /// ```
  /// ClosingCircle(gradientColors: [.blue, .purple, .pink])
  /// ```
  init(
    animationDuration: Double,
    lineWidth: CGFloat
  ) {
    self.animationDuration = animationDuration
    self.lineWidth = lineWidth

    strokeStyle = StrokeStyle(
      lineWidth: lineWidth,
      lineCap: .round,
      lineJoin: .round
    )
  }

  var body: some View {
    ZStack {
      Group {
        Circle()
          .stroke(style: strokeStyle)
          .opacity(0.2)
        closingAnimation
      }
    }
  }

  private var closingAnimation: some View {
    Circle()
      .trim(from: 0, to: progress * arcLength)
      .stroke(style: strokeStyle)
      .rotationEffect(.degrees(-90)) // Start from the top
      .animation(
        Animation.linear(duration: animationDuration)
          .repeatForever(autoreverses: false),
        value: progress
      )
      .onAppear {
        progress = 1.0
      }
  }
}

#Preview {
  ClosingCircle(
    animationDuration: 1.5,
    lineWidth: 6
  )
  .foregroundStyle(
    AngularGradient(colors: [.blue, .purple, .pink, .blue], center: .center)
  )
  .frame(width: 50, height: 50)
}
