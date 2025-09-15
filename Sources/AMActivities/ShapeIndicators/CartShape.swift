import Foundation
import SwiftUI

struct CartShape: Shape {
  func path(in rect: CGRect) -> Path {
    var path = Path()
    let width = rect.size.width
    let height = rect.size.height

    // left wheel
    path.move(to: CGPoint(x: 0.375 * width, y: 0.91667 * height))
    path.addCurve(
      to: CGPoint(x: 0.41667 * width, y: 0.875 * height),
      control1: CGPoint(x: 0.39801 * width, y: 0.91667 * height),
      control2: CGPoint(x: 0.41667 * width, y: 0.89801 * height)
    )
    path.addCurve(
      to: CGPoint(x: 0.375 * width, y: 0.83333 * height),
      control1: CGPoint(x: 0.41667 * width, y: 0.85199 * height),
      control2: CGPoint(x: 0.39801 * width, y: 0.83333 * height)
    )
    path.addCurve(
      to: CGPoint(x: 0.33333 * width, y: 0.875 * height),
      control1: CGPoint(x: 0.35199 * width, y: 0.83333 * height),
      control2: CGPoint(x: 0.33333 * width, y: 0.85199 * height)
    )
    path.addCurve(
      to: CGPoint(x: 0.375 * width, y: 0.91667 * height),
      control1: CGPoint(x: 0.33333 * width, y: 0.89801 * height),
      control2: CGPoint(x: 0.35199 * width, y: 0.91667 * height)
    )
    path.closeSubpath()

    // right wheel
    path.move(to: CGPoint(x: 0.83333 * width, y: 0.91667 * height))
    path.addCurve(
      to: CGPoint(x: 0.875 * width, y: 0.875 * height),
      control1: CGPoint(x: 0.85634 * width, y: 0.91667 * height),
      control2: CGPoint(x: 0.875 * width, y: 0.89801 * height)
    )
    path.addCurve(
      to: CGPoint(x: 0.83333 * width, y: 0.83333 * height),
      control1: CGPoint(x: 0.875 * width, y: 0.85199 * height),
      control2: CGPoint(x: 0.85634 * width, y: 0.83333 * height)
    )
    path.addCurve(
      to: CGPoint(x: 0.79167 * width, y: 0.875 * height),
      control1: CGPoint(x: 0.81032 * width, y: 0.83333 * height),
      control2: CGPoint(x: 0.79167 * width, y: 0.85199 * height)
    )
    path.addCurve(
      to: CGPoint(x: 0.83333 * width, y: 0.91667 * height),
      control1: CGPoint(x: 0.79167 * width, y: 0.89801 * height),
      control2: CGPoint(x: 0.81032 * width, y: 0.91667 * height)
    )
    path.closeSubpath()

    // cart shape
    path.move(to: CGPoint(x: 0.04167 * width, y: 0.04167 * height))
    path.addLine(to: CGPoint(x: 0.20833 * width, y: 0.04167 * height))
    path.addLine(to: CGPoint(x: 0.32 * width, y: 0.59958 * height))
    path.addCurve(
      to: CGPoint(x: 0.34948 * width, y: 0.64826 * height),
      control1: CGPoint(x: 0.32381 * width, y: 0.61877 * height),
      control2: CGPoint(x: 0.33425 * width, y: 0.636 * height)
    )
    path.addCurve(
      to: CGPoint(x: 0.40333 * width, y: 0.66667 * height),
      control1: CGPoint(x: 0.36472 * width, y: 0.66053 * height),
      control2: CGPoint(x: 0.38378 * width, y: 0.66704 * height)
    )
    path.addLine(to: CGPoint(x: 0.80833 * width, y: 0.66667 * height))
    path.addCurve(
      to: CGPoint(x: 0.86219 * width, y: 0.64826 * height),
      control1: CGPoint(x: 0.82789 * width, y: 0.66704 * height),
      control2: CGPoint(x: 0.84695 * width, y: 0.66053 * height)
    )
    path.addCurve(
      to: CGPoint(x: 0.89167 * width, y: 0.59958 * height),
      control1: CGPoint(x: 0.87742 * width, y: 0.636 * height),
      control2: CGPoint(x: 0.88786 * width, y: 0.61877 * height)
    )
    path.addLine(to: CGPoint(x: 0.95833 * width, y: 0.25 * height))
    path.addLine(to: CGPoint(x: 0.25 * width, y: 0.25 * height))

    return path
  }
}
