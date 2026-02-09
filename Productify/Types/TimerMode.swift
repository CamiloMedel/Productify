//
//  TimerMode.swift
//  Productify
//
//  Created by Camilo Medel on 2/9/26.
//

enum TimerMode: String, Codable {
    case stopwatch  // usere manually advances the phase
    case countdown  // automatic phase switches based on time
}
