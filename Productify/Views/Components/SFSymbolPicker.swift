//
//  SFSymbolPicker.swift
//  Productify
//
//  Created by Camilo Medel on 2/12/26.
//

import SwiftUI

/// Form field allowing user to select a SF Symbol from a list of available SF symbols
struct SFSymbolPicker: View {
    @Binding var selectedSymbol: String
    private let columns = Array(repeating: GridItem(.flexible(), spacing: 12), count: 6)
    
    var body: some View {
        VStack(alignment: .leading) {
            // Header
            Text("Symbol")
            
            // Selector
            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(SFSymbolCatalog.availableSymbols, id: \.self) { symbol in
                    Button {
                        selectedSymbol = symbol
                    } label: {
                        Image(systemName: symbol)
                    }
                    .foregroundStyle(symbol == selectedSymbol ? Color.accentColor : .secondary)
                }
            }
        }
    }
}

#Preview {
    SFSymbolPicker(selectedSymbol: Binding<String>(get: { "sparkles" }, set: { _ in }))
}
