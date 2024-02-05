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
        HStack(alignment:.center, spacing: 15) {
            VStack(spacing:0) {
                    Text("\(dream.dreamt.formatted(.dateTime.month())) ".uppercased()).bold().font(.title3)
                    Text("\(dream.dreamt.formatted(.dateTime.day()))").bold().font(.title3)
                    .foregroundStyle(.purple)
            }
            Text("\(dream.details)...")
                .font(.callout)
                .lineLimit(3)
        }
    }
}

#Preview {
    let dream = Dream(tone: "nightmare", mood1: "sad",mood2: "neutral",mood3: "confident", details: "I dreamed about a red wave that crossed the ocean with me surfing on it like Paul Atreides riding an ornithopter on Arrakis")
    return DreamListItem(dream: dream)
}
