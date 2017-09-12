//  APITest.swift

import XCTest

class APITest: XCTestCase {
    
    override func setUp() {
        super.setUp()

    }
    
    func testDownloadWebData() {
        let fileUrl = Bundle.main.url(forResource: "IronMan_420-425secs", withExtension: "wav")
        let recognize = Recognize(audioFilePath: fileUrl!)
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

    
}
