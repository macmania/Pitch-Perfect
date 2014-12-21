//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by Jouella Fabe on 12/14/14.
//  Copyright (c) 2014 Jouella Fabe. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    var player = AVAudioPlayer()
    var receivedAudio:RecordedAudio! //this is the new class we made
    var audioEngine: AVAudioEngine!
    var audioFile:AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var playbackError:NSError?
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading:receivedAudio.filePathUrl, error:nil)
        player = AVAudioPlayer(contentsOfURL:receivedAudio.filePathUrl, error: nil)
        player.prepareToPlay()

        player.enableRate = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   
    @IBAction func PlaySoundSlow(sender: UIButton) {
        player.stop()
        player.rate = 0.75
        player.play()
    }
    
    @IBAction func playSoundFast(sender: UIButton) {
        player.stop();
        player.rate = 1.25;
        player.play();
    }
    
    @IBAction func playChipmunkAudio(sender: UIButton) {
        playAudioWithVariablePitch(1000);
        
    }
    
    func playAudioWithVariablePitch(pitch:Float){
        player.stop();
        audioEngine.stop()
        audioEngine.reset()
        
        var pitchPlayer = AVAudioPlayerNode()
        audioEngine.attachNode(pitchPlayer)
        
        var timePitch = AVAudioUnitTimePitch()
        timePitch.pitch = pitch
        audioEngine.attachNode(timePitch)
        
        audioEngine.connect(pitchPlayer, to:timePitch, format: nil)
        audioEngine.connect(timePitch, to: audioEngine.outputNode, format: nil)
        
        pitchPlayer.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        pitchPlayer.play()
    }
    
    @IBAction func stopSound(sender: UIButton) {
        player.stop();
    }
    
    @IBAction func playDarthvaderAudio(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    }
    

}
