import SwiftUI

public struct AMActivityIndicator: View {
  public enum SegmentType {
    case closingCircle(
      isAnimating: Binding<Bool> = .constant(true),
      gradientColors: [Color] = [.blue, .purple, .pink, .blue],
      animationDuration: Double = 1.5,
      lineWidth: CGFloat = 6,
    )
    case flickerRing(
      count: Int = 10,
      spokeType: SpokeType = .bar
    )
    case trimmedCircle(
      isAnimating: Binding<Bool> = .constant(true),
      gradientColors: [Color] = [.blue, .purple, .pink, .yellow, .blue],
      circleTrim: CGFloat = 0.8,
      animationDuration: Double = 1.0,
      lineWidth: CGFloat = 6
    )
    case rotatingSegment(
      isAnimating: Binding<Bool> = .constant(true),
      gradientColors: [Color] = [.blue, .purple, .pink, .blue],
      animationDuration: Double = 1.5,
      lineWidth: CGFloat = 6
    )
    case shapeProgressView(
      gradientColors: [Color] = [.blue, .purple, .pink, .blue],
      lineWidth: CGFloat = 4
    )
    case equalizer(
      count: Int = 5,
      minScale: CGFloat = 0.3,
      maxScale: CGFloat = 1.0,
      animationDuration: Double = 0.7,
      gradientColors: [Color] = [.purple, .pink, .yellow],
      alignment: EqualizerBarAlignment = .center,
      direction: EqualizerDirection = .vertical,
      randomizeAnimation: Bool = false
    )
    case scalingDots(
      count: Int = 3,
      spacing: CGFloat = 8,
      randomize: Bool = false,
      colors: [Color] = [.red, .orange, .yellow, .blue, .purple],
      animationDuration: Double = 0.6
    )
  }

  @Binding public var isVisible: Bool
  public var type: SegmentType

  public var body: some View {
    if isVisible {
      indicator
    } else {
      EmptyView()
    }
  }

  private var indicator: some View {
    ZStack {
      switch type {
      case let .closingCircle(
        isAnimating,
        gradientColors,
        animationDuration,
        lineWidth
      ):
        ClosingCircle(
          isAnimating: isAnimating,
          gradientColors: gradientColors,
          animationDuration: animationDuration,
          lineWidth: lineWidth
        )
      case let .flickerRing(
        count,
        spokeType
      ):
        FlickerRing(
          count: count,
          spokeType: spokeType
        )
      case let .trimmedCircle(
        isAnimating,
        gradientColors,
        circleTrim,
        animationDuration,
        lineWidth
      ):
        TrimmedCircle(
          isAnimating: isAnimating,
          gradientColors: gradientColors,
          circleTrim: circleTrim,
          animationDuration: animationDuration,
          lineWidth: lineWidth
        )
      case let .rotatingSegment(
        isAnimating,
        gradientColors,
        animationDuration,
        lineWidth
      ):
        RotatingSegment(
          isAnimating: isAnimating,
          gradientColors: gradientColors,
          animationDuration: animationDuration,
          lineWidth: lineWidth
        )
      case let .shapeProgressView(
        gradientColors,
        lineWidth: lineWidth
      ):
        ShapeProgress(
          gradientColors: gradientColors, lineWidth: lineWidth
        )
      case let .equalizer(
        count,
        minScale,
        maxScale,
        animationDuration,
        gradientColors,
        alignment,
        direction,
        randomizeAnimation
      ):
        Equalizer(
          count: count,
          minScale: minScale,
          maxScale: maxScale,
          animationDuration: animationDuration,
          gradientColors: gradientColors,
          alignment: alignment,
          direction: direction,
          randomizeAnimation: randomizeAnimation
        )
      case let .scalingDots(
        count,
        spacing,
        randomize,
        colors,
        animationDuration
      ):
        ScalingDots(
          count: count,
          spacing: spacing,
          randomize: randomize,
          colors: colors,
          animationDuration: animationDuration
        )
      }
    }
  }
}

#Preview {
  AMActivityIndicator(isVisible: .constant(true), type: .equalizer())
    .frame(width: 200, height: 200)
}
