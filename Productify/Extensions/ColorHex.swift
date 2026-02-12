//
//  ColorHex.swift
//  Productify
//
//  Created by Camilo Medel on 2/9/26.
//

import SwiftUI

extension Color {
    /// extension converts color hex (eg. #FFFFFF) to its corresponding Color
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: .whitespacesAndNewlines)
            .replacingOccurrences(of: "#", with: "")
        
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        
        let r, g, b: Double
        
        switch hex.count {
        case 6: // RRGGBB
            r = Double((int >> 16) & 0xFF) / 255.0
            g = Double((int >> 8) & 0xFF) / 255.0
            b = Double(int & 0xFF) / 255.0
        default:
            r = 0
            g = 0
            b = 0
        }
        
        self.init(red: r, green: g, blue: b)
    }
}

extension UIColor {
    /// Converts UIColor to hex string (ex. #FFFFFF)
    func toHexString(includeAlpha: Bool = false) -> String {
            // Get the red, green, and blue components as floats between 0 and 1
            let components = self.cgColor.components!
            
            let red = Int(components[0] * 255.0)
            let green = Int(components[1] * 255.0)
            let blue = Int(components[2] * 255.0)
            
            // Format the components into a hex string
            let hexString: String
            if includeAlpha, let alpha = components.last {
                let alphaValue = Int(alpha * 255.0)
                hexString = String(format: "#%02X%02X%02X%02X", red, green, blue, alphaValue)
            } else {
                hexString = String(format: "#%02X%02X%02X", red, green, blue)
            }
            
            return hexString
        }
}
