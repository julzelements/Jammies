//
//  ViewController.swift
//  Jammies
//
//  Created by Julian Scharf on 12/9/17.
//  Copyright © 2017 Julian Scharf. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioRecorderDelegate {

    var timer = Timer()
    var timeInterval = 0.01
    var microphoneRecordingTime = 5.0
    
    var audioRecorder: AVAudioRecorder!
    var recordedAudio: RecordedAudio!
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var userFeedbackLabel: UILabel!
    @IBOutlet weak var listenButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    enum DisplayState {
        case notListening
        case listening
        case networkRequest
        case networkFinished
    }
    
    func updateDisplay(displayState: DisplayState) {
        switch displayState {
        case .notListening:
            activityIndicatorStopped()
            progressBar.isHidden = true
            userFeedbackLabel.isHidden = true
        case .listening:
            listenButton.isHidden = true
            progressBar.isHidden = false
            userFeedbackLabel.isHidden = false
            userFeedbackLabel.text = "Recording \(Int(microphoneRecordingTime)) secs of audio..."
        case .networkRequest:
            progressBar.isHidden = true
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            activityIndicatorStarted()
            userFeedbackLabel.text = "Analysing audio..."
        case .networkFinished:
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            activityIndicatorStopped()
            userFeedbackLabel.text = "Analysis complete"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateDisplay(displayState: .notListening)
    }
    
    func startProgressBar() {
        progressBar.progress = 0
        timer = Timer.init(timeInterval: timeInterval, target: self, selector: #selector(updateProgressBar), userInfo: nil, repeats: true)
        RunLoop.current.add(timer, forMode: .defaultRunLoopMode)
    }

    @IBAction func didStartListening(_ sender: Any) {
        startProgressBar()
        updateDisplay(displayState: .listening)
    }
    
    @objc func updateProgressBar() {
        if progressBar.progress >= 1.0 {
            timer.invalidate()
            updateDisplay(displayState: .networkRequest)
        } else {
            let newProgress = progressBar.progress + getProgressBarIncrement()
            progressBar.setProgress(newProgress, animated: true)
        }
    }
    
    func recordAudio() {
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let recordingName = "my_audio.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURL(withPathComponents: pathArray)
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if(flag) {
            recordedAudio = RecordedAudio(audioFilePathURL: recorder.url as NSURL, audioTitle: recorder.url.lastPathComponent)
        } else {
            print("recording was not successful")
        }
    }
    
    func stopRecording() {
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    func getProgressBarIncrement() -> Float {
        return Float(1 / (microphoneRecordingTime * (1 / timeInterval)))
    }
    
    func activityIndicatorStarted() {
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
    }
    
    func activityIndicatorStopped() {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }
    

}

