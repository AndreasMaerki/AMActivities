import SwiftUI

struct AMClosingCircle: View {
  @State private var progress: CGFloat = 0.0
  @State private var rotation: Angle = .degrees(0)
  @Binding private var isAnimating: Bool

  private let animationDuration: Double
  private let arcLength: CGFloat = 1.1
  private let gradientColors: [Color]
  private let size: Size
  private let lineWidth: CGFloat
  private let strokeStyle: StrokeStyle

  enum Size {
    case small
    case medium
    case large
    case xLarge
    case custom(CGSize)

    var value: CGSize {
      switch self {
      case .small:
        .init(width: 32, height: 32)
      case .medium:
        .init(width: 48, height: 48)
      case .large:
        .init(width: 56, height: 56)
      case .xLarge:
        .init(width: 64, height: 64)
      case let .custom(size):
        size
      }
    }
  }

  /// Initializes the activity indicator.
  /// - Parameters:
  ///   - isAnimating: A binding to control the animation state. When `true`, the spinner rotates continuously. Defaults to `.constant(true)` for immediate animation on appearance.
  ///   - gradientColors:  An array of colors for the angular gradient stroke. Defaults to `[.blue, .purple, .pink, .blue]`. Inject a single color,i.e. `[.blue] `for no gradient.
  ///   - animationDuration: The duration of one full rotation cycle in seconds. Affects spin speed. Defaults to `1.5`.
  ///   - size: Determines the size of the indicator. Use .custom to define your own
  ///   - lineWidth: The line width of the circle.
  /// Example usage:
  /// ```
  /// @State private var isLoading = true
  /// FancyActivityIndicator(isAnimating: $isLoading)
  /// ```
  init(
    isAnimating: Binding<Bool> = .constant(true),
    gradientColors: [Color] = [.blue, .purple, .pink, .blue],
    animationDuration: Double = 1.5,
    size: Size = .medium,
    lineWidth: CGFloat = 6,
  ) {
    _isAnimating = isAnimating
    self.gradientColors = gradientColors
    self.animationDuration = animationDuration
    self.size = size
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
      .frame(width: size.value.width, height: size.value.height)
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
  AMClosingCircle()
}
