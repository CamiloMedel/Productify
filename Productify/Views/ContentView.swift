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
    
    // navigation vars
    @State private var timersPath: [Route] = []
    @State private var plannerPath: [Route] = []
    @Namespace private var ns
    
    private let seeder = DataSeeder()
    
    var body: some View {
        TabView {
            Tab("Timers", systemImage: "timer") {
                NavigationStack(path: $timersPath) {
                    TimersView(path: $timersPath, namespace: ns)
                        .navigationDestination(for: Route.self) { route in
                            switch route {
                            case .timerListings(let category):
                                TimerListingsView(category: category)
                                    .navigationTransition(.zoom(sourceID: category.id, in: ns))
                            case .timer(let config):
                                TimerView(configuration: config)
                            }
                        }
                }
            }
            
            Tab("Planner", systemImage: "book") {
                NavigationStack(path: $plannerPath) {
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
