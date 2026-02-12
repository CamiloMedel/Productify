//
//  CategoryTile.swift
//  Productify
//
//  Created by Camilo Medel on 2/12/26.
//

import SwiftUI

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
                    .multilineTextAlignment(.center)
            }
            .foregroundColor(.white)
        }
    }
}

#Preview {
    CategoryTile(title: "Category", icon: Image(systemName: "camera"), color: .red)
}
