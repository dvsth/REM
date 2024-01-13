//
//  NewDreamForm.swift
//  REM
//
//  Created by Dev Seth on 1/9/24.
//

import SwiftUI
import SwiftData

struct NewDreamForm: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    
    @State private var date: Date = Date.now
    @State private var chosenMood1: String = "meh"
    @State private var chosenMood2: String = "confused"
    @State private var chosenMood3: String = "uncertain"
    @State private var details: String = ""
    @State private var wasLucid: Bool = false
    @State private var tone: String = "unclear"
    
    @FocusState private var detailsFocused: Bool
    
    let moods1 = ["happy", "meh", "sad"]
    let moods2 = ["excited", "confused", "scared"]
    let moods3 = ["confident", "uncertain", "hopeless"]
    
    var body: some View {
        Form {
            Section("Timing") {
                DatePicker("Date", selection: $date, in: ...Date.now, displayedComponents: [.date, .hourAndMinute])
                    .datePickerStyle(.compact)
            }
            Section("Dream type") {
                Toggle("Lucid dream?", isOn: $wasLucid)
                Picker("Theme", selection: $tone) {
                    ForEach(["nightmare", "memory", "joyride", "unclear"], id: \.self) {
                        theme in
                        Text(theme)
                    }
                }.pickerStyle(.automatic)
            }
            Section("Emotional state") {
                VStack {
                    Picker("Mood 1", selection: $chosenMood1) {
                        ForEach(moods1, id: \.self) { mood in
                            Text(mood).tag(mood)
                        }
                    }.pickerStyle(.segmented)
                    
                    Picker("Mood 2", selection: $chosenMood2) {
                        ForEach(moods2, id: \.self) { mood in
                            Text(mood).tag(mood)
                        }
                    }.pickerStyle(.segmented)
                    
                    Picker("Mood 3", selection: $chosenMood3) {
                        ForEach(moods3, id: \.self) { mood in
                            Text(mood).tag(mood)
                        }
                    }.pickerStyle(.segmented)
                }
            }
            Section("Details") {
                VStack(alignment: .leading)
                {
                    Text("Perhaps ask yourself").font(.caption).bold()
                    Text("Have you dreamed about this setting before?\nWere there characters you didn't know from real life?\nWhat do you think this dream means?").font(.caption)
                }
                TextField("What do you remember?", text: $details, axis: .vertical)
                    .lineLimit(7...)
                    .focused($detailsFocused)
                    .toolbar {
                        ToolbarItemGroup(placement: .keyboard) {
                            Spacer()
                            Button("Done") {
                                detailsFocused = false
                            }
                        }
                    }
            }
        }
        .toolbar {
            ToolbarItemGroup(placement: .confirmationAction) {
                Button {
                    let newDream = Dream(added: Date.now, dreamt: date, isLucid: wasLucid, tone: tone, mood1: chosenMood1, mood2: chosenMood2, mood3: chosenMood3, details: details)
                    modelContext.insert(newDream)
                    dismiss()
                }
                label : {
                    Image(systemName: "pin.fill")
                    Text("Save")
                }
                .tint(.purple)
                .buttonStyle(.bordered)
                .buttonBorderShape(.capsule)
            }
            ToolbarItemGroup(placement: .cancellationAction) {
                Button("Cancel") {
                    dismiss()
                }
                .tint(.purple)
            }
        }
    }
}

#Preview {
    NewDreamForm()
}
