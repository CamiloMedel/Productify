//
//  DurationPickerWithLabels.swift
//  Productify
//
//  Created by Camilo Medel on 2/16/26.
//

import SwiftUI

struct DurationPickerWithLabels: View {
    @Binding var hours: Int
    @Binding var minutes: Int
    @Binding var seconds: Int
    
    private let maxWidth: CGFloat = 300
    
    var body: some View {
        GeometryReader { geo in
                    let w = geo.size.width
                    let h = geo.size.height

                    ZStack {
                        DurationPicker(hours: $hours, minutes: $minutes, seconds: $seconds)
                            .frame(width: w, height: h)

                  
                        fixedUnitLabel("hr", x: w * (1.0/6.0) + 30, y: h/2)
                        fixedUnitLabel("min", x: w * (3.0/6.0) + 30, y: h/2)
                        fixedUnitLabel("sec", x: w * (5.0/6.0) + 30, y: h/2)
                    }
                }
                .frame(height: 200)
                .frame(maxWidth: maxWidth)
    }
    
    @ViewBuilder
        private func fixedUnitLabel(_ text: String, x: CGFloat, y: CGFloat) -> some View {
            Text(text)
                .foregroundStyle(.secondary)
                .position(x: x, y: y)
                .allowsHitTesting(false)
        }
}

#Preview {
    DurationPickerWithLabels(hours: .constant(5), minutes: .constant(15), seconds: .constant(0))
}
