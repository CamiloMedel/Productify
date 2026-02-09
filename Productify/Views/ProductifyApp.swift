//
//  ProductifyApp.swift
//  Productify
//
//  Created by Camilo Medel on 2/8/26.
//

import SwiftUI
import CoreData

@main
struct ProductifyApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
