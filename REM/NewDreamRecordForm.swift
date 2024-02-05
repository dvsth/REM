//
//  NewDreamForm.swift
//  REM
//
//  Created by Dev Seth on 1/9/24.
//

import SwiftUI
import SwiftData

struct NewDreamRecordForm: View {
    
    @Binding var path: [String]
    
    @Environment(\.modelContext) var modelContext
    
    @State private var date: Date = Date.now
    @State private var chosenMood1: String = "meh"
    @State private var chosenMood2: String = "confused"
    @State private var chosenMood3: String = "uncertain"
    @State private var details: String = ""
    @State private var wasLucid: Bool = false
    @State private var wasRecurring: Bool = false
    @State private var tone: String = "unclear"
    
    var viewModel = RecordingViewModel(uuid: UUID())
    
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
                Toggle("Recurring dream?", isOn: $wasRecurring)
                VStack(alignment: .leading) {
                    Picker("Theme", selection: $tone) {
                        ForEach(["fun adventure", "epiphany", "reliving memory", "unclear", "vision of future", "nightmare"], id: \.self) {
                            theme in
                            Text(theme)
                        }
                    }
                    .pickerStyle(.menu)
                }
            }
            Section("Record your recollection") {
                VStack(alignment: .leading) {
                    VStack(alignment: .leading)
                    {
                        Text("Perhaps ask yourself").font(.caption).bold()
                        Text("Have you dreamed about this setting before?\nWere there characters you didn't know from real life?\nWhat do you think this dream means?")
                            .font(.caption)
                    }
                    Divider()
                    RecordView()
                    VStack(alignment: .leading) {
                        TranscribeWhisperView {
                            transcription in
                            details = (details + " " + transcription).trimmingCharacters(in: .whitespacesAndNewlines)
                        }
                    }
                }
                TextField("Write or record your recollection here...", text: $details, axis: .vertical)
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
        .environmentObject(viewModel)
        .toolbar {
            ToolbarItemGroup(placement: .topBarTrailing) {
                Button {
                    let newDream = Dream(added: Date.now, dreamt: date, isLucid: wasLucid, isRecurring: wasRecurring, tone: tone, mood1: chosenMood1, mood2: chosenMood2, mood3: chosenMood3, details: details, audioFilePath: viewModel.audioFilePath.path())
                    modelContext.insert(newDream)
                    path.removeLast()
                }
                label : {
                    Image(systemName: "pin.fill")
                    Text("Save")
                }
                .buttonStyle(.bordered)
                .buttonBorderShape(.capsule)
            }
        }
    }
}

#Preview {
    @State var path: [String] = []
    return NewDreamRecordForm(path: $path)
}
