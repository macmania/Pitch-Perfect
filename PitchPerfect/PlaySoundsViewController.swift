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
    var player = AVAudioPlayer();
    var filePath = NSBundle.mainBundle().pathForResource("movie_quote", ofType:"mp3")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var fileUrl = NSURL(fileURLWithPath:filePath!);
        player = AVAudioPlayer(contentsOfURL: fileUrl, error: nil)
        player.prepareToPlay()
        player.enableRate = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
   
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
