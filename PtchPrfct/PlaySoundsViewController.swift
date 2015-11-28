//
//  PlaySoundsViewController.swift
//  PtchPrfct
//
//  Created by Joseph Vallillo on 11/28/15.
//  Copyright © 2015 Joseph Vallillo. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    //MARK: - Constants
    private struct SoundEffects {
        struct Speed {
            static let Slow: Float = 0.5
            static let Fast: Float = 1.5
        }
        struct Pitch {
            static let High: Float = 1000.0
            static let Low: Float = -1000.0
        }
    }
    
    //MARK: - Properties
    var avPlayer: AVAudioPlayer!
    var receivedAudio: RecordedAudio!
    var audioEngine: AVAudioEngine!
    var audioFile: AVAudioFile!
    
    //MARK: - Audio Editing
    func playSoundWithSpeed(speed: Float){
        avPlayer.stop()
        avPlayer.rate = speed
        avPlayer.currentTime = 0.0
        avPlayer.play()
    }
    
    func playSoundWithPitch(pitch: Float) {
        avPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        let avPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(avPlayerNode)
        
        let changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(avPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        avPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        
        do{
            try audioEngine.start()
        } catch {
            print("Could not start audio engine")
        }
        
        avPlayerNode.play()
    }
    
    //MARK: - Button Actions
    @IBAction func playSlowSound(sender: UIButton) {
        playSoundWithSpeed(SoundEffects.Speed.Slow)
    }
    @IBAction func plauFastSound(sender: UIButton) {
        playSoundWithSpeed(SoundEffects.Speed.Fast)
    }
    @IBAction func playHighPitchSound(sender: UIButton) {
        playSoundWithPitch(SoundEffects.Pitch.High)
    }
    @IBAction func playLowPitchSound(sender: UIButton) {
        playSoundWithPitch(SoundEffects.Pitch.Low)
    }
    
    @IBAction func stopAudio(sender: UIButton) {
        avPlayer.stop()
    }
    
    //MARK: - View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        //The commented out code is to point to a hard coded audio file for testing
//        if let filePath = NSBundle.mainBundle().pathForResource("movie_quote", ofType: ".mp3") {
//            let filePathURL = NSURL.fileURLWithPath(filePath)
//            do {
//                avPlayer = try AVAudioPlayer(contentsOfURL: filePathURL, fileTypeHint: nil)
//                avPlayer.enableRate = true
//            } catch _{
//                return print("file not found")
//            }
//        } else {
//            print("The filePath is empty")
//        }
        if receivedAudio != nil {
            do {
                avPlayer = try AVAudioPlayer(contentsOfURL: receivedAudio.filePathURL, fileTypeHint: nil)
                avPlayer.enableRate = true
            } catch {
                print("The filePath is empty")
            }
            if avPlayer != nil {
                audioEngine = AVAudioEngine()
                audioFile = try! AVAudioFile(forReading: receivedAudio.filePathURL)
            }
        }
    }

}
