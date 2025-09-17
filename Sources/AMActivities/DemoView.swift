import SwiftUI

struct DemoView: View {
  let columns = Array(repeating: GridItem(.flexible(), spacing: 10), count: 2)

  @State var isVisible = true

  var body: some View {
    LazyVGrid(columns: columns, spacing: 10) {
      AMActivityIndicator(isVisible: $isVisible, type: .closingCircle())
        .frame(width: 100, height: 100)
        .padding()
      AMActivityIndicator(isVisible: $isVisible, type: .flickerRing(count: 10, spokeType: .bar))
        .frame(width: 100, height: 100)
        .padding()
      AMActivityIndicator(isVisible: $isVisible, type: .rotatingSegment())
        .frame(width: 100, height: 100)
        .padding()
      AMActivityIndicator(isVisible: $isVisible, type: .shapeProgressView())
        .frame(width: 100, height: 100)
        .padding()
      AMActivityIndicator(isVisible: $isVisible, type: .trimmedCircle())
        .frame(width: 100, height: 100)
        .padding()
    }
    .padding()
  }
}

#Preview {
  DemoView()
}
