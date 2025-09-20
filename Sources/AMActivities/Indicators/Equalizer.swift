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

struct Equalizer: View {
  let count: Int
  let cornerRadius: CGFloat = 3
  let minScale: CGFloat
  let maxScale: CGFloat
  let animationDuration: Double
  let alignment: EqualizerBarAlignment
  let direction: EqualizerDirection
  let randomizeAnimation: Bool
  let gradient: LinearGradient

  /// Creates a new animated equalizer view with configurable bar count, scaling,
  /// animation behavior, alignment, orientation, and gradient styling.
  ///
  /// The equalizer is composed of a series of animated bars that repeatedly scale
  /// between a minimum and maximum height (or width, for horizontal orientation).
  /// You can customize the number of bars, how they animate, and how they are styled
  /// with a gradient fill.
  ///
  /// - Parameters:
  ///   - count: The total number of bars to display in the equalizer.
  ///   - minScale: The scale factor that defines the minimum bar height (or width).
  ///     Typically a value between `0` and `1`. For example, `0.3` means bars shrink
  ///     to 30% of their full size during animation.
  ///   - maxScale: The scale factor that defines the maximum bar height (or width).
  ///     Usually `1.0` for full size, but larger values are possible for amplified effect.
  ///   - animationDuration: The base duration (in seconds) of one animation cycle,
  ///     before repeating. A lower value yields faster animation.
  ///   - gradientColors: An array of `Color` values used to construct a vertical
  ///     `LinearGradient` fill for the bars.
  ///   - alignment: The vertical alignment of bar scaling, specified with
  ///     ``EqualizerBarAlignment`` (e.g. `.top`, `.center`, `.bottom`).
  ///   - direction: The orientation of the equalizer, specified with
  ///     ``EqualizerDirection`` (either `.vertical` or `.horizontal`).
  ///   - randomizeAnimation: A Boolean value that controls whether each bar uses
  ///     unique randomized timing (delays/durations). When `false`, bars animate
  ///     with deterministic staggered timing.
  ///
  /// Example:
  /// ```swift
  /// Equalizer(
  ///     count: 5,
  ///     minScale: 0.3,
  ///     maxScale: 1.0,
  ///     animationDuration: 0.7,
  ///     gradientColors: [.blue, .green],
  ///     alignment: .center,
  ///     direction: .vertical,
  ///     randomizeAnimation: false
  /// )
  /// .frame(width: 100, height: 50)
  /// ```
  public init(
    count: Int,
    minScale: CGFloat,
    maxScale: CGFloat,
    animationDuration: Double,
    gradientColors: [Color],
    alignment: EqualizerBarAlignment,
    direction: EqualizerDirection,
    randomizeAnimation: Bool
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
          EqualizerBar(
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

private struct EqualizerBar: View {
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
  Equalizer(
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
