//
//  ContentView.swift
//  Productify
//
//  Created by Camilo Medel on 2/8/26.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @AppStorage("hasSeededDefaults") private var hasSeededDefaults = false
    
    private let seeder = DataSeeder()
    
    var body: some View {
        TabView {
            Tab("Timers", systemImage: "timer") {
                NavigationStack {
                    TimerView()
                }
            }
            
            Tab("Planner", systemImage: "book") {
                NavigationStack {
                    PlannerView()
                }
            }
        }
        .task {
            guard !hasSeededDefaults else { return }
            await seeder.seedDefaults(into: modelContext)
            hasSeededDefaults = true
        }
    }
}

#Preview {
    ContentView()
}
