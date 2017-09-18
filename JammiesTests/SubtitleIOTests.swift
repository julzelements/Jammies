//
//  SubtitleIOTests.swift
//  TimeMock
//
//  Created by Julian Scharf on 13/7/17.
//  Copyright © 2017 Julian Scharf. All rights reserved.
//

import XCTest

class SubtitleIOTests: XCTestCase {
       
    func testShouldGetBadURLErrorMessageWhenTryingToGetNonExistentFileFromBundle() {
        let expectedError = "could not obtain URL"
        let request = SubtitleIO.getRawStringFromFileInBundle(fileName: "foo", fileExtension: "bar")
        XCTAssertEqual(expectedError, request)
    }

    func testShouldGetBadURLErrorMessageWhenTryingToReadAMOVFileAsAString() {
        let expectedError = "could not read contents of URL as a string"
        let request = SubtitleIO.getRawStringFromFileInBundle(fileName: "spiderman", fileExtension: "mov")
        XCTAssertEqual(expectedError, request)
    }
}
