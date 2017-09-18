//
//  SRTTimeTests.swift
//  TimeMockTests
//
//  Created by Julian Scharf on 17/9/17.
//  Copyright © 2017 Julian Scharf. All rights reserved.
//

import XCTest

class SRTTimeTests: XCTestCase {

    func testExample() {
        let time = "00:01:49,320"
        let expected = 109.320
        let calculated = SRTTime(srtTime: time).seconds_Double
        XCTAssertEqual(calculated, expected)
    }
        
}
