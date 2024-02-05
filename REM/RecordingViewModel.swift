import Foundation
import AVFoundation

class RecordingViewModel: ObservableObject {
    var uuid: UUID
    var audioFilePath: URL
    
    @Published var audioRecorder: AVAudioRecorder?
    @Published var recording = false
    @Published var audioLevel: Float = 0.0
    @Published var recordingStopped = false // Notify when recording stops

    private var recordingSession: AVAudioSession = AVAudioSession.sharedInstance()
    private var updateTimer: Timer?
    
    
    init(uuid: UUID) {
        self.uuid = uuid
        self.audioFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("\(self.uuid).m4a")
    }
    
    func setupRecorder() {
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        do {
            audioRecorder = try AVAudioRecorder(url: self.audioFilePath, settings: settings)
            audioRecorder?.isMeteringEnabled = true
        } catch {
            print("Failed to set up the audio recorder: \(error)")
        }
    }
    
    func startRecording() {
        do {
            recordingStopped = false // Reset the flag when recording starts
            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)
            setupRecorder()
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
        recordingStopped = true // Set this flag when recording stops
    }
    
    private func startMetering() {
        updateTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
            self?.audioRecorder?.updateMeters()
            if let power = self?.audioRecorder?.averagePower(forChannel: 0) {
                self?.audioLevel = self?.convertPowerToLevel(power) ?? 0.0
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
            return (power + abs(minDb)) / abs(minDb)
        }
    }
}
