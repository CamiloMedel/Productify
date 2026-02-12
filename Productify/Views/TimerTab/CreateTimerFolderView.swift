//
//  CreateTimerFolderView.swift
//  Productify
//
//  Created by Camilo Medel on 2/12/26.
//

import SwiftUI
import SwiftData

struct CreateTimerFolderView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    private var isReadyToCreate: Bool {
        return !name.isEmpty
    }
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    
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
                    // create folder
                    Button {
                        // validate if folder is ready to be created, else alert user
                        if isReadyToCreate {
                            // create folder
                            let category = Category(name: name, icon: symbol, colorHex: UIColor(color).toHexString())
                            modelContext.insert(category)
                            do {
                                try modelContext.save()
                                dismiss()
                            } catch {
                                alertMessage = "Error saving category. Please try again."
                                showAlert = true
                            }
                            
                        } else {
                            // Not ready error only occurs when name field is missing
                            alertMessage = "Please enter a name for the folder."
                            showAlert = true
                        }
                    } label: {
                        Label("Create", systemImage: "checkmark")
                    }
                    .tint(isReadyToCreate ? nil : Color(UIColor.systemGray3))
                    
                }
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Error Creating Folder"), message: Text(alertMessage))
            }
        }
    }
}

#Preview {
    CreateTimerFolderView()
}
