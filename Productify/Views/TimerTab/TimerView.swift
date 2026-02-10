//
//  TimerView.swift
//  Productify
//
//  Created by Camilo Medel on 2/9/26.
//

import SwiftUI

struct TimerView: View {
    let configuration: TimerConfig
    var body: some View {
        VStack {
            
        }
        .navigationTitle(configuration.name)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    
                } label: {
                    Image(systemName: "ellipsis")
                }
            }
        }
    }
}

#Preview {
    TimerView(configuration: TimerConfig(name: "Sleep Time", mode: .stopwatch, category: Category(name: "Sleep", icon: "bed", colorHex: "#6C3BAA")))
}
