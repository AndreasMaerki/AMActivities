import SwiftUI

public struct AMActivityIndicator: View {
  public enum IndicatorType {
    case closingCircle(
      isAnimating: Binding<Bool> = .constant(true),
      gradientColors: [Color] = [.blue, .purple, .pink, .blue],
      animationDuration: Double = 1.5,
      size: AMActivityIndicatorSize = .medium,
      lineWidth: CGFloat = 6,
    )
    case flickerRing(
      count: Int = 10,
      spokeType: SpokeType = .bar
    )
    case trimmedCircle(
      isAnimating: Binding<Bool> = .constant(true),
      gradientColors: [Color] = [.blue, .purple, .pink, .yellow, .blue],
      size: AMActivityIndicatorSize = .medium,
      circleTrim: CGFloat = 0.8,
      animationDuration: Double = 1.0,
      lineWidth: CGFloat = 6
    )
    case rotatingSegment(
      isAnimating: Binding<Bool> = .constant(true),
      gradientColors: [Color] = [.blue, .purple, .pink, .blue],
      animationDuration: Double = 1.5,
      size: AMActivityIndicatorSize = .medium,
      lineWidth: CGFloat = 6
    )
    case shapeProgressView(
      gradientColors: [Color] = [.blue, .purple, .pink, .blue]
    )
  }

  @Binding public var isVisible: Bool
  public var type: IndicatorType

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
        size,
        lineWidth
      ):
        ClosingCircle(
          isAnimating: isAnimating,
          gradientColors: gradientColors,
          animationDuration: animationDuration,
          size: size,
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
        size,
        circleTrim,
        animationDuration,
        lineWidth
      ):
        TrimmedCircle(
          isAnimating: isAnimating,
          gradientColors: gradientColors,
          size: size,
          circleTrim: circleTrim,
          animationDuration: animationDuration,
          lineWidth: lineWidth
        )
      case let .rotatingSegment(
        isAnimating,
        gradientColors,
        animationDuration,
        size,
        lineWidth
      ):
        RotatingSegment(
          isAnimating: isAnimating,
          gradientColors: gradientColors,
          animationDuration: animationDuration,
          size: size,
          lineWidth: lineWidth
        )
      case let .shapeProgressView(
        gradientColors
      ):
        ShapeProgressView(
          gradientColors: gradientColors
        )
      }
    }
  }
}

#Preview {
  AMActivityIndicator(isVisible: .constant(true), type: .flickerRing())
    .frame(width: 50, height: 50)
}
