//
//  TimerView.swift
//  Productify
//
//  Created by Camilo Medel on 2/9/26.
//

import SwiftUI

struct TimerView: View {
    @StateObject private var viewModel: TimerViewModel
    let configuration: TimerConfig
    
    init(configuration: TimerConfig) {
        self.configuration = configuration
        _viewModel = StateObject(wrappedValue: TimerViewModel(mode: configuration.mode))
    }
    
    var body: some View {
        VStack {
            Text(viewModel.displayTime)
                .font(.system(size: 64, weight: .semibold, design: .rounded))
                .monospacedDigit()
            Button {
                viewModel.togglePlayPause()
            } label: {
                Text(buttonTitle)
            }
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
    
    private var buttonTitle: String {
        switch viewModel.state {
        case .idle: "Start"
        case .running: "Pause"
        case .paused: "Resume"
        case .finished: "Restart"
        }
    }
}

#Preview {
    TimerView(configuration: TimerConfig(name: "Sleep Time", mode: .stopwatch, category: Category(name: "Sleep", icon: "bed", colorHex: "#6C3BAA")))
}
