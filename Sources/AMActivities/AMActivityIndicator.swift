import SwiftUI

/// A highly‑customisable activity‑indicator view.
///
/// `AMActivityIndicator` is a single‑view wrapper that can display a variety
/// of animated spinners, progress rings, equalizers, and dot animations.
/// The visual style is chosen by the ``IndicatorType`` enum.  The view
/// is shown only when the bound ``isVisible`` flag is `true`; otherwise
/// it renders an empty view.
///
/// The indicator is built from a collection of small, self‑contained
/// sub‑views (e.g. `ClosingCircle`, `FlickerRing`, `Equalizer`, …).
/// Each sub‑view is responsible for its own animation logic, so the
/// parent view simply forwards the configuration parameters.
///
/// Example
/// -------
/// ```swift
/// struct ContentView: View {
///     @State private var loading = true
///
///     var body: some View {
///         VStack {
///             AMActivityIndicator(
///                 isVisible: $loading,
///                 type: .flickerRing(count: 8, spokeType: .ellipse)
///             )
///             .frame(width: 80, height: 80)
///
///             Button("Toggle") { loading.toggle() }
///         }
///     }
/// }
/// ```
///
/// The view is intentionally lightweight – it only renders the
/// indicator when `isVisible` is `true`, which keeps the view hierarchy
/// minimal and improves performance for large UI trees.
///
/// Note: All indicators come with sensible default values for quick use,
/// but each parameter can be overridden to tailor the appearance
/// to your needs.
public struct AMActivityIndicator: View {
  public enum IndicatorType {
    /// Initializes the activity indicator.
    /// - Parameters:
    ///   - animationDuration: The duration of one full rotation cycle in seconds. Affects spin speed. Defaults to `1.5`.
    ///   - lineWidth: The line width of the circle.
    /// Example usage:
    /// ```
    /// AMActivityIndicator.closingCircle()
    /// ```
    case closingCircle(
      animationDuration: Double = 1.5,
      lineWidth: CGFloat = 6,
    )

    /// An animated radial "ring" of flickering spokes
    /// and animated opacity/scale variations.
    ///
    /// `FlickerRing` arranges a number of shapes (spokes) evenly spaced around
    /// a circular layout. Each spoke grows and fades in a rotating sequence,
    /// producing a dynamic "flicker" effect reminiscent of a glowing spinner or
    /// radar sweep. Spokes can be drawn as bars, circles, or ellipses via
    /// the ``SpokeType`` enum.
    ///
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
    )

    /// A rotating segment spinner.
    ///
    /// - Parameters:
    ///   - animationDuration: Time in seconds for one full rotation. Defaults to 1.5.
    ///   - size: Predefined or custom size of the spinner. Defaults to `.medium`.
    ///   - lineWidth: Stroke width of the arc and background circle. Defaults to 6.
    /// Example usage:
    /// ```
    /// AMActivityIndicator.rotatingSegment()
    /// ```
    case rotatingSegment(
      animationDuration: Double = 1.5,
      lineWidth: CGFloat = 6
    )

    /// Creates a `ShapeProgress` view with customizable stroke width and shape.
    ///
    /// Use this case to display an animated progress indicator in the style defined by
    /// `ShapeProgress`, choosing the stroke appearance and which decorative shape
    /// (such as diamond, star, or flare flower) should be drawn.
    ///
    /// - Parameters:
    ///   - lineWidth: The thickness of the shape’s stroke in points. Defaults to `4`.
    ///   - shape: A `ShapeProgressShapeType` value specifying which shape to render,
    ///     such as `.fancyDiamondShape` or `.starShape`. Defaults to `.fancyDiamondShape`.
    ///
    /// Example:
    /// ```swift
    /// AMActivityIndicator.shapeProgressView(
    ///     lineWidth: 6,
    ///     shape: .starShape
    /// )
    /// ```
    case shapeProgressView(
      lineWidth: CGFloat = 4,
      shape: ShapeProgressShapeType = .fancyDiamondShape
    )

    /// Creates an animated equalizer view with configurable bar count, scaling,
    /// animation behavior, alignment and orientation.
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
      alignment: EqualizerBarAlignment = .center,
      direction: EqualizerDirection = .vertical,
      randomizeAnimation: Bool = false
    )

    /// An animated row of scaling dots.
    ///
    /// `ScalingDots` creates a sequence of dots that continuously scale up and down
    /// in size to produce a pulsing or "bouncing" animation effect.
    /// The animation can be deterministic (staggered delays) or randomized to create
    /// a more dynamic, organic motion.
    ///
    /// - Parameters:
    ///   - count: The number of dots to display. For example, `3` produces a classic
    ///     pulsing typing indicator.
    ///   - spacing: The amount of horizontal spacing between each dot, in points.
    ///   - randomize: A Boolean flag that controls whether each dot uses randomized
    ///     delays and durations (`true`) or evenly staggered deterministic values (`false`).
    ///   - animationDuration: The base duration (in seconds) for one scale animation cycle.
    ///     Lower values make the scaling faster; higher values make it slower.
    ///
    /// Example:
    /// ```swift
    /// AMActivityIndicator.scalingDots(
    ///     count: 3,
    ///     spacing: 12,
    ///     randomize: false,
    ///     animationDuration: 0.6
    /// )
    /// .frame(width: 250, height: 50)
    /// ```
    case scalingDots(
      count: Int = 3,
      spacing: CGFloat = 8,
      randomize: Bool = false,
      animationDuration: Double = 0.6
    )
  }

  @Binding public var isVisible: Bool
  public var type: IndicatorType

  public init(isVisible: Binding<Bool>, type: IndicatorType) {
    _isVisible = isVisible
    self.type = type
  }

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
        animationDuration,
        lineWidth
      ):
        ClosingCircle(
          animationDuration: animationDuration,
          lineWidth: lineWidth
        )
      case let .flickerRing(
        count,
        animationDuration,
        spokeType
      ):
        FlickerRing(
          count: count,
          animationDuration: animationDuration,
          spokeType: spokeType,
        )
      case let .rotatingSegment(
        animationDuration,
        lineWidth
      ):
        RotatingSegment(
          animationDuration: animationDuration,
          lineWidth: lineWidth
        )
      case let .shapeProgressView(
        lineWidth,
        shape
      ):
        ShapeProgress(
          lineWidth: lineWidth,
          shape: shape
        )
      case let .equalizer(
        count,
        minScale,
        maxScale,
        animationDuration,
        alignment,
        direction,
        randomizeAnimation
      ):
        Equalizer(
          count: count,
          minScale: minScale,
          maxScale: maxScale,
          animationDuration: animationDuration,
          alignment: alignment,
          direction: direction,
          randomizeAnimation: randomizeAnimation
        )
      case let .scalingDots(
        count,
        spacing,
        randomize,
        animationDuration
      ):
        ScalingDots(
          count: count,
          spacing: spacing,
          randomize: randomize,
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
