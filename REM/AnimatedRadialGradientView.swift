//
//  SwiftUIView.swift
//  REM
//
//  Created by Dev Seth on 1/14/24.
//

import SwiftUI
import Foundation

struct AnimatedRadialGradientView: View {
    
    @State private var animY = 10.0
    var center: UnitPoint
    var animDuration: Double
    var color1: Color
    var color2: Color
    
    var body: some View {
        RadialGradient(colors: [color1, color2], center: center, startRadius: 0, endRadius: animY)
            .animation(.spring(duration: animDuration, bounce: 0.8), value: animY)
            .onAppear {
                animY = 150
            }
    }
}

#Preview {
    AnimatedRadialGradientView(center: .bottomLeading, animDuration: 1.0, color1: .red, color2: .clear)
}
