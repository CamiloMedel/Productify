//
//  ContentView.swift
//  Productify
//
//  Created by Camilo Medel on 2/8/26.
//

import SwiftUI
import CoreData

struct ContentView: View {
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
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
