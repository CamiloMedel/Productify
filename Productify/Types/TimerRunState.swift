//
//  TimerRunState.swift
//  Productify
//
//  Created by Camilo Medel on 2/10/26.
//

/// Determines the state that TimerEnginerService is on
enum TimerRunState: String, Codable {
    case idle
    case running
    case paused
    case finished
}
