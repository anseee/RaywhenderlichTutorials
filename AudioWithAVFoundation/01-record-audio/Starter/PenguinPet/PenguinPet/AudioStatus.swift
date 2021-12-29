//
//  Audiostatus.swift
//  PenguinPet
//
//  Created by 박성원 on 2021/12/29.
//

import Foundation

enum AudioStatus: Int, CustomStringConvertible {
    case stopped, playing, recording
    
    var audioName: String {
        let audioNames = ["Audio:Stopped", "Audio:Playing", "Audio:Recording"]
        return audioNames[rawValue]
    }
    
    var description: String {
        return audioName
    }
}
