//
//  CreateTimerView.swift
//  Productify
//
//  Created by Camilo Medel on 2/12/26.
//

import SwiftUI

struct CreateTimerView: View {
    @Environment(\.dismiss) private var dismiss
    @FocusState private var isFocused: Bool
    
    @State private var isReadyToCreate: Bool = false
    
    let category: Category
    
    @State private var name: String = ""
    @State private var mode: TimerMode = .countdown
    @State private var timeSegments: [TimeSegmentDraft] = []
    
    @State private var isShowingSegmentCreator: Bool = false
    
    var body: some View {
        NavigationStack {
            Form {
                // Fields for creating timer configuration
                Section {
                    TextField("Name", text: $name)
                        .focused($isFocused)
                    
                    Picker("Type", selection: $mode) {
                        ForEach (TimerMode.allCases) { mode in
                            Text(mode.rawValue.capitalized).tag(mode)
                        }
                    }
                }
                
                // Fields for creating time segments
                Section {
                    // Header
                    HStack {
                        Text("Time Segments")
                        Spacer()
                        HStack {
                            if timeSegments.count > 0 {
                                EditButton()
                            }
                            
                            // Add main segment
                            Button {
                                isShowingSegmentCreator = true
                            } label: {
                                Image(systemName: "plus")
                            }
                        }
                    }
                    
                    // Segment display
                    ForEach(timeSegments) { segment in
                        // Segment
                        HStack {
                            VStack {
                                if let title = segment.title {
                                    Text(title)
                                }
                                Text(segment.kind?.rawValue.capitalized ?? "")
                            }
                            
                            Spacer()
                            
                            if let duration = segment.durationSeconds {
                                Text("\(duration)")
                            }
                        }
                        
                        // Sub segments
                        ForEach(segment.subSegments) { subSegment in
                            HStack {
                                VStack {
                                    if let title = segment.title {
                                        Text(title)
                                    }
                                    Text(segment.kind?.rawValue.capitalized ?? "")
                                        .font(Font.caption.italic())
                                }
                                Spacer()
                                
                                if let duration = segment.durationSeconds {
                                    Text("\(duration)")
                                }
                            }
                        }
                    }
                    
                    // Inline add segment button
                    Button {
                        isShowingSegmentCreator = true
                    } label: {
                        Text("Add Segment")
                    }
                }
                
            }
            .navigationTitle("Create Timer")
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
        .onAppear {
            // focus on name field on form open
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                isFocused = true
            }
        }
        .scrollDismissesKeyboard(.immediately)
        .sheet(isPresented: $isShowingSegmentCreator) {
            SegmentCreatorView()
        }
    }
}

#Preview {
    CreateTimerView(category: Category(name: "Sleep", icon: "bed", colorHex: "#6C3BAA"))
}
