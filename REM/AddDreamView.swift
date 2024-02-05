//
//  AddDreamView.swift
//  REM
//
//  Created by Dev Seth on 1/17/24.
//

import SwiftUI

struct AddDreamView: View {
    
    @State private var showingSheet = false
    @State private var path: [String] = []
    
    var body: some View {
        NavigationStack(path: $path) {
            HStack {
//                MelangeButton(text: "Write", systemName: "keyboard.fill", mainColor: .yellow, accentColor: .orange, action: {path.append("NewDreamWriteForm")})
                MelangeButton(text: "New dream", systemName: "moon.zzz.fill", mainColor: .indigo, accentColor: .purple, action: {path.append("NewDreamTranscribeForm")})
            }.navigationDestination(for: String.self) {
                identifier in
                if identifier == "NewDreamWriteForm" {
                    NewDreamWriteForm(path: $path)
                        .navigationTitle("New dream")
                }
                else {
                    NewDreamRecordForm(path: $path)
                        .navigationTitle("New dream")
                }
            }
        }
        .padding(.horizontal)
    }

}

#Preview {
    AddDreamView()
}
