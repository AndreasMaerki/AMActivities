import AMActivities
import SwiftUI

struct IndicatorDemoView: View {
  let columns = Array(
    repeating: GridItem(.flexible(), spacing: 0),
    count: 2
  )

  @State var isVisible = true

  var body: some View {
    ScrollView {
      LazyVGrid(columns: columns) {
        Group {
          AMActivityIndicator(
            isVisible: $isVisible,
            type: .closingCircle()
          )
          .foregroundStyle(
            AngularGradient(
              colors: [.pink, .yellow, .purple, .red],
              center: .center
            )
          )

          AngularGradient(
            colors: [.pink, .yellow, .purple, .red],
            center: .center
          )
          .mask {
            AMActivityIndicator(
              isVisible: $isVisible,
              type:
              .flickerRing(
                count: 10,
                spokeType: .bar
              )
            )
          }

          AngularGradient(
            colors: [.pink, .yellow, .purple, .red],
            center: .center
          ).mask {
            AMActivityIndicator(
              isVisible: $isVisible,
              type: .flickerRing(
                count: 10,
                spokeType: .ellipse
              )
            )
          }

          AngularGradient(
            colors: [.pink, .yellow, .purple, .red],
            center: .center
          ).mask {
            AMActivityIndicator(
              isVisible: $isVisible,
              type: .flickerRing(
                count: 8,
                spokeType: .circle
              )
            )
          }

          AMActivityIndicator(
            isVisible: $isVisible,
            type: .rotatingSegment()
          )
          .foregroundStyle(
            AngularGradient(
              colors: [.pink, .yellow, .purple, .red],
              center: .center
            )
          )

          AMActivityIndicator(
            isVisible: $isVisible,
            type: .shapeProgressView(
              lineWidth: 6,
              shape: .none
            )
          )
          .foregroundStyle(
            AngularGradient(
              colors: [.pink, .yellow, .purple, .red],
              center: .center
            )
          )

          AMActivityIndicator(
            isVisible: $isVisible,
            type: .shapeProgressView(
              lineWidth: 4
            )
          )
          .foregroundStyle(
            AngularGradient(
              colors: [.pink, .yellow, .purple, .red],
              center: .center
            )
          )

          AMActivityIndicator(
            isVisible: $isVisible,
            type: .shapeProgressView(
              lineWidth: 4,
              shape: .flareFlowerShape
            )
          )
          .foregroundStyle(
            AngularGradient(
              colors: [.pink, .yellow, .purple, .red],
              center: .center
            )
          )

          AMActivityIndicator(
            isVisible: $isVisible,
            type: .equalizer()
          )
          .foregroundStyle(
            LinearGradient(
              colors: [.pink, .orange, .yellow],
              startPoint: .bottom,
              endPoint: .top
            )
          )

          AMActivityIndicator(
            isVisible: $isVisible,
            type: .equalizer(
              alignment: .bottom
            )
          )
          .foregroundStyle(
            LinearGradient(
              colors: [.pink, .orange, .yellow],
              startPoint: .bottom,
              endPoint: .top
            )
          )

          AMActivityIndicator(
            isVisible: $isVisible,
            type: .equalizer(
              alignment: .top
            )
          )
          .foregroundStyle(
            LinearGradient(
              colors: [.pink, .orange, .yellow],
              startPoint: .bottom,
              endPoint: .top
            )
          )

          AMActivityIndicator(
            isVisible: $isVisible,
            type: .equalizer(
              alignment: .center,
              direction: .horizontal
            )
          )
          .foregroundStyle(
            LinearGradient(
              colors: [.pink, .orange, .yellow],
              startPoint: .bottom,
              endPoint: .top
            )
          )

          AMActivityIndicator(
            isVisible: $isVisible,
            type: .equalizer(
              alignment: .top,
              direction: .horizontal
            )
          )
          .foregroundStyle(
            LinearGradient(
              colors: [.pink, .yellow],
              startPoint: .bottom,
              endPoint: .top
            )
          )

          LinearGradient(
            colors: [.pink, .yellow],
            startPoint: .leading,
            endPoint: .trailing
          ).mask {
            AMActivityIndicator(
              isVisible: $isVisible,
              type: .equalizer(
                alignment: .bottom,
                direction: .horizontal
              )
            )
          }

          LinearGradient(
            colors: [.pink, .yellow],
            startPoint: .leading,
            endPoint: .trailing
          ).mask {
            AMActivityIndicator(
              isVisible: $isVisible,
              type: .scalingDots()
            )
          }

          LinearGradient(
            colors: [.pink, .yellow],
            startPoint: .leading,
            endPoint: .trailing
          ).mask {
            AMActivityIndicator(
              isVisible: $isVisible,
              type: .scalingDots(
                randomize: true
              )
            )
          }
        }
        .frame(width: 64, height: 64)
        .padding()
      }
    }
  }
}

#Preview {
  IndicatorDemoView()
}
