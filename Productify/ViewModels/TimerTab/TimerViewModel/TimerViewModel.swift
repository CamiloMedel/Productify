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
    
    // time segmentation properties
    private var currSegmentIndex = 0
    private var segments: [TimeSegment] = []
    private var hasNextSegment: Bool {
        if currSegmentIndex + 1 < segments.count { return true }
        return false
    }
    private var didAdvanceOnFinish = false
    
    init(mode: TimerMode, countdownSeconds: TimeInterval = 0, timeSegments: [TimeSegment]) {
        self.mode = mode
        self.engine = TimerEngineService(mode: mode, countdownSeconds: countdownSeconds)
        self.engine.delegate = self
        self.segments = timeSegments
        // initial display update
        updateDisplay(elapsed: 0, remaining: countdownSeconds, state: state)
    }
    
    /// Plays and pauses the timer
    func togglePlayPause() { engine.toggle() }
    
    /// Resets the timer
    func reset() { engine.reset() }
    
    /// Called by TimerEngineService in order to update UI on each second tick call
    func timerDidTick(elapsed: TimeInterval, remaining: TimeInterval, state: TimerRunState) {
        // start next time segment if available, once a current segment is ended
        if state == .finished && hasNextSegment && !didAdvanceOnFinish {
            didAdvanceOnFinish = true // used to avoid timing scenario where this method is called multiple times on a finished state
            currSegmentIndex += 1
            engine.load(duration: TimeInterval(segments[currSegmentIndex].durationSeconds!))
            engine.start()
        }
        updateDisplay(elapsed: elapsed, remaining: remaining, state: state)
    }
    
    func updateDisplay(elapsed: TimeInterval, remaining: TimeInterval, state: TimerRunState) {
        self.state = state
        let seconds = mode == .stopwatch ? elapsed : remaining
        self.displayTime = TimerEngineFormatter.format(seconds: seconds)
    }
}
