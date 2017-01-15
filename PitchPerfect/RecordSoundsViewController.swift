//
//  ViewController.swift
//  PitchPerfect
//
//  Created by Etjen Ymeraj on 9/17/16.
//  Copyright © 2016 Etjen Ymeraj. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {

    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    var audioRecorder:AVAudioRecorder!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func recordAudio(_ sender: AnyObject) {
        recordingLabel.text = "Recording in Progress"
        recordButton.isEnabled = false
        stopButton.isEnabled = true
        
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String //directory
        let recordingName = "recordedVoice.wav" //assign name to recording
        let pathArray = [dirPath, recordingName]//put the above two elements in an array
        let filePath = URL(string: pathArray.joined(separator: "/"))//extract elements to build path
        //fileURL(withPathComponents: pathArray)//extract elements to build path
        print(filePath)
        
        let session = AVAudioSession.sharedInstance() //singleton instead of typical class only one instance per process
                                                      //in this case this session manages the audio session of our app
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord) //sets audio category to record input
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:]) //url is the file system location to record to
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
    }

    @IBAction func stopRecording(_ sender: AnyObject) {
        recordingLabel.text = "Tap to record"
        recordButton.isEnabled = true
        stopButton.isEnabled = false
        
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        stopButton.isEnabled = false
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if (flag){
            self.performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)} //execute the segue
        else{
            print("Recording failed")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "stopRecording") {
            let playSoundsVC = segue.destination as! PlaySoundsViewController //initialize an instance of VC
            let recordedAudioURL = sender as! URL //create a variable to store the audio url
            playSoundsVC.recordedAudioURL = recordedAudioURL //pass the data to the other vc
        }
    }
}

