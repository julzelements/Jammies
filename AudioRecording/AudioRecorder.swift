//  AudioRecorder.swift

import UIKit
import AVFoundation

class AudioRecorder: NSObject, AVAudioRecorderDelegate {

    var audioRecorder: AVAudioRecorder!
    var recordedAudio: RecordedAudio!
    
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
            print(recorder.url)
        } else {
            print("recording was not successful")
        }
    }
    
    func stopRecording() {
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
}
