//
//  REMApp.swift
//  REM
//
//  Created by Dev Seth on 1/9/24.
//

import SwiftUI
import SwiftData

@main
struct REMApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Dream.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    @State private var animationSecondsLeft = -1.0
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    
    var body: some Scene {
        WindowGroup {
            Group {
                if animationSecondsLeft > 0 {
                    Text("Hello world")
                }
                else {
                    ContentView()
                }
            }.onReceive(timer, perform: { _ in
                if animationSecondsLeft < 0 {
                    timer.upstream.connect().cancel()
                }
                else {
                    animationSecondsLeft-=1
                }
            })
        }
        .modelContainer(sharedModelContainer)
    }
}
