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
        struct Rate {
            static let Default: Float = 0.0
        }
        struct Pitch {
            static let Default: Float = 0.0
        }
        struct Distortion {
            static let Default: Float = 0.0
        }
        struct Echo {
            static let Default: Float = 0.0
        }
    }
    
    private struct SegueIdentifiers {
        static let SettingsIdentifier = "Set Settings"
    }
    
    //MARK: - Settings Model
    private let settings = Settings()
    
    var slowRate: Float {
        return settings.slowRate
    }
    
    var highRate: Float {
        return settings.highRate
    }
    
    var highPitch: Float {
        return settings.highPitch
    }
    
    var lowPitch: Float {
        return settings.lowPitch
    }
    
    var distort: Float {
        return settings.distort
    }
    
    var echo: Float {
        return settings.echo
    }
    
    //MARK: - Properties
    var avPlayer: AVAudioPlayer!
    var receivedAudio:RecordedAudio!
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    var avPlayerNode:AVAudioPlayerNode!
    var echoEffect:AVAudioUnitDelay!
    var timePitchEffect:AVAudioUnitTimePitch!
    var distortionEffect:AVAudioUnitDistortion!
    var speedEffect:AVAudioUnitVarispeed!

    
    //MARK: - Audio Editing
    func playAudio(pitch pitch: Float, rate: Float, echo: Float, distortion: Float) {
        
        //stop audio, reset Engine
        stopAndResetAudio()
        
        //set defaults
        echoEffect.delayTime = NSTimeInterval(0)
        echoEffect.feedback = 0
        distortionEffect.wetDryMix = 0
        timePitchEffect.pitch = 1
        speedEffect.rate = 1
        
        //set audio parameters
        timePitchEffect.pitch = pitch
        
        if (rate != 0) { speedEffect.rate = rate }
        
        if (echoEffect != 0) {
            echoEffect.delayTime = NSTimeInterval(echo)
            echoEffect.feedback = 25
        } else {
            echoEffect.delayTime = 0
        }
        
        distortionEffect.wetDryMix = distortion
        
        //connect engine
        audioEngine.connect(avPlayerNode, to: speedEffect, format: nil)
        audioEngine.connect(speedEffect, to: timePitchEffect, format: nil)
        audioEngine.connect(timePitchEffect, to: distortionEffect, format: nil)
        audioEngine.connect(distortionEffect, to: echoEffect, format: nil)
        audioEngine.connect(echoEffect, to: audioEngine.outputNode, format: nil)
        avPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        
        do {
            try audioEngine.start()
            avPlayerNode.play()
        } catch _ {
            print("Exception occurred in setupEngine")
        }
    }
    
    func stopAndResetAudio() {
        audioEngine.stop()
        audioEngine.reset()
        avPlayerNode.stop()
    }
    
    //MARK: - Button Actions
    @IBAction func playSlowSound(sender: UIButton) {
        playAudio(pitch: SoundEffects.Pitch.Default, rate: slowRate, echo: SoundEffects.Echo.Default, distortion: SoundEffects.Distortion.Default)
    }
    @IBAction func plauFastSound(sender: UIButton) {
        playAudio(pitch: SoundEffects.Pitch.Default, rate: highRate, echo: SoundEffects.Echo.Default, distortion: SoundEffects.Distortion.Default)
    }
    @IBAction func playHighPitchSound(sender: UIButton) {
        playAudio(pitch: highPitch, rate: SoundEffects.Rate.Default, echo: SoundEffects.Echo.Default, distortion: SoundEffects.Distortion.Default)
    }
    @IBAction func playLowPitchSound(sender: UIButton) {
        playAudio(pitch: lowPitch, rate: SoundEffects.Rate.Default, echo: SoundEffects.Echo.Default, distortion: SoundEffects.Distortion.Default)
    }
    @IBAction func playReverbSound(sender: UIButton) {
        playAudio(pitch: SoundEffects.Pitch.Default, rate: SoundEffects.Rate.Default, echo: SoundEffects.Echo.Default, distortion: distort)
    }
    @IBAction func playEchoSound(sender: UIButton) {
        playAudio(pitch: SoundEffects.Pitch.Default, rate: SoundEffects.Rate.Default, echo: echo, distortion: SoundEffects.Distortion.Default)
    }
    @IBAction func stopAudio(sender: UIButton) {
        stopAndResetAudio()
    }
    @IBAction func changeSettings(sender: UIButton) {
        performSegueWithIdentifier(SegueIdentifiers.SettingsIdentifier, sender: nil)
    }
    
    //MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == SegueIdentifiers.SettingsIdentifier {
            if let stvc = segue.destinationViewController as? SettingsTableViewController {
                stopAndResetAudio()
            }
        }
    }
    
    //MARK: - View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        if receivedAudio != nil {
            
            //setup audio file
            audioFile = try? AVAudioFile(forReading: receivedAudio.filePathURL)
            audioEngine = AVAudioEngine()
            
            avPlayerNode = AVAudioPlayerNode()
            echoEffect = AVAudioUnitDelay()
            timePitchEffect = AVAudioUnitTimePitch()
            distortionEffect = AVAudioUnitDistortion()
            speedEffect = AVAudioUnitVarispeed()
            
            //attach effects
            audioEngine.attachNode(avPlayerNode)
            audioEngine.attachNode(echoEffect)
            audioEngine.attachNode(timePitchEffect)
            audioEngine.attachNode(distortionEffect)
            audioEngine.attachNode(speedEffect)
            
        }
    }

}
