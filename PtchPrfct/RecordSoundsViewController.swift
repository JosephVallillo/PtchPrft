//
//  RecordSoundsViewController.swift
//  PtchPrfct
//
//  Created by Joseph Vallillo on 11/26/15.
//  Copyright © 2015 Joseph Vallillo. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {
    
    //MARK: - Constants
    struct SegueIdentifier {
        static let StopRecordingIdentifier = "Stop Recording"
    }
    
    //MARK: - Properties
    var audioRecorder: AVAudioRecorder!
    var recordedAudio: RecordedAudio!
    
    //MARK: - Outlets
    @IBOutlet weak var recordingInProgress: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!

    //MARK: - Button Actions
    @IBAction func recordAudio(sender: UIButton) {
        //Display stop button and recording text
        recordingInProgress.text = "Recording..."
        stopButton.hidden = false
        //TODO: - Record users voice
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory,
            .UserDomainMask,
            true)[0] as String
        let recordingName = "my_audio.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        print(filePath)
        
        //Setup audio session
        let session = AVAudioSession.sharedInstance()
        do {
            try session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        } catch {
            print("could not get session")
            recordingInProgress.text = "Recording was not successful"
        }
        
        
        
        //Initialize and prepare the recorder
        do {
            try audioRecorder = AVAudioRecorder(URL: filePath!, settings: [:])
            audioRecorder.delegate = self
            audioRecorder.meteringEnabled = true
            audioRecorder.prepareToRecord()
            audioRecorder.record()
        } catch {
            print("could not create audio recorder")
            recordingInProgress.text = "Recording was not successful"
        }
        
        //disable the record button
        recordButton.enabled = false
        print("in recordAudio")
    }
    
    @IBAction func stopRecording(sender: UIButton) {
        recordingInProgress.hidden = true
        //TODO: Stop recording the user's voice
        if audioRecorder != nil {
            audioRecorder.stop()
        }
        let audioSession = AVAudioSession.sharedInstance()
        do { try audioSession.setActive(false) } catch { print("could not set audio session") }
    }
    
    //MARK: - Audio Recorder Delegate
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        if  (flag) {
            //Step 1 - save the recording
            recordedAudio = RecordedAudio(url: recorder.url, title: recorder.url.lastPathComponent!)
        
            //TODO: - Step 2 - segue
            self.performSegueWithIdentifier(SegueIdentifier.StopRecordingIdentifier, sender: recordedAudio)
        } else {
            print("Recording was not successful")
            recordingInProgress.text = "Recording was not successful"
            stopButton.hidden = true
            recordButton.enabled = true
        }
        
    }
    
    //MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == SegueIdentifier.StopRecordingIdentifier {
            if let psvc = segue.destinationViewController as? PlaySoundsViewController {
                if let data = sender as? RecordedAudio {
                    psvc.receivedAudio = data
                }
            }
        }
    }
    
    //MARK: - View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        recordingInProgress.hidden = false
        recordingInProgress.text = "Tap to Record"
        stopButton.hidden = true
        recordButton.enabled = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

