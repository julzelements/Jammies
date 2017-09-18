//
//  SubtitleEventsTests.swift
//  TimeMockTests
//
//  Created by Julian Scharf on 17/9/17.
//  Copyright © 2017 Julian Scharf. All rights reserved.
//

import XCTest

class SubtitleEventsTests: XCTestCase {
    var ironManBlob: String!
    
    override func setUp() {
        super.setUp()
        ironManBlob = SubtitleIO.getRawStringFromFileInBundle(fileName: "IronMan", fileExtension: "srt")
    }

    func testForParsingOfSpiderman() {
        let spiderManBlob = SubtitleIO.getRawStringFromFileInBundle(fileName: "spiderman", fileExtension: "srt")
        let _ = SubtitleEvents(rawSRTString: spiderManBlob)
    }
    
    func testSubscriptTest() {
        print(ironManBlob)
        let _ = SubtitleEvents(rawSRTString: ironManBlob)
    }
    
}
