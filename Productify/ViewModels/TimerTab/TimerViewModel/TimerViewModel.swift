//
//  TimerViewModel.swift
//  Productify
//
//  Created by Camilo Medel on 2/10/26.
//

import Combine
import Foundation

@MainActor
class TimerViewModel: ObservableObject, TimerEngineDelegate {
    @Published var state: TimerRunState = .idle
    @Published var displayTime: String = "0:00"
    
    private let mode: TimerMode
    private let engine: TimerEngineService
    
    init(mode: TimerMode, countdownSeconds: TimeInterval = 0) {
        self.mode = mode
        self.engine = TimerEngineService(mode: mode, countdownSeconds: countdownSeconds)
        self.engine.delegate = self
    }
    
    /// Plays and pauses the timer
    func togglePlayPause() { engine.toggle() }
    
    /// Resets the timer
    func reset() { engine.reset() }
    
    /// Called by TimerEngineService in order to update UI on each second tick call
    func timerDidTick(elapsed: TimeInterval, remaining: TimeInterval, state: TimerRunState) {
        updateDisplay(elapsed: elapsed, remaining: remaining, state: state)
    }
    
    func updateDisplay(elapsed: TimeInterval, remaining: TimeInterval, state: TimerRunState) {
        self.state = state
        let seconds = mode == .stopwatch ? elapsed : remaining
        self.displayTime = TimerEngineFormatter.format(seconds: seconds)
    }
}
