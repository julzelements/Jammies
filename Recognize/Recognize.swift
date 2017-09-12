import UIKit

class Recognize: NSObject {
    
    var audioURL: URL
    var apiEndPoint: String
    var url: URL!

    init(audioFilePath: URL) {
        self.audioURL = audioFilePath
        self.apiEndPoint = Recognize.getApiEndPoint()
    }
    
    private static func getApiEndPoint() -> String {
        if let path = Bundle.main.url(forResource: "Info", withExtension: "plist") {
            let plist = NSDictionary(contentsOf: path)
            return plist!["APIEndPoint"] as! String
        } else {
            return "api endpoint not set in Info.plist"
        }
    }
    
    private func getAudioRecordingData() -> Data {
        let data = try! Data(contentsOf: audioURL)
        return data
    }
    
    func createMultiformPOSTRequest() -> URLRequest {
        let url = URL(string: apiEndPoint)
        let recordingName = audioURL.lastPathComponent
        let data = getAudioRecordingData()
        let boundary = "Boundary-\(UUID().uuidString)"
        let body = createMultipart(data: data, boundary: boundary, fileName: recordingName)
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.setValue("100-continue", forHTTPHeaderField: "Expect")
        request.httpBody = body
        return request
    }
    
    private func createMultipart(data: Data, boundary: String, fileName: String) -> Data {
        var body = Data()
        
        let boundaryPrefix = "--\(boundary)\r\n"
        body.append(contentsOf: boundaryPrefix.utf8)
        body.append(contentsOf: "Content-Disposition: form-data; name=\"file\"; filename=\"my_audio.wav\"\r\n".utf8)
        body.append(contentsOf: "Content-Type: audio/wav\r\n".utf8)
        body.append(contentsOf: "\r\n".utf8)
        body.append(data)
        body.append(contentsOf: "\r\n".utf8)
        body.append(contentsOf: ("--" + boundary + "--").utf8)
        body.append(contentsOf: "\r\n".utf8)
        return body
    }
  
}
