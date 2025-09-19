import SwiftUI

struct DemoView: View {
  let columns = Array(repeating: GridItem(.flexible(), spacing: 10), count: 2)

  @State var isVisible = true

  private let size: CGFloat = 50

  var body: some View {
    LazyVGrid(columns: columns, spacing: 10) {
      AMActivityIndicator(isVisible: $isVisible, type: .closingCircle())
        .frame(width: size, height: size)
        .padding()
      AMActivityIndicator(isVisible: $isVisible, type: .flickerRing(count: 10, spokeType: .bar))
        .frame(width: size, height: size)
        .padding()
      AMActivityIndicator(isVisible: $isVisible, type: .flickerRing(count: 10, spokeType: .ellipse))
        .frame(width: size, height: size)
        .padding()
      AMActivityIndicator(isVisible: $isVisible, type: .flickerRing(count: 8, spokeType: .circle))
        .frame(width: size, height: size)
        .padding()
      AMActivityIndicator(isVisible: $isVisible, type: .rotatingSegment())
        .frame(width: size, height: size)
        .padding()
      AMActivityIndicator(isVisible: $isVisible, type: .shapeProgressView(lineWidth: 4))
        .frame(width: size, height: size)
        .padding()
      AMActivityIndicator(isVisible: $isVisible, type: .trimmedCircle())
        .frame(width: size, height: size)
        .padding()
      AMActivityIndicator(isVisible: $isVisible, type: .equalizer())
        .frame(width: size, height: size)
        .padding()
      AMActivityIndicator(isVisible: $isVisible, type: .equalizer(alignment: .bottom))
        .frame(width: size, height: size)
        .padding()
      AMActivityIndicator(isVisible: $isVisible, type: .equalizer(alignment: .top))
        .frame(width: size, height: size)
        .padding()
      AMActivityIndicator(isVisible: $isVisible, type: .equalizer(alignment: .center, direction: .horizontal))
        .frame(width: size, height: size)
        .padding()
      AMActivityIndicator(isVisible: $isVisible, type: .equalizer(alignment: .top, direction: .horizontal))
        .frame(width: size, height: size)
        .padding()
      AMActivityIndicator(isVisible: $isVisible, type: .equalizer(alignment: .bottom, direction: .horizontal))
        .frame(width: size, height: size)
        .padding()
      AMActivityIndicator(isVisible: $isVisible, type: .scalingDots())
        .frame(width: size, height: size)
        .padding()
      AMActivityIndicator(isVisible: $isVisible, type: .scalingDots(randomize: true))
        .frame(width: size, height: size)
        .padding()
    }
    .padding()
  }
}

#Preview {
  DemoView()
}
