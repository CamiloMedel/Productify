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
    
    // Time tracking
    @State private var hours = 0
    @State private var minutes = 0
    @State private var seconds = 0
    var durationSeconds: Int {
        hours * 3600 + minutes * 60 + seconds
    }
    
    @State private var isSubsegmentsEnabled: Bool = false
    
    @State private var subsegmentDrafts: [TimeSegmentDraft] = []
    @State private var isShowingSubsegmentCreator = false
    var availableTimeForSubsegments : String {
        "\(hours)h \(minutes)m \(seconds)s"
    }
    
    let parentMode: TimerMode
    @State private var segmentMode: TimerMode = .countdown
    
    var displaySuffixString: String {
        segmentMode == .countdown ? "interval" : "section"
    }
    
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
                
                if segmentMode == .countdown {
                    Section("Total Duration"){
                        HStack {
                            // total duration field
                            Spacer()
                            DurationPickerWithLabels(hours: $hours, minutes: $minutes, seconds: $seconds)
                            Spacer()
                        }
                    }
                }
                
                // subsegments section
                Section {
                    Toggle("Sub\(displaySuffixString)s", isOn: $isSubsegmentsEnabled)
                    
                    if(isSubsegmentsEnabled) {
                        // subsegments field
                        VStack(alignment: .leading) {
                            // header
                            HStack {
                                Text("Sub\(displaySuffixString)")
                                
                                Spacer()
                                // Add subsegment
                                Button {
                                    isShowingSubsegmentCreator = true
                                } label: {
                                    Image(systemName: "plus")
                                }
                            }
                            
                            // available time for subsegments display
                            if segmentMode == .countdown {
                                HStack {
                                    Text("Available Time: \(hours)h \(minutes)m \(seconds)s")
                                        .foregroundStyle(.secondary)
                                        .font(Font.caption.bold())
                                }
                            }
                            
                            // TODO:  SUBSEGMENTS DISPLAY
                            List(subsegmentDrafts) { subsegment in
                                HStack {
                                    VStack {
                                        Text(subsegment.title)
                                        Text("Type: \(subsegment.kind.rawValue.capitalized)")
                                    }
                                    Spacer()
                                    Text("\(subsegment.durationSeconds)")
                                }
                            }
                        }
                        
                        // Inline add subsegment button
                        Button {
                            isShowingSubsegmentCreator = true
                        } label: {
                            Text("Add Sub\(displaySuffixString)")
                        }
                    }
                }
            }
            .navigationBarTitle("Create \(displaySuffixString.capitalized)")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        // create timer
                        // TODO: SEGMENT CREATION AND VALIDATION WITH SUBSEGMENTS
                    } label: {
                        Label("Create", systemImage: "checkmark")
                    }
                    .tint(isReadyToCreate ? nil : Color(UIColor.systemGray3))
                }
            }
            .navigationDestination(isPresented: $isShowingSubsegmentCreator) {
                SubsegmentCreatorView(parentTimerMode: segmentMode) { subsegment in
                    subsegmentDrafts.append(subsegment)
                }
            }
            .onAppear {
                // TODO: MAKE SEGMENT MODE THE PROPER MODE IF SEGMENET IS BEING EDITED, ELSE MAKE IT PARENT MODE
                segmentMode = parentMode
            }
        }
    }
}

#Preview {
    //SegmentCreatorView()
}
