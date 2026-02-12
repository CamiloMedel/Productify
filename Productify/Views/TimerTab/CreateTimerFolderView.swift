//
//  CreateTimerFolderView.swift
//  Productify
//
//  Created by Camilo Medel on 2/12/26.
//

import SwiftUI

struct CreateTimerFolderView: View {
    @State private var readyToCreate: Bool = false
    @Environment(\.dismiss) private var dismiss
    
    // properties needed to make category folder
    @State private var name: String = ""
    @State private var color: Color = .blue
    @State private var symbol: String = "sparkles"
    
    @FocusState private var isFocused: Bool
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Name", text: $name)
                        .focused($isFocused)
                }
                
                Section {
                    ColorPicker("Folder Color", selection: $color)
                    
                    SFSymbolPicker(selectedSymbol: $symbol)
                        .buttonStyle(PlainButtonStyle())
                    
                    // Preview window
                    VStack(alignment: .leading) {
                        Text("Preview")
                        
                        HStack {
                            Spacer()
                            CategoryTile(title: name, icon: Image(systemName: symbol), color: color)
                                .frame(maxWidth: 200)
                            Spacer()
                        }
                    }
                }
            }
            .onAppear {
                // focus on name field on form open
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                    isFocused = true
                }
            }
            .scrollDismissesKeyboard(.immediately)
            .navigationTitle("Create Timer Folder")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        
                    } label: {
                        Label("Create", systemImage: "checkmark")
                    }
                    .tint(readyToCreate ? nil : Color(UIColor.systemGray3))
                }
            }
        }
    }
}

#Preview {
    CreateTimerFolderView()
}
