import SwiftUI

struct TrimmedCircle: View {
  @Binding private var isAnimating: Bool
  @State private var rotation = false

  private let gradientColors: [Color]
  private let lineWidth: CGFloat
  private let animationDuration: Double
  private let circleTrim: CGFloat

  /// Creates a new `SimpleGradientSpinner`, a circular gradient-based activity indicator.
  ///
  /// - Parameters:
  ///   - isAnimating: A binding that controls whether the spinner rotates. Defaults to `true`.
  ///   - gradientColors: The colors of the angular gradient applied to the spinner stroke. Defaults to `[.blue, .purple, .pink, .yellow, .blue]`. Inject a single color,i.e. `[.blue] `for no gradient.
  ///   - size: The spinner size, defined by `AMActivityIndicatorSize` (e.g. `.small`, `.medium`, `.large`). Defaults to `.medium`.
  ///   - circleTrim: The fraction of the circle’s circumference that is drawn (0.0–1.0). Smaller values create a "gap" in the spinner. Defaults to `0.8`.
  ///   - animationDuration: The duration, in seconds, for one full rotation. Defaults to `1.0`.
  ///   - lineWidth: The thickness of the spinner stroke. Defaults to `6`.
  init(
    isAnimating: Binding<Bool> = .constant(true),
    gradientColors: [Color] = [.blue, .purple, .pink, .yellow, .blue],
    circleTrim: CGFloat = 0.8,
    animationDuration: Double = 1.0,
    lineWidth: CGFloat = 6
  ) {
    _isAnimating = isAnimating
    self.gradientColors = gradientColors
    self.lineWidth = lineWidth
    self.circleTrim = circleTrim
    self.animationDuration = animationDuration
  }

  var body: some View {
    Circle()
      .trim(from: 0, to: circleTrim)
      .stroke(
        AngularGradient(
          gradient: .init(colors: gradientColors),
          center: .center
        ),
        style: .init(lineWidth: lineWidth, lineCap: .round)
      )
      .rotationEffect(.degrees(rotation ? 360 : 0))
      .onChange(of: isAnimating, initial: true) { _, _ in
        guard isAnimating else { return }
        withAnimation(
          Animation.linear(duration: animationDuration)
            .repeatForever(autoreverses: false)
        ) {
          rotation.toggle()
        }
      }
  }
}

#Preview {
  TrimmedCircle(isAnimating: .constant(true))
}
