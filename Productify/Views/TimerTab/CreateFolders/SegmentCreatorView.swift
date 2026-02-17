//
//  SegmentCreatorView.swift
//  Productify
//
//  Created by Camilo Medel on 2/13/26.
//

import SwiftUI

struct SegmentCreatorView: View {
    @Environment(\.dismiss) private var dismiss
    @FocusState private var isFocused: Bool
    
    @State private var isReadyToCreate: Bool = false
    
    // properties for making timer segment
    @State private var name: String = ""
    @State private var kind: SegmentKind = .none
    private let parent: TimeSegmentDraft? = nil
    
    // Time tracking
    @State private var hours = 0
    @State private var minutes = 0
    @State private var seconds = 0
    var durationSeconds: Int {
        hours * 3600 + minutes * 60 + seconds
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Name", text: $name)
                    
                    Picker("Type", selection: $kind) {
                        ForEach (SegmentKind.allCases) { mode in
                            Text(mode.rawValue.capitalized).tag(mode)
                        }
                    }
                }
                
                Section("Total Duration"){
                    HStack {
                        // total duration field
                        Spacer()
                        DurationPickerWithLabels(hours: $hours, minutes: $minutes, seconds: $seconds)
                        Spacer()
                    }
                    
                    
                    // subsegments field
                        
                }
            }
            .navigationBarTitle("Create Segment")
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
                        // create timer
                    } label: {
                        Label("Create", systemImage: "checkmark")
                    }
                    .tint(isReadyToCreate ? nil : Color(UIColor.systemGray3))
                }
            }
        }
    }
}

#Preview {
    //SegmentCreatorView()
}
