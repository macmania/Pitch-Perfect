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

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var playbackError:NSError?

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
    
    
    @IBAction func stopSound(sender: UIButton) {
        player.stop();
    }
    
    

}
