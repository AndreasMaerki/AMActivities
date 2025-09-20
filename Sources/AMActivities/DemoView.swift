import SwiftUI

struct DemoView: View {
  let columns = Array(
    repeating: GridItem(.flexible(), spacing: 20),
    count: 2
  )

  @State var isVisible = true

  var body: some View {
    ScrollView {
      LazyVGrid(columns: columns, spacing: 10) {
        Group {
          AMActivityIndicator(isVisible: $isVisible, type: .closingCircle())
          AMActivityIndicator(isVisible: $isVisible, type: .flickerRing(count: 10, spokeType: .bar))
          AMActivityIndicator(isVisible: $isVisible, type: .flickerRing(count: 10, spokeType: .ellipse))
          AMActivityIndicator(isVisible: $isVisible, type: .flickerRing(count: 8, spokeType: .circle))
          AMActivityIndicator(isVisible: $isVisible, type: .rotatingSegment())
          AMActivityIndicator(isVisible: $isVisible, type: .shapeProgressView(lineWidth: 4))
          AMActivityIndicator(isVisible: $isVisible, type: .trimmedCircle())
          AMActivityIndicator(isVisible: $isVisible, type: .equalizer())
          AMActivityIndicator(isVisible: $isVisible, type: .equalizer(alignment: .bottom))
          AMActivityIndicator(isVisible: $isVisible, type: .equalizer(alignment: .top))
          AMActivityIndicator(isVisible: $isVisible, type: .equalizer(alignment: .center, direction: .horizontal))
          AMActivityIndicator(isVisible: $isVisible, type: .equalizer(alignment: .top, direction: .horizontal))
          AMActivityIndicator(isVisible: $isVisible, type: .equalizer(alignment: .bottom, direction: .horizontal))
          AMActivityIndicator(isVisible: $isVisible, type: .scalingDots())
          AMActivityIndicator(isVisible: $isVisible, type: .scalingDots(randomize: true))
        }
        .frame(width: 100, height: 100)
        .padding()
      }
    }
  }
}

#Preview {
  DemoView()
}
