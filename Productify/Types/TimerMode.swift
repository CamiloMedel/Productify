//
//  TimerMode.swift
//  Productify
//
//  Created by Camilo Medel on 2/9/26.
//

/// Determines how a timer will behave
enum TimerMode: String, Codable {
    case stopwatch  // usere manually advances the phase
    case countdown  // automatic phase switches based on time
}
