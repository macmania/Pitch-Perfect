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
    
    
    //Path of the recording file
    func audioRecordingPath() -> NSURL{
        
        let fileManager = NSFileManager()
        
        let documentsFolderUrl = fileManager.URLForDirectory(.DocumentDirectory,
            inDomain: .UserDomainMask,
            appropriateForURL: nil,
            create: false,
            error: nil)
        
        return documentsFolderUrl!.URLByAppendingPathComponent("Recording.m4a")
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var playbackError:NSError?

        var fileUrl = NSURL(fileURLWithPath:filePath!);
        let fileData = NSData(contentsOfURL: audioRecordingPath(),
            options: .MappedRead,
            error: nil)
        player = AVAudioPlayer(data: fileData, error:&playbackError )
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
