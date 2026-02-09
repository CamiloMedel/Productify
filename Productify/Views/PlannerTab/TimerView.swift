//
//  TimerView.swift
//  Productify
//
//  Created by Camilo Medel on 2/9/26.
//

import SwiftUI

struct TimerView: View {
    
    var body: some View {
        VStack {
            CategoryTile(title: "Workout", bgIcon: nil, color: Color.red)
        }
        .navigationTitle(Text("Timers"))
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    // allow user to add a tile
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
    }
    

}

// MARK: Subviews
private extension TimerView {
    struct CategoryTile: View {
        let title: String
        var bgIcon: Image?
        var color: Color
        
        var body: some View {
            ZStack {
                // background
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .frame(height: 100)
                        .foregroundColor(color)
                    
                    if let bgIcon {
                        bgIcon
                    }
                    
                }
                .overlay {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.black.opacity(0.1))
                }
                
                // tint
                
                
                // text
                Text(title)
                    .font(.headline)
                    .foregroundColor(.white)
                
            }
        }
    }
}

#Preview {
    TimerView()
}
