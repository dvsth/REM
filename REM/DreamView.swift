//
//  DreamView.swift
//  REM
//
//  Created by Dev Seth on 1/9/24.
//

import SwiftUI

struct DreamView: View {
    @Bindable var dream: Dream
    
    private var daysAgo: Int {
        let now = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: dream.dreamt, to: now)
        
        guard let daysAgo = components.day else {
            return -1
        }
        
        return daysAgo
    }
    
    private var characteristicsString: String {
        var out = "This \(dream.isLucid ? "**lucid** " : "")dream felt "
        if dream.tone != "unclear" {
            out.append("like a **\(dream.tone)**.")
        }
        else {
            out.append("unclear.")
        }
        return out
    }
    
    var body: some View {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "ha"
        dateformatter.locale = Locale(identifier: "en_US_POSIX")
        
        return VStack {
            List {
                Section("Dream characteristics") {
                    Text(.init("You had this dream around \(dateformatter.string(from: dream.dreamt).lowercased()) on \(dream.dreamt.formatted(date: .abbreviated, time: .omitted)). \(characteristicsString)"))
                }
                Section("How you felt") {
                    ForEach([dream.mood1, dream.mood2, dream.mood3], id: \.self) {
                        mood in
                        Text(mood)
                    }
                }
                Section("Details you remembered") {
                    TextField("Details you remembered", text: $dream.details, axis: .vertical)
                        .lineLimit(7...)
                }
            }
        }.navigationTitle("Dreamt \(daysAgo) \(daysAgo == 1 ? "day" : "days") ago")
    }
}

#Preview {
    DreamView(dream: Dream(tone: "nightmare", mood1: "sad",mood2: "neutral",mood3: "confident", details: "I dreamed about a red wave"))
}
