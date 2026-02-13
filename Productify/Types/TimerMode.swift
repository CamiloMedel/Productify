//
//  TimerMode.swift
//  Productify
//
//  Created by Camilo Medel on 2/9/26.
//

/// Determines how a timer will behave
enum TimerMode: String, Codable, CaseIterable, Identifiable {
    var id: String { self.rawValue }
    
    case countdown  // automatic phase switches based on time
    case stopwatch  // usere manually advances the phase
}
