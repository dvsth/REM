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
        TabView {
            NavigationStack {
                ZStack {
                    VStack() {
                        if items.isEmpty {
                            ContentUnavailableView("No dreams yet", systemImage: "bubbles.and.sparkles", description: Text("To log your first dream, tap 'New' above"))
                        }
                        else {
                            List {
                                ForEach(items, id: \.self) {
                                    item in
                                    NavigationLink {
                                        DreamView(dream: item)
                                    } label: {
                                        DreamListItem(dream: item)
                                    }.contextMenu(ContextMenu(menuItems: {
                                        Text("")
                                    }))
                                }.onDelete(perform: deleteItems)
                            }
                            .background(.ultraThinMaterial)
                            .toolbar {
                                ToolbarItem(placement: .topBarLeading) {
                                    EditButton()
                                }
                            }
                        }
                    }
                    .navigationTitle("Your dream log")
                    .toolbar {
                        ToolbarItem(placement: .topBarTrailing) {
                            Button {
                                showingSheet.toggle()
                            } label: {
                                Image(systemName: "plus")
                                Text("New")
                            }
                            .buttonStyle(.bordered)
                            .tint(.purple)
                            .buttonBorderShape(.capsule)
                            .sheet(isPresented: $showingSheet) {
                                NavigationStack {
                                    NewDreamForm().navigationTitle("New dream")
                                }
                            }
                        }
                    }
                }
            }.tabItem {
                Label("Log", systemImage: "book.pages")
            }
            NavigationStack {
                
            }.tabItem {
                Label("Insights", systemImage: "timelapse")
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


