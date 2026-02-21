//
//  SubsegmentFieldView.swift
//  Productify
//
//  Created by Camilo Medel on 2/17/26.
//

import SwiftUI

struct SubsegmentCreatorView: View {
    @Environment(\.dismiss) private var dismiss
    
    // properties for making timer segment
    @State private var name: String = ""
    @State private var kind: SegmentKind = .none
    let parentTimerMode: TimerMode
    
    // Time tracking
    @State private var hours = 0
    @State private var minutes = 0
    @State private var seconds = 0
    var durationSeconds: Int {
        hours * 3600 + minutes * 60 + seconds
    }
    
    private var isReadyToCreate: Bool {
        durationSeconds > 0
    }
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    
    let onCreate: (TimeSegmentDraft) -> Void
    
    var body: some View {
        VStack {
            Form {
                Section {
                    TextField("Name", text: $name)
                    
                    Picker("Category", selection: $kind) {
                        ForEach (SegmentKind.allCases) { mode in
                            Text(mode.rawValue.capitalized).tag(mode)
                        }
                    }
                }
                
                if (parentTimerMode == .countdown) {
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
            }
            .navigationTitle("Create Sub\(parentTimerMode == .countdown ? "interval" : "section")")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        // create timer
                        // TODO: SUBSEGMENT CREATION AND VALIDATION
                        if isReadyToCreate {
                            let newSegment = TimeSegmentDraft(
                                kind: kind,
                                durationSeconds: durationSeconds,
                                title: name
                            )
                            
                            onCreate(newSegment)
                            dismiss()
                        } else {
                            // Not ready error only occurs if time interval is set to 0
                            alertMessage = "Please set a valid time duration greater than 0."
                            showAlert = true
                        }
                    } label: {
                        Label("Create", systemImage: "checkmark")
                    }
                    .tint(isReadyToCreate ? nil : Color(UIColor.systemGray3))
                }
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Error Creating Subsegment"), message: Text(alertMessage))
            }
        }
    }
}

#Preview {
    SubsegmentCreatorView(parentTimerMode: .countdown) { _ in
        
    }
}
