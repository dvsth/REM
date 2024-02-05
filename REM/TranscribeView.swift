//
//  TranscribeView.swift
//  REM
//
//  Created by Dev Seth on 1/17/24.
//

import SwiftUI
import Speech

struct TranscribeView: View {
    let audioFilename: URL
    var onTranscriptionCompleted: (String) -> Void
    @State private var isTranscribing = false

    var body: some View {
        VStack {
            if isTranscribing {
                Text("Transcribing...")
            } else {
                Button("Transcribe") {
                    transcribeAudio()
                }
            }
        }
    }

    private func transcribeAudio() {
        SFSpeechRecognizer.requestAuthorization { authStatus in
            switch authStatus {
            case .authorized:
                self.startTranscription()
            default:
                print("Speech recognition authorization denied")
                self.onTranscriptionCompleted("Authorization Denied")
            }
        }
    }

    private func startTranscription() {
        guard let recognizer = SFSpeechRecognizer(), recognizer.isAvailable else {
            print("Speech recognition not available")
            self.onTranscriptionCompleted("Speech Recognition Not Available")
            return
        }

        if !recognizer.supportsOnDeviceRecognition {
            print("On-device speech recognition is not supported for the current language")
            self.onTranscriptionCompleted("On-Device Recognition Not Supported")
            return
        }

        let request = SFSpeechURLRecognitionRequest(url: audioFilename)
        request.requiresOnDeviceRecognition = true
        isTranscribing = true

        recognizer.recognitionTask(with: request) { result, error in
            DispatchQueue.main.async {
                self.isTranscribing = false
                if let result = result {
                    self.onTranscriptionCompleted(result.bestTranscription.formattedString)
                } else if let error = error {
                    print("There was an error: \(error)")
                    self.onTranscriptionCompleted("Error: \(error.localizedDescription)")
                }
            }
        }
    }

}
