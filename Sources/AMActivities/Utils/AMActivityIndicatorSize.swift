import Foundation

enum AMActivityIndicatorSize {
  case xSmall
  case small
  case medium
  case large
  case xLarge
  case custom(CGSize)

  var value: CGSize {
    switch self {
    case .xSmall:
      .init(width: 32, height: 32)
    case .small:
      .init(width: 48, height: 48)
    case .medium:
      .init(width: 56, height: 56)
    case .large:
      .init(width: 64, height: 64)
    case .xLarge:
      .init(width: 80, height: 80)
    case let .custom(size):
      size
    }
  }
}
