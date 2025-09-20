import SwiftUI

struct ClosingCircle: View {
  @State private var progress: CGFloat = 0.0
  @State private var rotation: Angle = .degrees(0)
  @Binding private var isAnimating: Bool

  private let animationDuration: Double
  private let arcLength: CGFloat = 1.1
  private let gradientColors: [Color]
  private let lineWidth: CGFloat
  private let strokeStyle: StrokeStyle

  /// Initializes the activity indicator.
  /// - Parameters:
  ///   - isAnimating: A binding to control the animation state. When `true`, the spinner rotates continuously.
  ///   - gradientColors:  An array of colors for the angular gradient stroke. Inject a single color,i.e. `[.blue] `for no gradient.
  ///   - animationDuration: The duration of one full rotation cycle in seconds. Affects spin speed.
  ///   - lineWidth: The line width of the circle.
  /// Example usage:
  /// ```
  /// @State private var isLoading = true
  /// ClosingCircle(isAnimating: $isLoading)
  /// ```
  init(
    isAnimating: Binding<Bool>,
    gradientColors: [Color],
    animationDuration: Double,
    lineWidth: CGFloat
  ) {
    _isAnimating = isAnimating
    self.gradientColors = gradientColors
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
          .foregroundStyle(
            AngularGradient(
              colors: gradientColors,
              center: .center
            )
            .opacity(0.2)
          )
        closingAnimation
      }
    }
  }

  private var closingAnimation: some View {
    Circle()
      .trim(from: 0, to: progress * arcLength)
      .stroke(style: strokeStyle)
      .foregroundStyle(
        AngularGradient(
          colors: gradientColors,
          center: .center
        )
      )
      .rotationEffect(.degrees(-90)) // Start from the top
      .animation(
        Animation.linear(duration: animationDuration)
          .repeatForever(autoreverses: false),
        value: progress
      )
      .onChange(of: isAnimating, initial: true) { _, _ in
        progress = isAnimating ? 1.0 : 0.0
      }
  }
}

#Preview {
  ClosingCircle(
    isAnimating: .constant(true),
    gradientColors: [.blue, .purple, .pink, .blue],
    animationDuration: 1.5,
    lineWidth: 6,
  )
  .frame(width: 50, height: 50)
}
