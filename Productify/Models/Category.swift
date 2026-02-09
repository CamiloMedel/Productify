//
//  Category.swift
//  Productify
//
//  Created by Camilo Medel on 2/9/26.
//

import SwiftData

/// Represents a timer category ( user made or default )
/// Stores the categories' name, icon, color hex, and as well as the relationship to the configurations it owns
@Model
class Category {
    var name: String
    var icon: String
    var colorHex: String
    
    @Relationship(deleteRule: .cascade, inverse: \TimerConfig.category)
    var configs: [TimerConfig] = []
    
    init(name: String, icon: String, colorHex: String) {
        self.name = name
        self.icon = icon
        self.colorHex = colorHex
    }
}
