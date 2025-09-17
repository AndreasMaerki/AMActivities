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
        ShapeProgressView(
          gradientColors: gradientColors, lineWidth: lineWidth
        )
      }
    }
  }
}

#Preview {
  AMActivityIndicator(isVisible: .constant(true), type: .flickerRing())
    .frame(width: 200, height: 200)
}
