//
//  Audiobox.swift
//  PenguinPet
//
//  Created by 박성원 on 2021/12/29.
//

import Foundation
import AVFoundation
import SwiftUI

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
    
    override init() {
        super.init()
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(handleRouteChange), name: AVAudioSession.routeChangeNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(handleRouteChange), name: AVAudioSession.routeChangeNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc
    func handleRouteChange(_ notification: Notification) {
        guard let info = notification.userInfo,
              let rawValue = info[AVAudioSessionRouteChangeReasonKey] as? UInt else {
                  return
              }
        let reason = AVAudioSession.RouteChangeReason(rawValue: rawValue)
        
        if reason == .oldDeviceUnavailable {
            guard let previousRoute = info[AVAudioSessionRouteChangePreviousRouteKey] as? AVAudioSessionRouteDescription,
                  let previousOutput = previousRoute.outputs.first else {
                      return
                  }
            
            if previousOutput.portType == .headphones {
                if status == .playing {
                    stopPlayback()
                }
                else if status == .recording {
                    stopRecording()
                }
            }
        }
    }

    func stopRecording() {
        
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
    
    func play() {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: urlForMemo)
            audioPlayer?.delegate = self
        }
        catch {
            print("error play audio")
        }
        
        if let duration = audioPlayer?.duration, duration > 0 {
            audioPlayer?.play()
            status = .playing
        }
    }
    
    func stopPlayback() {
        audioPlayer?.stop()
        status = .stopped
    }
}

extension AudioBox: AVAudioRecorderDelegate {
    func audioRecorderEncodeErrorDidOccur(_ recorder: AVAudioRecorder, error: Error?) {
        status = .stopped
    }
}

extension AudioBox: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        status = .stopped
    }
}
