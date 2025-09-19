import SwiftUI

public enum EqualizerBarAlignment {
  case top
  case center
  case bottom

  var anchor: UnitPoint {
    switch self {
    case .top: .top
    case .center: .center
    case .bottom: .bottom
    }
  }
}

public enum EqualizerDirection {
  case vertical
  case horizontal
}

struct EqualizerIndicator: View {
  let count: Int
  let cornerRadius: CGFloat = 3
  let minScale: CGFloat
  let maxScale: CGFloat
  let animationDuration: Double
  let alignment: EqualizerBarAlignment
  let direction: EqualizerDirection
  let randomizeAnimation: Bool
  let gradient: LinearGradient

  public init(
    count: Int = 5,
    minScale: CGFloat = 0.3,
    maxScale: CGFloat = 1.0,
    animationDuration: Double = 0.7,
    gradientColors: [Color] = [.blue, .green],
    alignment: EqualizerBarAlignment = .center,
    direction: EqualizerDirection = .vertical,
    randomizeAnimation: Bool = false
  ) {
    self.count = count
    self.minScale = minScale
    self.maxScale = maxScale
    self.animationDuration = animationDuration
    gradient = LinearGradient(
      colors: gradientColors,
      startPoint: .top,
      endPoint: .bottom
    )
    self.alignment = alignment
    self.direction = direction
    self.randomizeAnimation = randomizeAnimation
  }

  var body: some View {
    GeometryReader { geo in
      let size = geo.size
      let isHorizontal = direction == .horizontal
      let mainLength = isHorizontal ? size.height : size.width
      let crossLength = isHorizontal ? size.width : size.height

      // Calculate bar width and spacing
      let spacingRatio: CGFloat = 0.6
      let barWidth = mainLength / (CGFloat(count) + spacingRatio * CGFloat(count - 1))
      let spacing = barWidth * spacingRatio

      HStack(alignment: .center, spacing: spacing) {
        ForEach(0 ..< count, id: \.self) { index in
          EqualizerBarView(
            index: index,
            count: count,
            cornerRadius: cornerRadius,
            minScale: minScale,
            maxScale: maxScale,
            animationDuration: animationDuration,
            alignment: alignment,
            randomizeAnimation: randomizeAnimation
          )
          .frame(width: barWidth, height: crossLength)
        }
      }
      .frame(width: size.width, height: size.height)
      .foregroundStyle(gradient)
      .rotationEffect(isHorizontal ? .degrees(90) : .zero)
    }
  }
}

private struct EqualizerBarView: View {
  let index: Int
  let count: Int
  let cornerRadius: CGFloat
  let minScale: CGFloat
  let maxScale: CGFloat
  let animationDuration: Double
  let alignment: EqualizerBarAlignment
  let randomizeAnimation: Bool

  @State private var scale: CGFloat = 1.0

  var anchor: UnitPoint {
    alignment.anchor
  }

  var body: some View {
    let delay: Double = randomizeAnimation
      ? Double.random(in: 0 ... (animationDuration / 2))
      : Double(index) * animationDuration / Double(count)

    let duration: Double = randomizeAnimation
      ? Double.random(in: animationDuration * 0.7 ... animationDuration * 1.3)
      : animationDuration

    RoundedRectangle(cornerRadius: cornerRadius)
      .scaleEffect(CGSize(width: 1, height: scale), anchor: anchor)
      .onAppear {
        let base = Animation.easeInOut(duration: duration)
          .repeatForever(autoreverses: true)
          .delay(delay)
        scale = maxScale
        withAnimation(base) {
          scale = minScale
        }
      }
  }
}

#Preview {
  EqualizerIndicator(
    count: 5,
    minScale: 0.3,
    maxScale: 1.0,
    animationDuration: 0.7,
    gradientColors: [.blue, .green],
    alignment: .center,
    direction: .vertical,
    randomizeAnimation: false
  )
  .frame(width: 100, height: 50)
}
