//
//  SwiftUIView.swift
//  REM
//
//  Created by Dev Seth on 1/14/24.
//

import SwiftUI
import Foundation

struct AnimatedRadialGradientView: View {
    
    @State private var animY = -10.0
    var extent: Double
    var center: UnitPoint
    var duration: Double
    var color1: Color
    var color2: Color
    
    var body: some View {
        RadialGradient(colors: [color1, color2], center: center, startRadius: 0, endRadius: animY)
            .animation(.spring(duration: duration, bounce: 0.8), value: animY)
            .onAppear {
                animY = extent
            }
    }
}

#Preview {
    AnimatedRadialGradientView(extent: 150, center: .bottomLeading, duration: 1.0, color1: .red, color2: .clear)
}
