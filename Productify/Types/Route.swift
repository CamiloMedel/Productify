//
//  Route.swift
//  Productify
//
//  Created by Camilo Medel on 2/9/26.
//

enum Route: Hashable {
    case timerListings(category: Category)
    case timer(configuration: TimerConfig)
}
