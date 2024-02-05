//
//  LucidView.swift
//  REM
//
//  Created by Dev Seth on 1/14/24.
//

import SwiftUI
import SwiftData
import Charts

struct LucidView: View {
    
    @Query private var dreams: [Dream]
    
    var lucidCount: Int {
        var ret = 0
        for dream in dreams {
            if dream.isLucid {
                ret+=1
            }
        }
        return ret
    }
    
    var totalCount: Int {
        return dreams.count
    }
    
    var lucidPercent: Double {
        if(totalCount==0) {
            return 0.0
        }
        else {
            return Double(lucidCount)/Double(totalCount)
        }
    }
    
    var lucidData: [DreamData] {
        return [DreamData(category: "Lucid", value: lucidPercent), DreamData(category: "Non-lucid", value: 1 - lucidPercent)]
    }
    
    var body: some View {
        InsightCard(topText: "Lucid Dreaming", heroText: lucidPercent.formatted(.percent), bottomText: "\(lucidCount) lucid dreams logged")
        
    }
}

#Preview {
    LucidView()
}


/*
 Chart(lucidData, id: \.id) {
     datapoint in
     SectorMark(angle: .value("Value", datapoint.value))
         .annotation(position: .overlay) {
             Text(datapoint.value.formatted(.percent))
         }
         .foregroundStyle(by: .value("Product category", datapoint.category))
 }
 */
