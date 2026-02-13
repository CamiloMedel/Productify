//
//  TimerListingsView.swift
//  Productify
//
//  Created by Camilo Medel on 2/9/26.
//

import SwiftUI

struct TimerListingsView: View {
    let category: Category
    @State private var showCreateTimerView: Bool = false
    
    var body: some View {
        List {
            HStack {
                Spacer()
                Image(systemName: category.icon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 75, alignment: .center)
                    .foregroundStyle(Color(hex: category.colorHex))
                Spacer()
            }
            .listRowBackground(Color.clear)
            .listRowSeparator(.hidden)
            
            Section("Your Configurations") {
                ForEach(category.configs) { config in
                    NavigationLink(value: Route.timer(configuration: config)) {
                        HStack {
                            Image(systemName: config.mode == .countdown ? "hourglass" : "stopwatch")
                            Text(config.name)
                        }
                    }
                }
                
                if category.configs.isEmpty {
                 
                    Text("No configurations yet.")
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            }
        }
        .navigationTitle(category.name)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    // Create timer
                    showCreateTimerView = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    // Open timer listings options
                } label: {
                    Image(systemName: "ellipsis")
                }
            }
        }
        .sheet(isPresented: $showCreateTimerView) {
            CreateTimerView(category: category)
        }
    }
}

#Preview {
    TimerListingsView(category: Category(name: "Sleep", icon: "bed", colorHex: "#6C3BAA"))
}
