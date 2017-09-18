//
//  PlayerTests.swift
//  TimeMockTests
//
//  Created by Julian Scharf on 5/9/17.
//  Copyright © 2017 Julian Scharf. All rights reserved.
//

import XCTest

class PlayerTests: XCTestCase {
    var events: SubtitleEvents!
    var player: Player!
    var timeDouble: ITime!
    
    //The API is called when the system time is 1691.5 (apiMovieTime)
    //The API returns a value of 16.0, which means that at systemTime of 1691.5, the movie
    //was 16 seconds into playing.
    //
    //The time for this test is mocked out. The test is called when the system time is 1700
    //At 1700 the movie is 24.5 seconds into playing
    //
    //There should be silence at 24 til 25 seconds (event[23])
    //There shoudl be a subtitle at 25 til 26 seconds (event[24])
    //
    //The subtitles are indexed in the events array
    //
    //Currently, the system should display subtitle 23
    //
    //Another class needs to display subtitle 23
    //
    //In 0.5 seconds, the Player should be re-initialized with all the same values, only
    //this time, the time will be 1700.5 and thus the current subtitle will be 24.
    //
    //Another class needs to do this calling/recalling part.
    
    
    override func setUp() {
        super.setUp()
        let rawString = SubtitleIO.getRawStringFromFileInBundle(fileName: "test", fileExtension: "srt")
        events = SubtitleEvents(rawSRTString: rawString)
        timeDouble = TimeDouble(systemTime: 1700.0)
        player = Player(apiSystemTime: 1691.5 , apiMovieTime: 16.0, arrayOfEvents: events, time: timeDouble)
    }
    
    func test_givenThatSystemTimeIs1700MovieTimeSHouldbe24point5() {
        //The Api was called when the system time was 1681 seconds
        //The Api returned a value of 21 seconds
        let calculatedMovieTime = player.currentMovieTime
        let expected = 24.5
        XCTAssertEqual(calculatedMovieTime, expected)
    }
    
    func testEventOnScreenAt24point5SecondsIsArrayIndex23(){
        let currentSubtitle = player.currentSubtitleIndex
        let expected = 23
        XCTAssertEqual(expected, currentSubtitle)
    }
    
    func testTimeIntervalToNextSubtitleShouldBe0point5() {
        let expected = 0.5
        let calculatedInterval = player.timeIntervalToNextSubtitle
        XCTAssertEqual(expected, calculatedInterval)
    }
    
    func testUpdatePlayerWithSystemTimeOf1700point5shouldgiveIntervalToNextSubtitleOfOne() {
        timeDouble = TimeDouble(systemTime: 1700.5)
        player.updatePlayer(time: timeDouble)
        let expected = 1.0
        let calculatedInterval = player.timeIntervalToNextSubtitle
        XCTAssertEqual(expected, calculatedInterval)
    }
    
}
