//
//  DataSeeder.swift
//  Productify
//
//  Created by Camilo Medel on 2/9/26.
//
import SwiftData

/// Seeds model data on app first launch
struct DataSeeder {
    /// seeds default categories
    func seedDefaults(into context: ModelContext) async {
        context.insert(Category(name: "Workout", icon: "dumbbell", colorHex: "#FF0000"))
        context.insert(Category(name: "Pomodoro", icon: "pencil", colorHex: "#00B4D8"))
        try? context.save()
    }
}
