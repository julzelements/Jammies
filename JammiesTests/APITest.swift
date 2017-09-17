//  APITest.swift

import XCTest

class APITest: XCTestCase {
    
    var url: URL!
    
    override func setUp() {
        super.setUp()
        url = Bundle.main.url(forResource: "IronMan_420-425secs", withExtension: "wav")
    }
    
    func testDownloadWebData() {
        let fileUrl = Bundle.main.url(forResource: "IronMan_420-425secs", withExtension: "wav")
        let recognize = AudioFormCreator(audioFilePath: fileUrl!)
        let request = recognize.createMultiformPOSTRequest()
        

        let expectation = XCTestExpectation(description: "Hit the backend with a recognize request")

        let dataTask = URLSession.shared.dataTask(with: request) { (data, _, _) in
            if let data = data,
                let string = String(data: data, encoding: .utf8) {
                print(string)
                XCTAssertTrue(string.contains("offset_seconds': 420.00254"))
               }
            expectation.fulfill()
            
        }
        dataTask.resume()
        wait(for: [expectation], timeout: 20.0)
    }
    
    func testAudioFormShouldHaveAHashValueEqualToExpected() {
        let audioForm = AudioFormCreator(audioFilePath: url!)
        let multipartRequest = audioForm.createMultiformPOSTRequest()
        let expectedHashValue: Int = 5888584665680383277
        let hashValue = multipartRequest.hashValue
        XCTAssertEqual(hashValue, expectedHashValue)
    }
    
}
