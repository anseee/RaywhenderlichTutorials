//
//  Audiobox.swift
//  PenguinPet
//
//  Created by 박성원 on 2021/12/29.
//

import Foundation
import AVFoundation

class AudioBox: NSObject, ObservableObject {
    
    @Published var status: AudioStatus = .stopped
    
    var audioRecorder: AVAudioRecorder?
    var audioPlayer: AVAudioPlayer?
    
    var urlForMemo: URL {
        let fileManager = FileManager.default
        let tempDir = fileManager.temporaryDirectory
        let filePath = "TempoMemo.caf"
        return tempDir.appendingPathComponent(filePath)
    }
    
    func setupRecorder() {
        let recordSettings: [String: Any] = [
            AVFormatIDKey: Int(kAudioFormatLinearPCM),
            AVSampleRateKey: 44100.0,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        do {
            audioRecorder = try AVAudioRecorder(url: urlForMemo, settings: recordSettings)
            audioRecorder?.delegate = self
        }
        catch {
            print("error creating audio recorder")
        }
    }
    
    func record() {
        audioRecorder?.record()
        status = .recording
    }
    
    func stop() {
        audioRecorder?.stop()
        status = .stopped
    }
}

extension AudioBox: AVAudioRecorderDelegate {
    func audioRecorderEncodeErrorDidOccur(_ recorder: AVAudioRecorder, error: Error?) {
        status = .stopped
    }
}
