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
//    var recorder = [
//        AVFormatIDKey: kAudioFormatAppleLossless,
//        AVEncoderAudioQualityKey : AVAudioQuality.Max.rawValue,
//        AVEncoderBitRateKey : 320000,
//        AVNumberOfChannelsKey: 2,
//        AVSampleRateKey : 44100.0
//    ]
    
    var recordedAudio:RecordedAudio!
    
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
            
            //this means that the recorded was successful
            if flag{
                recordedAudio = RecordedAudio()
                recordedAudio.filePathUrl = recorder.url
                recordedAudio.title = recorder.url.lastPathComponent
                
                //stopRecording is the id
                
                self.performSegueWithIdentifier("stopRecord", sender: recordedAudio);
                println("Successfully stopped the audio recording process")
                
                /* Let's try to retrieve the data for the recorded file */
                var playbackError:NSError?
                var readingError:NSError?
                
            } else {
                println("Stopping the audio recording failed")
                recordingButton.enabled = true;
                stopButton.hidden = true;
            }
            
            
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "stopRecord"){
            let playSoundsVC:PlaySoundsViewController = segue.destinationViewController as PlaySoundsViewController
            let data = sender as RecordedAudio
            playSoundsVC.receivedAudio = data
        }
        else{
            println("segue unsuccessful")
        }

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
        var recordedAudio:AVAudioRecorder!
        
        //directory path
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        
        let currentDateTime = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "ddMMyyyy-HHmmss"
        let recordingName = formatter.stringFromDate(currentDateTime)
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        println("file path", filePath)
        
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error:nil)
        
        audioRecorder = AVAudioRecorder(URL:filePath, settings: nil, error: nil)
        audioRecorder?.delegate = self
        audioRecorder?.meteringEnabled = true
        audioRecorder?.prepareToRecord()
        audioRecorder?.record()
        
        

        
        
        
        
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

