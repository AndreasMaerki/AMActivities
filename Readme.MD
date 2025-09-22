# AMActivities 🎡

A lightweight, highly‑customizable collection of **SwiftUI activity indicators**.
Choose from elegant spinners, flickering rings, equalizer bars, animated dots, or shape‑based progress views—all composable, customizable, and performance‑friendly.

---

## ✨ Features

- 🚀 Multiple indicator styles via a single API:
  - **ClosingCircle** – animated arc that closes a circle.
  - **FlickerRing** – glowing flickering spokes in circular arrangement.
  - **RotatingSegment** – minimal spinning arc loader.
  - **ShapeProgress** – animated shapes (star, diamond, custom) with progress‑style arcs.
  - **Equalizer** – animated audio‑bar‑style equalizer.
  - **ScalingDots** – pulsing “typing indicator” dots.

- 🎨 Supports gradients, colors, scales, and line widths.
- 🪶 Lightweight: renders **only if visible**.
- 🧩 Modular design: each animation is a self‑contained SwiftUI view.
- 🔧 Highly configurable: tweak counts, spacing, speeds, alignments, randomization.

---

## 📦 Installation

**Swift Package Manager**

```swift
dependencies: [
    .package(url: "https://github.com/AndreasMaerki/AMActivities.git", from: "1.0.0")
]
```

---

## 🛠 Usage

Import the package:

```swift
import AMActivityIndicator
```

Drop an indicator into your SwiftUI hierarchy:

```swift
struct ContentView: View {
    @State private var loading = true

    var body: some View {
        VStack {
            AMActivityIndicator(
                isVisible: $loading,
                type: .flickerRing(count: 10, spokeType: .ellipse)
            )
            .frame(width: 80, height: 80)

            Button("Toggle") { loading.toggle() }
        }
    }
}
```

When `isVisible` is `false`, nothing is rendered—keeping your view tree lean.

---

## 🎛 Indicator Types

All styles are configured via the `IndicatorType` enum:

```swift
// Closing arc circle
.closingCircle(animationDuration: 1.5, lineWidth: 6)

// Flickering radial spokes
.flickerRing(count: 10, animationDuration: 1.0, spokeType: .bar)

// Minimal spinner
.rotatingSegment(animationDuration: 1.5, lineWidth: 6)

// Shape‑based progress indicator
.shapeProgressView(lineWidth: 4, shape: .starShape)

// Animated audio equalizer
.equalizer(
  count: 8,
  minScale: 0.2,
  maxScale: 1.0,
  animationDuration: 0.6,
  alignment: .bottom,
  direction: .horizontal,
  randomizeAnimation: true
)

// Typing‑indicator style dots
.scalingDots(count: 3, spacing: 12, randomize: false, animationDuration: 0.6)
```

---

## 🎨 Styling

Each indicator is just SwiftUI — style with gradients, colors, masks, or composited layouts:

```swift
AMActivityIndicator(isVisible: .constant(true), type: .equalizer())
    .frame(width: 150, height: 80)
    .foregroundStyle(
        LinearGradient(colors: [.blue, .purple, .pink],
                       startPoint: .leading,
                       endPoint: .trailing)
    )
```

---

## 📐 Custom Shapes

For `shapeProgressView`, supply one of the built‑in shapes or pass your own:

```swift
// Using a custom shape
struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: .init(x: rect.midX, y: rect.minY))
            path.addLine(to: .init(x: rect.maxX, y: rect.maxY))
            path.addLine(to: .init(x: rect.minX, y: rect.maxY))
            path.closeSubpath()
        }
    }
}

AMActivityIndicator(
    isVisible: .constant(true),
    type: .shapeProgressView(shape: .custom(AnyShape(Triangle())))
)
```

---

## 📜 License

MIT – free to use, modify, and share.

---
