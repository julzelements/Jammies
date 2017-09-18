//
//  EventMaker.swift
//  TimeMock
//
//  Created by Julian Scharf on 10/7/17.
//  Copyright © 2017 Julian Scharf. All rights reserved.
//

import UIKit

enum EventMaker {
    static func getEvents(rawSRTString: String) -> [SubtitleEvent] {
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
        return rawSRTString.replacingOccurrences(of: "\r", with: "\n")
    }
        
}
