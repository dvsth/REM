//
//  ChangelogView.swift
//  REM
//
//  Created by Dev Seth on 1/22/24.
//

import SwiftUI

struct ChangelogView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Latest version released Jan 22, 2024")
                .font(.subheadline)
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
        }.padding()
        VStack {
            
        }
        Spacer()
        Button {
            dismiss()
        } label: {
            Text("Continue")
                .frame(width: 300, height: 40)
                .font(.headline)
                .bold()
        }.buttonStyle(.borderedProminent)
    }
}

#Preview {
    ChangelogView()
}
