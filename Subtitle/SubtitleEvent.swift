//
//  SubtitleEvent.swift
//  TimeMock
//
//  Created by Julian Scharf on 26/7/17.
//  Copyright © 2017 Julian Scharf. All rights reserved.
//

import Foundation


struct SubtitleEvent: Hashable, Equatable {
    var time: Double
    var text: String
    var hashValue: Int {
        get {
            return "\(self.time),\(self.text)".hashValue
        }
    }
    
    init(time: Double, text: String) {
        self.time = time
        self.text = text
    }
    
    static func ==(lhs: SubtitleEvent, rhs: SubtitleEvent) -> Bool {
        return lhs.time == rhs.time &&
            rhs.text == lhs.text
    }

}
