//
//  SubsegmentFieldView.swift
//  Productify
//
//  Created by Camilo Medel on 2/17/26.
//

import SwiftUI

struct SubsegmentCreatorView: View {
    // properties for making timer segment
    @State private var name: String = ""
    @State private var kind: SegmentKind = .none
    
    // Time tracking
    @State private var hours = 0
    @State private var minutes = 0
    @State private var seconds = 0
    var durationSeconds: Int {
        hours * 3600 + minutes * 60 + seconds
    }
    
    @State private var isReadyToCreate: Bool = false
    
    var body: some View {
        VStack {
            Form {
                Section {
                    TextField("Name", text: $name)
                    
                    Picker("Kind", selection: $kind) {
                        ForEach (SegmentKind.allCases) { mode in
                            Text(mode.rawValue.capitalized).tag(mode)
                        }
                    }
                }
                
                Section("Total Duration"){
                    // TODO: UPDATE TO DISPLAY AVAILABLE TIME FOR SUBSEGMENT ( PARENT SEGMENT - OTHER SUBSEGMENT TIMES )
                    Text("Available Time: \(hours)h \(minutes)m \(seconds)s")
                        .foregroundStyle(.secondary)
                        .font(Font.caption.bold())
                    
                    HStack {
                        // total duration field
                        Spacer()
                        DurationPickerWithLabels(hours: $hours, minutes: $minutes, seconds: $seconds)
                        Spacer()
                    }
                }
            }
            .navigationTitle("Create Subsegment")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        // create timer
                        // TODO: SUBSEGMENT CREATION AND VALIDATION
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
    SubsegmentCreatorView()
}
