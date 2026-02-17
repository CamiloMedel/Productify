//
//  TimerConfigDraft.swift
//  Productify
//
//  Created by Camilo Medel on 2/13/26.
//

import Foundation

struct TimeSegmentDraft: Hashable, Identifiable {
    let id = UUID()
    var kind: SegmentKind = .none
    var durationSeconds: Int = 0
    
    var title: String = ""
    
    var subSegments: [TimeSegmentDraft] = []
}
