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
        // setup mode, initial timer length, and remaining time
        self.mode = mode
        self.initialDuration = max(0, countdownSeconds)
        self.remaining = max(0, countdownSeconds)
    }
    
    func toggle() {
        // On call of toggle, determine what action to take based on current timer state
        switch state {
        case .idle: start()
        case .running: pause()
        case .paused: resume()
        case .finished: reset(); start()
        }
    }
    
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
    
    func pause(){}
    
    func resume(){}
    
    func reset(){}
    
    private func tick(){}
    
    func notifyDelegate() {
        delegate?.timerDidTick(elapsed: elapsed, remaining: remaining, state: state)
    }
}
