//
//  StanzaTests.swift
//  TimeMock
//
//  Created by Julian Scharf on 11/7/17.
//  Copyright © 2017 Julian Scharf. All rights reserved.
//

import XCTest

class StanzaTests: XCTestCase {
    var stanza: Stanza!
    var stanzaBlob28: String!
    
    override func setUp() {
        super.setUp()
        stanzaBlob28 = "28\n00:01:46,120 --> 00:01:49,320\n- But you are a kid.\n- This is my chance to prove myself.\n\n"
        stanza = Stanza(stanzaBlob: stanzaBlob28)
    }
    
    func testStanzaShouldHaveIndexOf28() {
        let expectedIndex: Int = 28
        XCTAssertEqual(expectedIndex, stanza.index)
    }
    
    func testStanzaShouldHaveStartTime() {
        stanza = Stanza(stanzaBlob: stanzaBlob28)
        let expectedStartTime = 60.0 + 46.0 + 0.120 //"00:01:46,120"
        XCTAssertEqual(expectedStartTime, stanza.startTime)
    }
    
    func testStanzaShouldHaveEndTime() {
        let expectedEndTime = 60.0 + 49.0 + 0.320 //"00:01:49,320"
        XCTAssertEqual(expectedEndTime, stanza.endTime)
    }
    
    func testStanzaShouldHaveLines() {
        let expectedLines = ["- But you are a kid.","- This is my chance to prove myself."]
        XCTAssertEqual(expectedLines, stanza.lines)
    }
    
    func testIronManSubtitlesShouldParseCorrectly() {
        let ironManBlob = SubtitleIO.getRawStringFromFileInBundle(fileName: "IronMan", fileExtension: "srt")
        let _ = SubtitleEvents(rawSRTString: ironManBlob)
    }
    
    func testIronManEvent63ShouldBePresent() {
        let ironManBlob = SubtitleIO.getRawStringFromFileInBundle(fileName: "IronMan", fileExtension: "srt")
        let events = SubtitleEvents(rawSRTString: ironManBlob)
        let event63 = events[63]
        print(event63)
    }
    
}
