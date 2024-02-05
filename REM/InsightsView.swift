//
//  InsightsView.swift
//  REM
//
//  Created by Dev Seth on 1/13/24.
//

import SwiftUI
import SwiftData
import Charts

struct DreamData: Identifiable {
    let id = UUID()
    var category: String
    var value: Double
}

struct InsightsView: View {
    
    @Query private var dreams: [Dream]
    
    var body: some View {
        
        if dreams.isEmpty {
            ContentUnavailableView("No insights yet", systemImage: "timelapse", description: Text("Start by adding a dream to your dream log"))
        }
        else {
            VStack(alignment: .leading) {
                ScrollView(.horizontal) {
                    Grid(horizontalSpacing: 15, verticalSpacing: 15) {
                        GridRow {
                            TotalCountView()
                            LucidView()
                        }
                        GridRow {
                            InsightCard(
                                topText: "Coming soon",
                                heroText: "🔮",
                                bottomText: "DreamGPT: AI dream interpretation by REM",
                                highlightColors: [.yellow, .yellow, .orange, .yellow])
                        }
                    }
                }
                .scrollIndicators(.hidden)
                .padding(.leading)
            }.padding(.top)
            Spacer()
        }
            
    }
}

#Preview {
    return InsightsView()
}
