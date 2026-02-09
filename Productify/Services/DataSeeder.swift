//
//  DataSeeder.swift
//  Productify
//
//  Created by Camilo Medel on 2/9/26.
//
import SwiftData

/// Seeds model data on app first launch
struct DataSeeder {
    /// seeds default categories and timers
    func seedDefaults(into context: ModelContext) async {
        
        // Categories
        let study = Category(name: "Study", icon: "pencil", colorHex: "#00B4D8")
        let workout = Category(name: "Workout", icon: "dumbbell", colorHex: "#FF0000")
        
        // Pomodoro - 25 mins work / 5 min break - automatic countdown intervals
        let pomodoro = TimerConfig(
            name: "Pomodoro",
            mode: .countdown,
            category: study
        )
        
        context.insert(pomodoro)
        
        // Pomodoro segments
        let pomodoro1 = TimeSegment(order: 0, kind: .work, durationSeconds: 25 * 60, config: pomodoro) // 25 minute work session
        let pomodoro2 = TimeSegment(order: 1, kind: .rest, durationSeconds: 5 * 60, config: pomodoro) // 5 minute study session
        
        context.insert(pomodoro1)
        context.insert(pomodoro2)
        
        
        // Strength Workout - work/rest - stopwatch manual segments
        let strength = TimerConfig(
            name: "Strength",
            mode: .stopwatch,
            category: workout
        )
        
        context.insert(strength)
        
        // Strength segments
        let strength1 = TimeSegment(order: 0, kind: .work, durationSeconds: nil, config: strength)
        let strength2 = TimeSegment(order: 1, kind: .rest, durationSeconds: nil, config: strength)
        context.insert(strength1)
        context.insert(strength2)
        
        do {
            try context.save()
        }  catch {
            // Handle error with seeding data
            print("Error seeding data: \(error)")
        }
    }
}
