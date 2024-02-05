import SwiftUI
import Speech
import WhisperKit

struct TranscribeWhisperView: View {
    var onTranscriptionCompleted: (String) -> Void
    @State private var isTranscribing = false
    @State private var isLoadingModel = true
    @State private var transcription: String = ""
    
    @EnvironmentObject var viewModel: RecordingViewModel

    @State private var pipe: WhisperKit? = nil

    var body: some View {
        VStack {
            if isLoadingModel {
                HStack(spacing: 15) {
                    ProgressView()
                    Text("Loading OpenAI Whisper (tiny) model")
                        .font(.caption2)
                    Spacer()
                }
            } else if isTranscribing {
                HStack(spacing: 15) {
                    ProgressView()
                    Text("Transcribing")
                        .font(.caption2)
                    Spacer()
                }
            }
            else {
                Text("Tip: you can switch between voice and keyboard anytime")
                    .font(.caption2)
            }
        }
        .onChange(of: viewModel.recordingStopped) {
            if viewModel.recordingStopped { // When recording stops, start transcribing if not already doing so
                startTranscriptionIfNeeded()
            }
        }
        .task {
            await loadModelAndPrepareForTranscription()
        }
    }

    private func startTranscriptionIfNeeded() {
        guard !isTranscribing else { return }
        isTranscribing = true
        Task {
            await transcribeAudio()
        }
    }

    private func loadModelAndPrepareForTranscription() async {
        do {
            pipe = try await WhisperKit(model: "tiny")
            try await pipe?.prewarmModels()
            isLoadingModel = false
        } catch {
            print("Could not load model: \(error.localizedDescription)")
            isLoadingModel = false
        }
    }

    private func transcribeAudio() async {
        do {
            transcription = try await pipe!.transcribe(audioPath: viewModel.audioFilePath.path())!.text
            onTranscriptionCompleted(transcription)
        } catch {
            print(error.localizedDescription)
            onTranscriptionCompleted(error.localizedDescription)
        }
        isTranscribing = false
    }
}
