//
//  MusicPlayer.swift
//  Quizzler
//
//  Created by Kevin Hudson on 9/10/19.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import Foundation
import AVFoundation

class MusicPlayer {
    
    static let shared = MusicPlayer()
    var audioPlayer: AVAudioPlayer?
    var isPlaying = false
    func startBackgroundMusic() {
        if let bundle = Bundle.main.path(forResource: "quizMusic", ofType: "wav") {
            let backgroundMusic = NSURL(fileURLWithPath: bundle)
            do {
                audioPlayer = try AVAudioPlayer(contentsOf:backgroundMusic as URL)
                guard let audioPlayer = audioPlayer else { return }
                isPlaying = true
                audioPlayer.numberOfLoops = -1
                audioPlayer.prepareToPlay()
                audioPlayer.play()
                audioPlayer.volume = 0.1
            } catch {
                print(error)
            }
        }
    }
    
    func pausePlayMusic() {
        guard let audioPlayer = audioPlayer else { return }
        
        if isPlaying {
            audioPlayer.pause()
            isPlaying = false
        } else {
            audioPlayer.play()
            isPlaying = true
            
            
        }
    }
}
