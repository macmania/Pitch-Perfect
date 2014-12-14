//
//  ViewController.swift
//  PitchPerfect
//
//  Created by Jouella Fabe on 12/13/14.
//  Copyright (c) 2014 Jouella Fabe. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var recordingInProgress: UILabel!;
    @IBOutlet weak var stopButton: UIButton!;
    @IBOutlet weak var recordingButton: UIButton!;
    
    
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
        recordingInProgress.hidden = false;
        stopButton.hidden=false;
        recordingButton.enabled = false;
        println("hello");
    
    }
    

    @IBAction func stopAudio(sender: UIButton) {
        recordingInProgress.hidden = true;
        recordingButton.enabled = true;
    }
}

