//
//  TimerEngineFormatter.swift
//  Productify
//
//  Created by Camilo Medel on 2/10/26.
//

import Foundation

enum TimerEngineFormatter {
    static func format(seconds: TimeInterval) -> String {
        let total = max(0, Int(seconds.rounded(.down)))
        let h = total / 3600
        let m = (total % 3600) / 60
        let s = total % 60
        if h > 0 { return String(format: "%d:%02d:%02d", h, m, s) }
        return String(format: "%d:%02d", m, s)
    }
}
