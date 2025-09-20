import SwiftUI

public struct AMActivityIndicator: View {
  public enum IndicatorType {
    /// Initializes the activity indicator.
    /// - Parameters:
    ///   - gradientColors:  An array of colors for the angular gradient stroke. Defaults to `[.blue, .purple, .pink, .blue]`. Inject a single color,i.e. `[.blue] `for no gradient.
    ///   - animationDuration: The duration of one full rotation cycle in seconds. Affects spin speed. Defaults to `1.5`.
    ///   - lineWidth: The line width of the circle.
    /// Example usage:
    /// ```
    /// AMActivityIndicator.closingCircle()
    /// ```
    case closingCircle(
      gradientColors: [Color] = [.blue, .purple, .pink, .blue],
      animationDuration: Double = 1.5,
      lineWidth: CGFloat = 6,
    )

    /// An animated radial "ring" of flickering spokes, styled with a gradient
    /// and animated opacity/scale variations.
    ///
    /// `FlickerRing` arranges a number of shapes (spokes) evenly spaced around
    /// a circular layout. Each spoke grows and fades in a rotating sequence,
    /// producing a dynamic "flicker" effect reminiscent of a glowing spinner or
    /// radar sweep. Spokes can be drawn as bars, circles, or ellipses via
    /// the ``SpokeType`` enum.
    ///
    /// The ring is filled using an `AngularGradient` mask built from
    /// the provided gradient colors, giving smooth transitions around the circle.
    /// The gradient defaults to `[.red, .purple, .pink, .red]`.
    ///
    /// - Parameters:
    ///   - count: The number of spokes to draw around the ring. A higher count
    ///     creates a denser, smoother ring effect. For example, `10` produces
    ///     ten evenly spaced spokes.
    ///   - spokeType: Determines the shape used for each spoke (``SpokeType/bar``,
    ///     ``SpokeType/circle``, or ``SpokeType/ellipse``).
    ///
    /// Example:
    /// ```swift
    /// AMActivityIndicator.flickerRing(
    ///     count: 12,
    ///     spokeType: .ellipse
    /// )
    /// ```
    case flickerRing(
      count: Int = 10,
      animationDuration: Double = 1.0,
      spokeType: SpokeType = .bar,
      gradientColors: [Color] = [.red, .purple, .pink, .red]
    )

    /// Creates a new `SimpleGradientSpinner`, a circular gradient-based activity indicator.
    ///
    /// - Parameters:
    ///   - gradientColors: The colors of the angular gradient applied to the spinner stroke. Defaults to `[.blue, .purple, .pink, .yellow, .blue]`. Inject a single color,i.e. `[.blue] `for no gradient.
    ///   - size: The spinner size, defined by `AMActivityIndicatorSize` (e.g. `.small`, `.medium`, `.large`). Defaults to `.medium`.
    ///   - circleTrim: The fraction of the circle's circumference that is drawn (0.0–1.0). Smaller values create a "gap" in the spinner. Defaults to `0.8`.
    ///   - animationDuration: The duration, in seconds, for one full rotation. Defaults to `1.0`.
    ///   - lineWidth: The thickness of the spinner stroke. Defaults to `6`.
    /// Example usage:
    /// ```
    /// AMActivityIndicator.trimmedCircle()
    /// ```
    case trimmedCircle(
      gradientColors: [Color] = [.blue, .purple, .pink, .yellow, .blue],
      circleTrim: CGFloat = 0.8,
      animationDuration: Double = 1.0,
      lineWidth: CGFloat = 6
    )

    /// A rotating segment spinner with optional gradient stroke.
    ///
    /// - Parameters:
    ///   - gradientColors: Colors for the arc's gradient. Use one color (e.g., `[.blue]`) for solid stroke.
    ///   - animationDuration: Time in seconds for one full rotation. Defaults to 1.5.
    ///   - size: Predefined or custom size of the spinner. Defaults to `.medium`.
    ///   - lineWidth: Stroke width of the arc and background circle. Defaults to 6.
    /// Example usage:
    /// ```
    /// AMActivityIndicator.rotatingSegment()
    /// ```
    case rotatingSegment(
      gradientColors: [Color] = [.blue, .purple, .pink, .blue],
      animationDuration: Double = 1.5,
      lineWidth: CGFloat = 6
    )

    /// Creates a `ShapeProgress` view with customizable gradient colors, stroke width, and shape.
    ///
    /// Use this case to display an animated progress indicator in the style defined by
    /// `ShapeProgress`, choosing the stroke appearance and which decorative shape
    /// (such as diamond, star, or flare flower) should be drawn.
    ///
    /// - Parameters:
    ///   - gradientColors: The colors used to generate the underlying `AngularGradient`
    ///     for the indicator’s stroke. Defaults to `[.blue, .purple, .pink, .blue]`.
    ///   - lineWidth: The thickness of the shape’s stroke in points. Defaults to `4`.
    ///   - shape: A `ShapeProgressShapeType` value specifying which shape to render,
    ///     such as `.fancyDiamondShape` or `.starShape`. Defaults to `.fancyDiamondShape`.
    ///
    /// Example:
    /// ```swift
    /// AMActivityIndicator.shapeProgressView(
    ///     gradientColors: [.orange, .red, .yellow],
    ///     lineWidth: 6,
    ///     shape: .starShape
    /// )
    /// ```
    case shapeProgressView(
      gradientColors: [Color] = [.blue, .purple, .pink, .blue],
      lineWidth: CGFloat = 4,
      shape: ShapeProgressShapeType = .fancyDiamondShape
    )

    /// Creates an animated equalizer view with configurable bar count, scaling,
    /// animation behavior, alignment, orientation, and gradient styling.
    ///
    /// This case produces a `Equalizer` view composed of animated bars that repeatedly
    /// scale between a minimum and maximum height (or width, if horizontal).
    /// Defaults are provided for all parameters so you can drop in the equalizer
    /// without extra configuration, and then override as needed.
    ///
    /// - Parameters:
    ///   - count: The total number of bars to display in the equalizer. Defaults to `5`.
    ///   - minScale: The scale factor that defines the minimum bar height (or width).
    ///     Typically between `0` and `1`. Defaults to `0.3`.
    ///   - maxScale: The scale factor that defines the maximum bar height
    ///     (or width). Defaults to `1.0` (full size).
    ///   - animationDuration: The base duration (in seconds) of one animation cycle,
    ///     before repeating. Lower values yield faster animations. Defaults to `0.7`.
    ///   - gradientColors: The array of `Color` values used to build a vertical
    ///     `LinearGradient` fill for the bars. Defaults to `[.purple, .pink, .yellow]`.
    ///   - alignment: The scaling anchor point for bars, specified via
    ///     ``EqualizerBarAlignment`` (`.top`, `.center`, `.bottom`). Defaults to `.center`.
    ///   - direction: The overall orientation of the equalizer, specified via
    ///     ``EqualizerDirection`` (`.vertical` or `.horizontal`). Defaults to `.vertical`.
    ///   - randomizeAnimation: A Boolean that controls whether each bar uses
    ///     unique randomized delays/durations. When `false`, bars animate with
    ///     deterministic staggered timing. Defaults to `false`.
    ///
    /// Example:
    /// ```swift
    /// MyEnum.equalizer(
    ///     count: 8,
    ///     minScale: 0.2,
    ///     maxScale: 1.0,
    ///     animationDuration: 0.6,
    ///     gradientColors: [.blue, .cyan, .mint],
    ///     alignment: .bottom,
    ///     direction: .horizontal,
    ///     randomizeAnimation: true
    /// )
    /// ```
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

    /// An animated row of scaling dots, styled with a horizontal gradient mask.
    ///
    /// `ScalingDots` creates a sequence of dots that continuously scale up and down
    /// in size to produce a pulsing or "bouncing" animation effect.
    /// The animation can be deterministic (staggered delays) or randomized to create
    /// a more dynamic, organic motion.
    ///
    /// A horizontal `LinearGradient` fill is applied across the entire row of dots
    /// and then masked to the animated dots, producing colorful effects.
    ///
    /// - Parameters:
    ///   - count: The number of dots to display. For example, `3` produces a classic
    ///     pulsing typing indicator.
    ///   - spacing: The amount of horizontal spacing between each dot, in points.
    ///   - randomize: A Boolean flag that controls whether each dot uses randomized
    ///     delays and durations (`true`) or evenly staggered deterministic values (`false`).
    ///   - colors: An array of `Color` values used to create the `LinearGradient`
    ///     that fills the dots. Colors blend smoothly across the row.
    ///   - animationDuration: The base duration (in seconds) for one scale animation cycle.
    ///     Lower values make the scaling faster; higher values make it slower.
    ///
    /// Example:
    /// ```swift
    /// AMActivityIndicator.scalingDots(
    ///     count: 3,
    ///     spacing: 12,
    ///     randomize: false,
    ///     colors: [.red, .orange, .yellow, .green, .blue, .purple],
    ///     animationDuration: 0.6
    /// )
    /// .frame(width: 250, height: 50)
    /// ```
    case scalingDots(
      count: Int = 3,
      spacing: CGFloat = 8,
      randomize: Bool = false,
      colors: [Color] = [.red, .orange, .yellow, .blue, .purple],
      animationDuration: Double = 0.6
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
        gradientColors,
        animationDuration,
        lineWidth
      ):
        ClosingCircle(
          gradientColors: gradientColors,
          animationDuration: animationDuration,
          lineWidth: lineWidth
        )
      case let .flickerRing(
        count,
        animationDuration,
        spokeType,
        gradientColors
      ):
        FlickerRing(
          count: count,
          animationDuration: animationDuration,
          spokeType: spokeType,
          gradientColors: gradientColors
        )
      case let .trimmedCircle(
        gradientColors,
        circleTrim,
        animationDuration,
        lineWidth
      ):
        TrimmedCircle(
          gradientColors: gradientColors,
          circleTrim: circleTrim,
          animationDuration: animationDuration,
          lineWidth: lineWidth
        )
      case let .rotatingSegment(
        gradientColors,
        animationDuration,
        lineWidth
      ):
        RotatingSegment(
          gradientColors: gradientColors,
          animationDuration: animationDuration,
          lineWidth: lineWidth
        )
      case let .shapeProgressView(
        gradientColors,
        lineWidth,
        shape
      ):
        ShapeProgress(
          gradientColors: gradientColors,
          lineWidth: lineWidth,
          shape: shape
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
