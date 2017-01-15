//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by Etjen Ymeraj on 9/17/16.
//  Copyright © 2016 Etjen Ymeraj. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {

    @IBOutlet weak var snailButton: UIButton!
    @IBOutlet weak var rabbitButton: UIButton!
    @IBOutlet weak var chipmunkButton: UIButton!
    @IBOutlet weak var darthvaderButton: UIButton!
    @IBOutlet weak var parrotButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    var recordedAudioURL: URL!
    var audioFile: AVAudioFile!
    var audioEngine: AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    enum ButtonType: Int {case slow = 0, fast, chipmunk, vader, echo, parrot}

    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func playSound(_ sender: UIButton) {
        switch(ButtonType(rawValue: sender.tag)!){
            case .slow: playSound(rate: 0.5)
            case .fast: playSound(rate: 1.5)
            case .chipmunk: playSound(pitch: 1000)
            case .vader: playSound(pitch: -1000)
            case .echo: playSound(echo: false)
            case .parrot: playSound(echo: true)
        }
        configureUI(.playing)
    }

    @IBAction func stopButton(_ sender: AnyObject) {
        print("stop")
        stopAudio() 
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureUI(.notPlaying)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
