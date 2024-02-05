//
//  DreamListView.swift
//  REM
//
//  Created by Dev Seth on 1/13/24.
//

import SwiftUI
import SwiftData

struct DreamListView: View {
    
    @State private var showingSheet = false
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Dream]
    
    var body: some View {
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
                .buttonBorderShape(.capsule)
                .sheet(isPresented: $showingSheet) {
                    NavigationStack {
                        NewDreamForm().navigationTitle("New dream")
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
    DreamListView()
}
