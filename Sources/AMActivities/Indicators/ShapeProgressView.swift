import SwiftUI

struct ShapeProgressView: View {
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

  init(gradientColors: [Color], lineWidth: Double) {
    gradient = AngularGradient(colors: gradientColors, center: .center)
    self.lineWidth = lineWidth
  }

  var body: some View {
    ZStack {
      SpinnerCircle(
        start: startPosition,
        end: endPositionS2S3,
        rotation: rotationDegreeS3,
        opacity: 0.3,
        lineWidh: lineWidth
      )
      .opacity(0.3)

      SpinnerCircle(
        start: startPosition,
        end: endPositionS2S3,
        rotation: rotationDegreeS2,
        opacity: 0.5,
        lineWidh: lineWidth
      )
      .opacity(0.5)

      SpinnerCircle(
        start: startPosition,
        end: endPositionS1,
        rotation: rotationDegreeS1,
        opacity: 1,
        lineWidh: lineWidth
      )

      FancyDiamond()
        .stroke(style: StrokeStyle(
          lineWidth: lineWidth,
          lineCap: .round,
          lineJoin: .round
        ))
        .opacity(0.1)
        .scaledToFit()
        .scaleEffect(0.9)

      FancyDiamond()
        .trim(from: drawingDirectionToggle ? 0 : 1, to: 1)
        .stroke(style: StrokeStyle(
          lineWidth: lineWidth,
          lineCap: .round,
          lineJoin: .round
        ))
        .scaledToFit()
        .scaleEffect(0.9)
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
  var lineWidh: CGFloat

  var body: some View {
    Circle()
      .trim(from: start, to: end)
      .stroke(style: StrokeStyle(lineWidth: lineWidh, lineCap: .round))
      .rotationEffect(rotation)
  }
}

#Preview {
  ShapeProgressView(gradientColors: [.blue, .yellow, .pink, .blue], lineWidth: 4)
    .frame(width: 200, height: 200)
}
