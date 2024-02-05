import SwiftUI

struct RecordView: View {
    @EnvironmentObject var viewModel: RecordingViewModel
    @State private var hasRecordedOnce = false
    
    private var buttonText: String {
        if viewModel.recording {
            return "Pause and transcribe"
        }
        else if hasRecordedOnce {
            return "Continue recording"
        }
        else {
            return "Start recording"
        }
    }
    
    var body: some View {
            HStack {
                Button(buttonText) {
                    if viewModel.recording {
                        viewModel.stopRecording()
                    } else {
                        viewModel.startRecording()
                        hasRecordedOnce = true
                    }
                }
                .buttonStyle(.borderedProminent)
                .tint(viewModel.recording ? .red : .purple)
                Spacer()
                ZStack(alignment: .center) {
                    Circle()
                        .aspectRatio(1, contentMode: .fit)
                        .frame(width: CGFloat(viewModel.audioLevel)*30 + 0)
                        .animation(.spring.delay(0.2), value: viewModel.audioLevel)
                        .foregroundStyle(.purple)
                        .opacity(0.5)
                    Circle()
                        .aspectRatio(1, contentMode: .fit)
                        .frame(width: CGFloat(viewModel.audioLevel)*15 + 0)
                        .animation(.spring, value: viewModel.audioLevel)
                        .foregroundStyle(.purple)
                        .opacity(0.5)
                }
                .frame(width: 50, height: 50)
            }
            .onAppear {
                viewModel.setupRecorder()
        }
    }
}


#Preview {
    let viewModel = RecordingViewModel(uuid: UUID())
    return (
        Group {
            RecordView()
        }.environmentObject(viewModel))
}
