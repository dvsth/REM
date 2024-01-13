//
//  DreamListItem.swift
//  REM
//
//  Created by Dev Seth on 1/9/24.
//

import SwiftUI

struct DreamListItem: View {
    var dream: Dream
    var body: some View {
        HStack(alignment:.center, spacing: 20) {
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .fill(LinearGradient(colors: [.white, .gray], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .aspectRatio(1, contentMode: .fit)
                    .frame(width: 75, height: 75)
                VStack(spacing:-3) {
                    Text("\(dream.dreamt.formatted(.dateTime.month()))").bold().font(.title3)
                    Text("\(dream.dreamt.formatted(.dateTime.day()))").bold().font(.largeTitle)
                }
            }
            Text("\(dream.details)...")
                .font(.headline)
                .lineLimit(3)
        }
    }
}

#Preview {
    let dream = Dream(tone: "nightmare", mood1: "sad",mood2: "neutral",mood3: "confident", details: "I dreamed about a red wave that crossed the ocean with me surfing on it like Paul Atreides riding an ornithopter on Arrakis")
    return DreamListItem(dream: dream)
}
