import Foundation
import AVFoundation

class RecordingViewModel: ObservableObject {
    @Published var audioRecorder: AVAudioRecorder?
    @Published var recording = false
    @Published var audioLevel: Float = 0.0

    private var recordingSession: AVAudioSession = AVAudioSession.sharedInstance()
    private var updateTimer: Timer?

    func getAudioFilename(uuid: UUID) -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory.appendingPathComponent("\(uuid).m4a")
    }
    
    func setupRecorder(uuid: UUID) {
        let audioFilename = getAudioFilename(uuid: uuid)
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]

        do {
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
            audioRecorder?.isMeteringEnabled = true
        } catch {
            print("Failed to set up the audio recorder: \(error)")
        }
    }
    
    func startRecording(uuid: UUID) {
        do {
            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)
            setupRecorder(uuid: uuid) // Ensure the recorder is set up with the correct file
            audioRecorder?.record()
            recording = true
            audioRecorder?.isMeteringEnabled = true
            startMetering()
        } catch {
            print("Failed to start recording: \(error)")
        }
    }
    
    func stopRecording() {
        audioRecorder?.stop()
        recording = false
        stopMetering()
        try? recordingSession.setActive(false)
    }
    
    private func startMetering() {
        updateTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
            guard let strongSelf = self else { return }
            strongSelf.audioRecorder?.updateMeters()
            if let power = strongSelf.audioRecorder?.averagePower(forChannel: 0) {
                strongSelf.audioLevel = strongSelf.convertPowerToLevel(power)
            }
        }
    }
    
    private func stopMetering() {
        updateTimer?.invalidate()
        updateTimer = nil
    }
    
    private func convertPowerToLevel(_ power: Float) -> Float {
        let minDb: Float = -60 // Adjust based on your testing
        if power < minDb {
            return 0.0
        } else if power >= 1.0 {
            return 1.0
        } else {
            let normalizedValue = (power + abs(minDb)) / abs(minDb)
            return normalizedValue
        }
    }
}
