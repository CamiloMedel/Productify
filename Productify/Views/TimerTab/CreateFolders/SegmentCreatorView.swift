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
    
    @State private var subsegmentDrafts: [TimeSegmentDraft] = []
    @State private var isShowingSubsegmentCreator = false
    var availableTimeForSubsegments : String {
        "\(hours)h \(minutes)m \(seconds)s"
    }
    
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
                    HStack {
                        // total duration field
                        Spacer()
                        DurationPickerWithLabels(hours: $hours, minutes: $minutes, seconds: $seconds)
                        Spacer()
                    }
                    
                    // subsegments field
                    VStack(alignment: .leading) {
                        // header
                        HStack {
                            Text("Subsegments")
                            
                            Spacer()
                            // Add subsegment
                            Button {
                                isShowingSubsegmentCreator = true
                            } label: {
                                Image(systemName: "plus")
                            }
                        }
                        
                        // available time for subsegments display
                        HStack {
                            Text("Available Time: \(hours)h \(minutes)m \(seconds)s")
                                .foregroundStyle(.secondary)
                                .font(Font.caption.bold())
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
                        Text("Add Subsegment")
                    }
                }
            }
            .navigationBarTitle("Create Segment")
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
                SubsegmentCreatorView()
            }
        }
    }
}

#Preview {
    //SegmentCreatorView()
}
