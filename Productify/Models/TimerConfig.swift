//
//  TimerConfig.swift
//  Productify
//
//  Created by Camilo Medel on 2/9/26.
//

import SwiftData

/// Represents a default or user made timer configuration.
/// Stores a timers name and mode, with a relationship to the timer segments it owns
@Model
class TimerConfig {
    var name: String
    var mode: TimerMode
    
    @Relationship(deleteRule: .cascade)
    var segments: [TimeSegment] = []
    
    init(name: String, mode: TimerMode) {
        self.name = name
        self.mode = mode
    }
}
