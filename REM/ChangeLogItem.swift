//
//  ChangeLogItem.swift
//  REM
//
//  Created by Dev Seth on 1/22/24.
//

import SwiftUI

struct ChangeLogItem: View {
    var date: Date = Date.now
    var title: String = "Title"
    var description: String = "Desc"
    var systemImage: String = "gear"
    
    var body: some View {
        HStack {
            
        }
        .frame(height: 200)
        .background(.ultraThinMaterial)
    }
}

#Preview {
    ChangeLogItem()
}
