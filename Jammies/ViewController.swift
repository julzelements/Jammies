//
//  ViewController.swift
//  Jammies
//
//  Created by Julian Scharf on 12/9/17.
//  Copyright © 2017 Julian Scharf. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var timer = Timer()
    var timeInterval = 0.01
    var microphoneRecordingTime = 5.0
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBOutlet weak var userFeedbackLabel: UILabel!
    
    enum DisplayState {
        case notRecording
        case recording
        case networkRequest
        case networkFinished
    }
    
    func updateDisplay(displayState: DisplayState) {
        switch displayState {
        case .notRecording:
            userFeedbackLabel.isHidden = true
        case .recording:
            userFeedbackLabel.isHidden = false
            userFeedbackLabel.text = "Recording \(Int(microphoneRecordingTime)) secs of audio..."
        case .networkRequest:
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            userFeedbackLabel.text = "Analysing audio..."
        case .networkFinished:
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            userFeedbackLabel.text = "Analysis complete"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateDisplay(displayState: .notRecording)
    }

    @IBAction func didStartListening(_ sender: Any) {
        progressBar.progress = 0
        timer = Timer.init(timeInterval: timeInterval, target: self, selector: #selector(updateProgressBar), userInfo: nil, repeats: true)
        RunLoop.current.add(timer, forMode: .defaultRunLoopMode)
        updateDisplay(displayState: .recording)
    }
    
    @objc func updateProgressBar() {
        if progressBar.progress >= 1.0 {
            timer.invalidate()
            updateDisplay(displayState: .networkRequest)
        } else {
            progressBar.progress = progressBar.progress + getProgressBarIncrement()
        }
    }
    
    func getProgressBarIncrement() -> Float {
        return Float(1 / (microphoneRecordingTime * (1 / timeInterval)))
    }
    

}

