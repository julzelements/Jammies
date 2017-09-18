//
//  SubtitleEvents.swift
//  TimeMock
//
//  Created by Julian Scharf on 17/9/17.
//  Copyright © 2017 Julian Scharf. All rights reserved.
//

import Foundation

class SubtitleEvents {
    var events: [SubtitleEvent]
    var count: Int {
        get {
            return events.count
        }
    }
    
    init(rawSRTString: String) {
        self.events = SubtitleEvents.getEvents(rawSRTString: rawSRTString)
    }
    
    private static func getEvents(rawSRTString: String) -> [SubtitleEvent] {
        let sanitizedSRT = sanitizeLineBreaks(rawSRTString: rawSRTString)
        let stanzaBlobs = sanitizedSRT.components(separatedBy: "\n\n")
        var events = [SubtitleEvent]()
        for stanzaBlob in stanzaBlobs {
            let stanza = Stanza(stanzaBlob: stanzaBlob)
            let lines = stanza.lines.joined(separator: "\n")
            let startTime = stanza.startTime
            let endTime = stanza.endTime
            events.append(SubtitleEvent(time: startTime!, text: lines))
            events.append(SubtitleEvent(time: endTime!, text: ""))
        }
        return events
    }
    
    private static func sanitizeLineBreaks(rawSRTString: String) -> String {
        return rawSRTString.replacingOccurrences(of: "\r\n", with: "\n")
    }
    
    subscript(index: Int) -> SubtitleEvent {
        get {
            return events[index]
        }
        set(newValue) {
            events[index] = newValue
        }
    }
    
    func contains(_ event: SubtitleEvent) -> Bool {
        return events.contains(event)
    }
}
