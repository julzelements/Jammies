//RecordedAudio.swift

import Foundation

class RecordedAudio {
  
  var filePathURL: NSURL!
  var title: String!
  
  init(audioFilePathURL: NSURL, audioTitle: String) {
    filePathURL = audioFilePathURL
    title = audioTitle
  }
  
}
