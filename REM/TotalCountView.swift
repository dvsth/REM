//
//  TotalCountView.swift
//  REM
//
//  Created by Dev Seth on 1/14/24.
//

import SwiftUI
import SwiftData

struct TotalCountView: View {
    
    @Query(sort: \Dream.added, order: .forward) private var dreams: [Dream]
    
    var totalCount: Int {
        return dreams.count
    }
    
    var earliestDream: Date {
        dreams.first?.added ?? Date.distantPast
    }
    
    var body: some View {
        InsightCard(topText: "Dreams logged", heroText: totalCount.formatted(), bottomText: "Earliest dream logged on \(earliestDream.formatted(date: .abbreviated, time: .omitted))", highlightColors: [.pink, .purple, .purple, .pink])
    }
}

#Preview {
    TotalCountView()
}
