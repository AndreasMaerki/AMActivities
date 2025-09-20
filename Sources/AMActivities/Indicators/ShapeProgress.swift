import SwiftUI

// MARK: - Type Eraser for Shape

public struct AnyShape: Shape {
  private let _path: @Sendable (CGRect) -> Path

  init(_ shape: some Shape) {
    _path = { rect in shape.path(in: rect) }
  }

  public func path(in rect: CGRect) -> Path {
    _path(rect)
  }
}

public enum ShapeProgressShapeType {
  case sparklesShape
  case starShape
  case diamondShape
  case fancyDiamondShape
  case flareFlowerShape
  case custom(AnyShape)
  case none

  var shape: AnyShape? {
    switch self {
    case .sparklesShape: AnyShape(SparklesShape())
    case .starShape: AnyShape(StarShape())
    case .diamondShape: AnyShape(DiamondShape())
    case .fancyDiamondShape: AnyShape(FancyDiamondShape())
    case .flareFlowerShape: AnyShape(FlareFlowerShape())
    case let .custom(customShape): customShape
    case .none: nil
    }
  }
}

struct ShapeProgress: View {
  @State private var startPosition: CGFloat = 0.0
  @State private var endPositionS1: CGFloat = 0.03
  @State private var endPositionS2S3: CGFloat = 0.06

  static let initialDegree: Angle = .degrees(270)
  @State private var rotationDegreeS1 = initialDegree
  @State private var rotationDegreeS2 = initialDegree
  @State private var rotationDegreeS3 = initialDegree

  @State private var drawingDirectionToggle = false
  @State private var initialRotation = true

  private let fullRotation: Angle = .degrees(360)
  private let animationTime: Double = 2.5
  let lineWidth: Double

  let gradient: AngularGradient

  let shape: ShapeProgressShapeType

  /// Creates a new `ShapeProgress` view with a customizable gradient, line width, and shape.
  ///
  /// This initializer lets you configure the appearance of the animated progress indicator
  /// by providing a list of gradient colors, the stroke thickness, and the shape to render.
  /// The shape is chosen through the `ShapeProgress.ShapeType` enum, which includes
  /// built‑in options like `.starShape`, `.diamondShape`, and `.flareFlowerShape`,
  /// as well as a `.custom` case for injecting your own `Shape`.
  ///
  /// - Parameters:
  ///   - gradientColors: The array of colors used to build the `AngularGradient`
  ///     that styles the progress indicator’s stroke.
  ///   - lineWidth: The thickness of the shape’s stroke in points.
  ///   - shape: A `ShapeProgress.ShapeType` case defining which shape to display.
  ///
  /// Example:
  /// ```swift
  /// ShapeProgress(
  ///     gradientColors: [.blue, .purple, .pink],
  ///     lineWidth: 4,
  ///     shape: .starShape
  /// )
  /// ```
  init(gradientColors: [Color], lineWidth: Double, shape: ShapeProgressShapeType) {
    gradient = AngularGradient(colors: gradientColors, center: .center)
    self.lineWidth = lineWidth
    self.shape = shape
  }

  var body: some View {
    ZStack {
      SpinnerCircle(
        start: startPosition,
        end: endPositionS2S3,
        rotation: rotationDegreeS3,
        opacity: 0.3,
        lineWidth: lineWidth
      )
      .opacity(0.3)

      SpinnerCircle(
        start: startPosition,
        end: endPositionS2S3,
        rotation: rotationDegreeS2,
        opacity: 0.5,
        lineWidth: lineWidth
      )
      .opacity(0.5)

      SpinnerCircle(
        start: startPosition,
        end: endPositionS1,
        rotation: rotationDegreeS1,
        opacity: 1,
        lineWidth: lineWidth
      )

      if let shape = shape.shape {
        shape
          .stroke(style: StrokeStyle(
            lineWidth: lineWidth,
            lineCap: .round,
            lineJoin: .round
          ))
          .opacity(0.1)
          .scaledToFit()
          .scaleEffect(0.9)

        shape
          .trim(from: drawingDirectionToggle ? 0 : 1, to: 1)
          .stroke(style: StrokeStyle(
            lineWidth: lineWidth,
            lineCap: .round,
            lineJoin: .round
          ))
          .scaledToFit()
          .scaleEffect(0.9)
      }
    }
    .foregroundStyle(gradient)
    .onAppear {
      Timer.scheduledTimer(withTimeInterval: animationTime, repeats: true) { _ in
        Task { @MainActor in
          animateSpinner()
        }
      }.fire()

      withAnimation(.easeInOut(duration: animationTime).repeatForever(autoreverses: true)) {
        drawingDirectionToggle.toggle()
      }
    }
  }

  private func animateSpinner() {
    animateSpinner(with: initialRotation ? 0 : animationTime / 2) {
      endPositionS1 = 1.0
    }
    initialRotation = false

    animateSpinner(with: animationTime - 0.025) {
      rotationDegreeS1 += fullRotation
      endPositionS2S3 = 0.8
    }

    animateSpinner(with: animationTime) {
      endPositionS1 = 0.03
      endPositionS2S3 = 0.03
    }

    animateSpinner(with: animationTime + 0.0525) {
      rotationDegreeS2 += fullRotation
    }

    animateSpinner(with: animationTime + 0.225) {
      rotationDegreeS3 += fullRotation
    }
  }

  private func animateSpinner(with timeInterval: Double, completion: @escaping @MainActor () -> Void) {
    Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: false) { _ in
      Task { @MainActor in
        withAnimation(Animation.easeInOut(duration: animationTime / 2)) {
          completion()
        }
      }
    }
  }
}

private struct SpinnerCircle: View {
  var start: CGFloat
  var end: CGFloat
  var rotation: Angle
  var opacity: Double
  var lineWidth: CGFloat

  var body: some View {
    Circle()
      .trim(from: start, to: end)
      .stroke(style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
      .rotationEffect(rotation)
  }
}

#Preview {
  ShapeProgress(gradientColors: [.blue, .yellow, .pink, .blue], lineWidth: 4, shape: .fancyDiamondShape)
    .frame(width: 200, height: 200)
}
