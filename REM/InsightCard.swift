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
    var highlightColor: Color = .purple
    
    @State private var gradient = 0.0
    
    var body: some View {
        ZStack {
            Color.white
            AnimatedRadialGradientView(center: .topLeading, animDuration: 1, color1: .indigo, color2: .clear)
            AnimatedRadialGradientView(center: .topTrailing, animDuration: 2, color1: .pink, color2: .clear)
            AnimatedRadialGradientView(center: .bottom, animDuration: 1.5, color1: .pink, color2: .clear)
            AnimatedRadialGradientView(center: .bottomTrailing, animDuration: 2, color1: .purple, color2: .clear)
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
                    .foregroundStyle(.thinMaterial)
                Spacer()
            }
            .padding(10)
            .frame(minWidth: 200, maxWidth: 200, minHeight: 200, maxHeight: 200)
            .background(.ultraThinMaterial)
            .aspectRatio(1, contentMode: .fit)
            .clipShape(.rect(cornerRadius: 25))
        }
        .frame(minWidth: 200, maxWidth: 200, minHeight: 200, maxHeight: 200)
        .clipShape(.rect(cornerRadius: 25))
        
        
        
    }
}

#Preview {
    VStack {
        InsightCard()
    }
    .padding(30)
}
