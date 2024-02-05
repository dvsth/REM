//
//  MelangeButton.swift
//  REM
//
//  Created by Dev Seth on 1/17/24.
//

import SwiftUI

struct MelangeButton: View {
    var text: String
    var systemName: String
    var mainColor: Color
    var accentColor: Color
    var action: () -> Void
    
    @State private var animate = false
    
    var body: some View {
        Button {
            withAnimation {
                animate.toggle()
            }
            print("btn pressed" + Date.now.formatted())
            action()
        } label: {
            ZStack {
                Color.primary
                AnimatedRadialGradientView(extent: 90, center: .bottom, duration: 5, color1: mainColor, color2: .clear)
                AnimatedRadialGradientView(extent: 130, center: .bottom, duration: 7, color1: mainColor, color2: .clear)
                AnimatedRadialGradientView(extent: 20, center: .bottom, duration: 5, color1: accentColor, color2: .clear)
                AnimatedRadialGradientView(extent: 110, center: .bottom, duration: 13, color1: accentColor, color2: .clear)
                VStack(spacing:10) {
                    Image(systemName: systemName)
                        .resizable()
                        .scaledToFit()
                        .frame(maxHeight: 30)
                        .symbolEffect(.bounce, value: animate)
                    Text(text)
                }.foregroundStyle(.thickMaterial)
                    .padding(EdgeInsets(top: 20, leading: 10, bottom: 20, trailing: 10))
                    .frame(width: 150, height: 100)
                    .background(.ultraThinMaterial)
            }
            .frame(width: 150, height: 100)
                .background(.ultraThickMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 25))
                .foregroundStyle(.ultraThickMaterial)
                .bold()
                .onAppear {
                    withAnimation {
                        animate.toggle()
                    }
                }
        }
    }
}

#Preview {
    MelangeButton(text: "Record", systemName: "moon.zzz.fill", mainColor: .blue, accentColor: .indigo) { }
}
