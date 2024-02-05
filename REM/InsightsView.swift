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
        VStack {
            if dreams.isEmpty {
                ContentUnavailableView("Insights coming soon!", systemImage: "timelapse", description: Text("Check back in a future version for analysis of dream patterns, themes, and emotions"))
            }
            else {
                NavigationStack {
                    
                }
            }
        }
    }
}

#Preview {
    return InsightsView()
}
