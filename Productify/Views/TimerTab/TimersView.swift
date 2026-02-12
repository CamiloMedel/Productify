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
    
    @Binding var path: [Route]
    let namespace: Namespace.ID
    
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    @State private var showCreateTimerFolderView: Bool = false
    
    var body: some View {
        VStack {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(categories) { category in
                    CategoryTile(
                        title: category.name,
                        icon: Image(systemName: category.icon),
                        color: Color(hex: category.colorHex)
                    )
                    .onTapGesture {
                        path.append(.timerListings(category: category))
                    }
                    .matchedTransitionSource(id: category.id, in: namespace)
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
                    showCreateTimerFolderView = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $showCreateTimerFolderView) {
            CreateTimerFolderView()
        }
    }
    

}

#Preview {
    //TimerView()
    
}
