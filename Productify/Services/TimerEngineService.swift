//
//  TimerEngineService.swift
//  Productify
//
//  Created by Camilo Medel on 2/10/26.
//

import Foundation

/// Delegate protocol that acts on behalf of TimerEngineService by responding to timer engine updates
protocol TimerEngineDelegate: AnyObject {
    func timerDidTick(elapsed: TimeInterval, remaining: TimeInterval, state: TimerRunState)
}

/// Contains timer functionality
final class TimerEngineService {
    weak var delegate: TimerEngineDelegate?
    
    private let mode: TimerMode
    private let initialDuration: TimeInterval
    private var state: TimerRunState = .idle
    
    private var elapsed: TimeInterval = 0
    private var remaining: TimeInterval = 0
    
    private var timer: Timer?
    private var lastTick: Date?
    
    init(mode: TimerMode, countdownSeconds: TimeInterval = 0) {
        self.mode = mode
        self.initialDuration = max(0, countdownSeconds)
        self.remaining = max(0, countdownSeconds)
    }
    
    /// On call of toggle, determine what action to take based on current timer state/
    func toggle() {
        switch state {
        case .idle: start()
        case .running: pause()
        case .paused: resume()
        case .finished: reset(); start()
        }
    }
    
    /// Starts a timer's ticking, configured according to the timer's type
    func start(){
        if mode == .countdown {
            // for countdown timers we count down from the initial duration
            remaining = initialDuration
            
            // if timer starts with 0 or less than 0 seconds, automatically end timer
            if remaining <= 0 {
                state = .finished
                notifyDelegate()
                return
            }
        }
        
        // Enter timer running state
        state = .running
        lastTick = Date()
        // start the timer by calling the tick function at every passing second
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
            self?.tick()
        }
        // notify delegate that timer has started updating
        notifyDelegate()
    }
    
    /// Pauses the timer from ticking
    func pause(){
        state = .paused
        timer?.invalidate()
        timer = nil
        lastTick = nil
        notifyDelegate()
    }
    
    /// Resume the timers ticking
    func resume(){
        state = .running
        lastTick = Date()
        // resume the timer by calling the tick function at every passing second again
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
            self?.tick()
        }
        notifyDelegate()
    }
    
    /// Resets the timer by resetting it's tick, remaining time, and setting it back to idle
    func reset(){
        // resets the timer
        timer?.invalidate()
        timer = nil
        lastTick = nil
        state = .idle
        elapsed = 0
        remaining = mode == .countdown ? initialDuration : 0
        notifyDelegate()
    }
    
    /// For stopwatch timers, updates elapsed time by adding delta ( CurrentTime - lastTicksTime)
    /// For countdown timers, updates remaining time by subtracting delta ( CurrentTime - lastTicksTime)
    /// Should be called on every second change within TimerEngineService to run ticking mechanics as each second passes
    private func tick(){
        // calculate the change in time from the last tick
        let now = Date()
        let delta = now.timeIntervalSince(lastTick ?? now)
        lastTick = now
        
        switch mode {
        case .stopwatch:
            // add the change in time to the elapsed time to act as a stopwatch
            elapsed += delta
        case .countdown:
            // remove the change in time from the remaining time to act as a timer
            remaining -= delta
            // if the timer is out of remaining time, end the timer
            if remaining <= 0 {
                state = .finished
                timer?.invalidate()
                timer = nil
                lastTick = nil
            }
        }
        
        notifyDelegate()
    }
    
    // Should be called on every time tick by TimerEngineService to allow delegate to respond to each tick
    func notifyDelegate() {
        delegate?.timerDidTick(elapsed: elapsed, remaining: remaining, state: state)
    }
}
