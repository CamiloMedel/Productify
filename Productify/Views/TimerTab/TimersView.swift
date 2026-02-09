//
//  TimerView.swift
//  Productify
//
//  Created by Camilo Medel on 2/9/26.
//

import SwiftUI
import _SwiftData_SwiftUI

struct TimersView: View {
    @Query(sort: \Category.name) private var categories: [Category]
    
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(categories) { category in
                    CategoryTile(
                        title: category.name,
                        icon: Image(systemName: category.icon),
                        color: Color(hex: category.colorHex)
                    )
                }
            }
            .padding(.horizontal)
            
            Spacer()
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
private extension TimersView {
    struct CategoryTile: View {
        let title: String
        var icon: Image
        var color: Color
        
        var body: some View {
            ZStack {
                // background with tint
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .frame(height: 100)
                        .foregroundColor(color)
                }
                
                VStack {
                    icon
                    // text
                    Text(title)
                        .font(.headline)
                }
                .foregroundColor(.white)
            }
        }
    }
}

#Preview {
    //TimerView()
    
}
