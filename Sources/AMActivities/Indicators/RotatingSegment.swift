import SwiftUI

struct RotatingSegment: View {
  @State private var rotation: Angle = .degrees(0)

  private let animationDuration: Double
  private let lineWidth: CGFloat
  private let segmentLength: CGFloat = 0.25
  private let strokeStyle: StrokeStyle

  /// A rotating segment spinner.
  ///
  /// - Parameters:
  ///   - animationDuration: Time in seconds for one full rotation. Defaults to 1.5.
  ///   - size: Predefined or custom size of the spinner. Defaults to `.medium`.
  ///   - lineWidth: Stroke width of the arc and background circle. Defaults to 6.
  /// Example usage:
  /// ```
  /// RotatingSegment(
  ///   animationDuration: 1.5,
  ///   lineWidth: 6
  /// )
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
      Circle()
        .stroke(style: strokeStyle)
        .opacity(0.2)
      segmentedAnimation
    }
  }

  private var segmentedAnimation: some View {
    Circle()
      .trim(from: 0, to: segmentLength)
      .stroke(style: strokeStyle)
      .rotationEffect(rotation + .degrees(-90))
      .animation(
        Animation.linear(duration: animationDuration)
          .repeatForever(autoreverses: false),
        value: rotation
      )
      .onAppear {
        rotation = .degrees(360)
      }
  }
}

#Preview {
  RotatingSegment(
    animationDuration: 1.5,
    lineWidth: 6
  )
  .foregroundStyle(AngularGradient(colors: [.blue, .purple, .pink, .blue], center: .center))
  .frame(width: 100, height: 100)
}
