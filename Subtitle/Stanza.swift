//
//  Stanza.swift
//  TimeMock
//
//  Created by Julian Scharf on 10/7/17.
//  Copyright © 2017 Julian Scharf. All rights reserved.
//

import Foundation

class Stanza {
    
    var index: Int!
    var startTime: Double!
    var endTime: Double!
    var lines: [String]!
    var splitBlob: [String]!
    var hashValue: Int {
        get {
            return "\(self.index),\(self.startTime),\(self.endTime),\(self.lines)".hashValue
        }
    }
    
    init(stanzaBlob: String) {
        splitBlob = splitBlobIntoLines(stanzaBlob: stanzaBlob)
        index = scanForIndex(stanzaBlob: splitBlob[0])
        let Times = scanForTimes(stanzaBlob: splitBlob[1])
        startTime = Times.startTime
        endTime = Times.endTime
        lines = scanForLines(splitBlob: splitBlob)
    }
    
    static func ==(lhs: Stanza, rhs: Stanza) -> Bool {
        return lhs.index == rhs.index &&
        lhs.startTime == rhs.startTime &&
        lhs.endTime == rhs.endTime &&
        lhs.lines == rhs.lines
    }
    
    private func splitBlobIntoLines(stanzaBlob: String) -> [String] {
        let santitizedLineBreaks = stanzaBlob.replacingOccurrences(of: "\r", with: "\n")
        let split = santitizedLineBreaks.components(separatedBy: "\n")
        let noBlankLines = removeBlankLines(lines: split)
        return noBlankLines
    }
    
    private func scanForIndex(stanzaBlob: String) -> Int {
    let regex = try! NSRegularExpression(pattern: "^[0-9]+", options: .caseInsensitive)
    let match = regex.matches(in: stanzaBlob,
                              options: NSRegularExpression.MatchingOptions(rawValue: 0),
                              range: NSMakeRange(0, stanzaBlob.characters.count))
        
    let i = match.first
    let indexString = (stanzaBlob as NSString).substring(with: (i?.range)!)
        if let indexInt = Int(indexString) {
            return indexInt
        } else {
            print("index of stanza not found\n\(stanzaBlob)")
            return 0
        }
    }
    
    private func scanForTimes(stanzaBlob: String) -> (startTime: Double, endTime: Double) {
        let timeChunks = splitTimeChunks(stanzaBlob: stanzaBlob)!
        let startChunk = timeChunks.startChunk
        let endChunk = timeChunks.endChunk
        let start = SRTTime(srtTime: startChunk).seconds_Double
        let end = SRTTime(srtTime: endChunk).seconds_Double
        return (start, end)
    }
    
    func splitTimeChunks(stanzaBlob: String) -> (startChunk: String, endChunk: String)? {
        let split = stanzaBlob.components(separatedBy: " --> ")
        if split.count == 2 {
            let startChunk = split[0]
            let endChunk = split[1]
            return (startChunk, endChunk)
        }
        print("times error in: \(stanzaBlob)")
        return nil
    }

    func scanForLines(splitBlob: [String]) -> [String] {
        var noBlankLines = removeBlankLines(lines: splitBlob)
        var lines = [String]()
        for index in 2..<noBlankLines.count {
            lines.append(noBlankLines[index])
        }
        return lines
    }
    
    func removeBlankLines(lines: [String]) -> [String] {
        var noBlankLines = [String]()
        for line in lines {
            if line != "" {
                noBlankLines.append(line)
            }
        }
        return noBlankLines
    }

}
