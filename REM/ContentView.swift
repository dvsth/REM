//
//  ContentView.swift
//  REM
//
//  Created by Dev Seth on 1/9/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Dream]
    
    @State private var showingSheet = false

    var body: some View {
        NavigationStack {
            ZStack {
                VStack() {
                    List {
                        ForEach(items, id: \.self) {
                            item in
                            NavigationLink {
                                DreamView(dream: item)
                            } label: {
                                DreamListItem(dream: item)
                            }
                        }.onDelete(perform: deleteItems)
                    }
                    .background(.ultraThinMaterial)
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
                            EditButton()
                        }
                    }
                }
                .navigationTitle("Your dreams")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Add") {
                            showingSheet.toggle()
                        }
                        .sheet(isPresented: $showingSheet) {
                            NavigationStack {
                                NewDreamForm().navigationTitle("New dream")
                            }
                        }
                    }
                }
            }
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

#Preview {
    return ContentView()
        .modelContainer(for: Dream.self, inMemory: true)
}


