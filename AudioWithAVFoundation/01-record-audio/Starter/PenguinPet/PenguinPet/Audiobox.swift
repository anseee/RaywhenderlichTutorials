//
//  Audiobox.swift
//  PenguinPet
//
//  Created by 박성원 on 2021/12/29.
//

import Foundation
import AVFoundation

class Audiobox: NSObject, ObservableObject {
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
    }
    
    func stop() {
        audioRecorder?.stop()
    }
}

extension Audiobox: AVAudioRecorderDelegate {
    
}
