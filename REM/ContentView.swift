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
    @State var tabSelection = 0
    @State private var viewChangelog = false
    
    var body: some View {
            TabView(selection: $tabSelection) {
                NavigationStack {
                    VStack(alignment: .leading) {
                        Spacer()
                        Spacer()
                        if tabSelection == 0 {
                            AddDreamView()
                        }
                        DreamListView()
                            .navigationTitle("Your dream log")
                    }
                }.tabItem {
                    Label("Log", systemImage: "book.pages")
                }.tag(0)
                NavigationStack {
                    if tabSelection == 1 {
                        InsightsView().navigationTitle("Insights")
                    }
                }
                .background(.white)
                .tabItem {
                    Label("Insights", systemImage: "timelapse")
                }.tag(1)
                NavigationStack {
                    ChangelogView().navigationTitle("What's cooking")
                }.tabItem {
                    Label("What's cooking", systemImage: "wand.and.stars.inverse")
                }.tag(2)
                NavigationStack {
                    AboutView()
                }.tabItem {
                    Label("About", systemImage: "info.windshield")
                }.tag(3)
            }
            .tint(.purple)
            .sheet(isPresented: $viewChangelog) {
                NavigationStack {
                    ChangelogView().navigationTitle("What's new")
                }
            }.background(.ultraThinMaterial)
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Dream.self, configurations: config)
    
    let dream = Dream(tone: "nightmare", mood1: "sad",mood2: "neutral",mood3: "confident", details: "I dreamed about a red wave that crossed the ocean with me surfing on it like Paul Atreides riding an ornithopter on Arrakis")
    let dream2 = Dream(isLucid: true, tone: "nightmare", mood1: "sad",mood2: "neutral",mood3: "confident", details: "I dreamed about a red wave that crossed the ocean with me surfing on it like Paul Atreides riding an ornithopter on Arrakis")
    container.mainContext.insert(dream)
    container.mainContext.insert(dream2)
    
    return ContentView(tabSelection: 0)
        .modelContainer(container)
}


