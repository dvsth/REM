import SwiftUI

struct AudioLevelMeterView: View {
    var audioLevel: Float

    var body: some View {
        ProgressBar(value: self.audioLevel)
            .frame(height: 20)
    }
}

struct ProgressBar: View {
    var value: Float

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle().frame(width: geometry.size.width, height: geometry.size.height)
                    .opacity(0.3)
                    .foregroundColor(Color(UIColor.systemTeal))
                
                Rectangle().frame(width: min(CGFloat(self.value)*geometry.size.width, geometry.size.width), height: geometry.size.height)
                    .foregroundColor(Color(UIColor.systemBlue))
                    .animation(.linear, value: value)
            }.cornerRadius(45.0)
        }
    }
}
