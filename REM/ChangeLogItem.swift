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
    
    var body: some View {
        HStack(alignment: .top) {
            VStack {
                Text("\(date.formatted(.dateTime.month())) ".uppercased()).bold().font(.headline)
                Text("\(date.formatted(.dateTime.day()))").bold().font(.title3)
                    .foregroundStyle(.purple)
                Spacer()
            }
            VStack(alignment: .leading) {
                Text(title)
                    .bold()
                    .font(.headline)
                Text(description)
                    .font(.callout)
            }
            Spacer()
        }
        .padding([.top])
    }
}

#Preview {
    List {
        ChangeLogItem()
    }
}
