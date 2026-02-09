//
//  TimeSegment.swift
//  Productify
//
//  Created by Camilo Medel on 2/9/26.
//

import SwiftData

/// Represents a time segment within a timer config.
/// Stores the segments order in the config, it's kind, and duration in seconds
@Model
class TimeSegment {
    var order: Int
    var kind: SegmentKind
    var durationSeconds: Int?
    
    init(order: Int, kind: SegmentKind, durationSeconds: Int?){
        self.order = order
        self.kind = kind
        self.durationSeconds = durationSeconds
    }
}
