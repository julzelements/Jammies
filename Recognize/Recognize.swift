import UIKit

class Recognize: NSObject {
    
    var audioURL: URL
    var url: URL

    init(audioFilePath: URL) {
        self.audioURL = audioFilePath
        self.url = URL(string: "http://146.148.93.62:5000/recognize")!  //TODO: replace this with Plist reference
    }
    
    func recognize() -> URLRequest {
        let recordingName = audioURL.lastPathComponent
        let data = try! Data(contentsOf: audioURL)
        let boundary = "Boundary-\(UUID().uuidString)"
        
        let body = createMultipart(data: data, boundary: boundary, fileName: recordingName)
        print(body)
        var request = URLRequest(url: url)
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
