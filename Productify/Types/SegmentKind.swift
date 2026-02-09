//
//  SegmentKind.swift
//  Productify
//
//  Created by Camilo Medel on 2/9/26.
//

/// Determines how a segment will behave
enum SegmentKind: String, Codable {
    // name of time segments within timer
    case warmup, work, rest, cooldown, custom
}
