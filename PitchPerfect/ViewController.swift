//
//  ViewController.swift
//  PitchPerfect
//
//  Created by Jouella Fabe on 12/13/14.
//  Copyright (c) 2014 Jouella Fabe. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController,
    AVAudioRecorderDelegate, AVAudioPlayerDelegate
{
    var audioRecorder: AVAudioRecorder?
    var audioPlayer: AVAudioPlayer?
    var recorder = [
        AVFormatIDKey: kAudioFormatAppleLossless,
        AVEncoderAudioQualityKey : AVAudioQuality.Max.rawValue,
        AVEncoderBitRateKey : 320000,
        AVNumberOfChannelsKey: 2,
        AVSampleRateKey : 44100.0
    ]
    
    @IBOutlet weak var recordingInProgress: UILabel!;
    @IBOutlet weak var stopButton: UIButton!;
    @IBOutlet weak var recordingButton: UIButton!;
    
    
    func audioPlayerBeginInterruption(player: AVAudioPlayer!) {
        
    }
    
    func audioPlayerEndInterruption(player: AVAudioPlayer!,
        withOptions flags: Int) {
            if flags == AVAudioSessionInterruptionFlags_ShouldResume{
                player.play()
            }
    }
    
    
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer!,
        successfully flag: Bool){
            
            if flag{
                println("Audio player stopped correctly")
            } else {
                println("Audio player did not stop correctly")
            }
            
            audioPlayer = nil
            
    }
    
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!,
        successfully flag: Bool){
            
            if flag{
                
                println("Successfully stopped the audio recording process")
                
                /* Let's try to retrieve the data for the recorded file */
                var playbackError:NSError?
                var readingError:NSError?
                
                let fileData = NSData(contentsOfURL: audioRecordingPath(),
                    options: .MappedRead,
                    error: &readingError)
                
            } else {
                println("Stopping the audio recording failed")
            }
            
            /* Here we don't need the audio recorder anymore */
            self.audioRecorder = nil;
            
    }
    
    func audioRecordingPath() -> NSURL{
        
        let fileManager = NSFileManager()
        
        let documentsFolderUrl = fileManager.URLForDirectory(.DocumentDirectory,
            inDomain: .UserDomainMask,
            appropriateForURL: nil,
            create: false,
            error: nil)
        
        return documentsFolderUrl!.URLByAppendingPathComponent("Recording.m4a")
        
    }
    
    
    func audioRecordingSettings() -> NSDictionary{
        
        /* Let's prepare the audio recorder options in the dictionary.
        Later we will use this dictionary to instantiate an audio
        recorder of type AVAudioRecorder */
        
        return [
            AVFormatIDKey : kAudioFormatMPEG4AAC as NSNumber,
            AVSampleRateKey : 16000.0 as NSNumber,
            AVNumberOfChannelsKey : 1 as NSNumber,
            AVEncoderAudioQualityKey : AVAudioQuality.Low.rawValue as NSNumber
        ]
        
    }
    
    
    func startRecordingAudio(){
        
        var error: NSError?
        
        let audioRecordingURL = self.audioRecordingPath()
        
        audioRecorder = AVAudioRecorder(URL: audioRecordingURL,
            settings: audioRecordingSettings(),
            error: &error)
        
        if let recorder = audioRecorder{
            
            recorder.delegate = self
            /* Prepare the recorder and then start the recording */
            
            if recorder.prepareToRecord() && recorder.record(){
                
                
            } else {
                println("Failed to record.")
                audioRecorder = nil
            }
            
        } else {
            println("Failed to create an instance of the audio recorder")
        }
        
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    override func viewWillAppear(animated: Bool) {
        stopButton.hidden=true;
        recordingButton.enabled = true;
        println("el");
    }

   
    @IBAction func RecordAudio(sender: UIButton) {
        viewRecordUpdate()
        var error: NSError?
        let session = AVAudioSession.sharedInstance()
    
        if session.setCategory(AVAudioSessionCategoryPlayAndRecord,
            withOptions: .DuckOthers,
            error: &error){
                
                if session.setActive(true, error: nil){
                    println("Successfully activated the audio session")
                    
                    session.requestRecordPermission{[weak self](allowed: Bool) in
                        
                        if allowed{
                            self!.startRecordingAudio()
                        } else {
                            println("We don't have permission to record audio");
                        }
                        
                    }
                } else {
                    println("Could not activate the audio session")
                }
                
        } else {
            
            if let theError = error{
                println("An error occurred in setting the audio " +
                    "session category. Error = \(theError)")
            }
            
        }
    }

    
    

    @IBAction func stopAudio(sender: UIButton) {
        viewStopAudioUpdate()
        self.audioRecorder!.stop()
    }
    
    
    
    /** Helper functions to update the view based on the user's actions **/
    func viewRecordUpdate() {
        recordingInProgress.hidden = false;
        stopButton.hidden=false;
        recordingButton.enabled = false;
    }
    
    func viewStopAudioUpdate() {
        recordingInProgress.hidden = true;
        recordingButton.enabled = true;
        
    }
    
}

