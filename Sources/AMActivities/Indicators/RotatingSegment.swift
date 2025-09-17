import SwiftUI

struct RotatingSegment: View {
  @State private var rotation: Angle = .degrees(0)
  @Binding private var isAnimating: Bool

  private let animationDuration: Double
  private let gradientColors: [Color]
  private let lineWidth: CGFloat
  private let segmentLength: CGFloat = 0.25
  private let strokeStyle: StrokeStyle

  /// A rotating segment spinner with optional gradient stroke.
  ///
  /// - Parameters:
  ///   - isAnimating: Binds animation state. When `true`, the segment rotates continuously.
  ///   - gradientColors: Colors for the arc’s gradient. Use one color (e.g., `[.blue]`) for solid stroke.
  ///   - animationDuration: Time in seconds for one full rotation. Defaults to 1.5.
  ///   - size: Predefined or custom size of the spinner. Defaults to `.medium`.
  ///   - lineWidth: Stroke width of the arc and background circle. Defaults to 6.
  /// Example usage:
  /// ```
  /// @State private var isLoading = true
  /// AMRotatingSegment(isAnimating: $isLoading)
  /// ```
  init(
    isAnimating: Binding<Bool> = .constant(true),
    gradientColors: [Color] = [.blue, .purple, .pink, .blue],
    animationDuration: Double = 1.5,
    lineWidth: CGFloat = 6,
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
        segmentedAnimation
      }
    }
  }

  private var segmentedAnimation: some View {
    Circle()
      .trim(from: 0, to: segmentLength)
      .stroke(style: strokeStyle)
      .foregroundStyle(
        AngularGradient(
          colors: gradientColors,
          center: .center
        )
      )
      .rotationEffect(rotation + .degrees(-90))
      .animation(
        Animation.linear(duration: animationDuration)
          .repeatForever(autoreverses: false),
        value: rotation
      )
      .onChange(of: isAnimating, initial: true) { _, _ in
        guard isAnimating else { return }
        rotation = isAnimating ? .degrees(360) : .degrees(0)
      }
  }
}

#Preview {
  RotatingSegment(
    isAnimating: .constant(true),
    gradientColors: [.blue, .purple, .pink, .blue],
    animationDuration: 1.5,
    lineWidth: 6,
  )
  .frame(width: 100, height: 100)
}
