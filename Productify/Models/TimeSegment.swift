//
//  TimeSegment.swift
//  Productify
//
//  Created by Camilo Medel on 2/9/26.
//

import SwiftData
import Foundation

/// Represents a time segment within a timer config.
/// Stores the segments order in the config, it's kind, and duration in seconds
@Model
class TimeSegment {
    var kind: SegmentKind
    var durationSeconds: Int?
    
    var title: String?
    
    var config: TimerConfig
    
    @Relationship(deleteRule: .cascade, inverse: \TimeSegment.parent)
    var subSegments: [TimeSegment] = []
    
    var parent: TimeSegment?
    
    init(kind: SegmentKind = .none, durationSeconds: Int?, config: TimerConfig, title: String? = nil, parent: TimeSegment? = nil){
        self.kind = kind
        self.durationSeconds = durationSeconds
        self.config = config
        self.title = title
        self.parent = parent
    }
}
