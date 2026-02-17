//
//  SegmentKind.swift
//  Productify
//
//  Created by Camilo Medel on 2/9/26.
//

import Foundation

/// Determines how a segment will behave
enum SegmentKind: String, Codable, CaseIterable, Identifiable {
    var id: String { self.rawValue }
    // name of time segments within timer
    case none, warmup, work, rest, cooldown, custom
}
