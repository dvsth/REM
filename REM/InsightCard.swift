//
//  InsightCard.swift
//  REM
//
//  Created by Dev Seth on 1/14/24.
//

import SwiftUI
import Charts

struct InsightCard: View {
    
    var topText: String = "Arbitrary metric"
    var heroText: String = "34%"
    var bottomText: String = "of all entries"
    var highlightColors: [Color] = [.indigo, .pink, .pink, .purple]
    
    @State private var gradient = 0.0
    
    var body: some View {
        ZStack {
            Color.white
            AnimatedRadialGradientView(extent: 150, center: .topLeading, duration: 6, color1: highlightColors[0], color2: .clear)
            AnimatedRadialGradientView(extent: 150, center: .topTrailing, duration: 4, color1: highlightColors[1], color2: .clear)
            AnimatedRadialGradientView(extent: 150, center: .bottomLeading, duration: 10, color1: highlightColors[2], color2: .clear)
            AnimatedRadialGradientView(extent: 150, center: .bottomTrailing, duration: 8, color1: highlightColors[3], color2: .clear)
            VStack {
                Spacer()
                Text(topText.uppercased())
                    .font(.callout)
                    .bold()
                    .opacity(1)
                    .foregroundStyle(.thickMaterial)
                Spacer()
                Text(heroText)
                    .bold()
                    .font(.largeTitle).scaleEffect(1.5)
                    .foregroundStyle(.thickMaterial)
                Spacer()
                Text(bottomText)
                    .font(.callout)
                    .foregroundStyle(.ultraThickMaterial)
                Spacer()
            }
            .padding(10)
            .frame(minWidth: 200, maxWidth: 200, minHeight: 200, maxHeight: 200)
            .background(.ultraThinMaterial)
            .aspectRatio(1, contentMode: .fit)
            .clipShape(.rect(cornerRadius: 25))
        }
        .frame(minWidth: 200, maxWidth: 200, minHeight: 200, maxHeight: 200, alignment: .leading)
        .clipShape(.rect(cornerRadius: 25))
        
    }
}

#Preview {
    VStack {
        InsightCard()
    }
    .padding(30)
}
