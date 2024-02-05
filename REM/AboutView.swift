//
//  AboutView.swift
//  REM
//
//  Created by Dev Seth on 1/14/24.
//

import SwiftUI

struct AboutView: View {
    @State private var rotation = 0.0
    
    var body: some View {
        VStack {
            Spacer()
            Image("Logo")
                .resizable()
                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                .frame(maxWidth: 200, maxHeight: 200)
                .rotationEffect(.degrees(rotation))
                .onAppear {
                    withAnimation(.easeInOut(duration: 30).repeatForever(autoreverses: false)) {
                        rotation = 360
                    }
                }
            ForEach([Color.orange, Color.red, Color.purple, Color.mint], id: \.hashValue) {
                color in
                Text("REM v1.13")
                    .bold()
                    .font(.largeTitle)
                    .monospaced()
                    .foregroundStyle(color)
            }
            Text("from @dvsth with 💜")
                .bold()
                .padding(5)
            HStack {
                Text("text feedback to")
                Link("919-321-5293", destination: URL(string: "imessage:9193215293")!)
            }
            Spacer()
                .font(.footnote)
            Text("sweet dreams!")
                .monospaced()
                .italic()
            Spacer()
        }
    }
}

#Preview {
    AboutView()
}
