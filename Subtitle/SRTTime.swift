//  SRTTime.swift

import UIKit

class SRTTime {
    var hours: Int
    var minutes: Int
    var seconds: Int
    var milliseconds: Int
    var seconds_Double: Double
    
    init(srtTime: String) {
        let time = SRTTime.extractTimesFromSRTString(srtTime: srtTime)
        self.hours = time.hrs!
        self.minutes = time.mins!
        self.seconds = time.secs!
        self.milliseconds = time.millisec!
        self.seconds_Double = SRTTime.absoluteTimeInSeconds(hrs: time.hrs!, mins: time.mins!, secs: time.secs!, millisec: time.millisec!)
    }
    
    static private func extractTimesFromSRTString(srtTime: String) -> (hrs: Int?, mins: Int?, secs: Int?, millisec: Int?) {
        let timeWithNoColon = srtTime.replacingOccurrences(of: ",", with: ":")
        let timeArray = timeWithNoColon.components(separatedBy: ":")
        if timeArray.count == 4 {
            let hours = Int(timeArray[0])
            let minutes = Int(timeArray[1])
            let seconds = Int(timeArray[2])
            let milliseconds = Int(timeArray[3])
            return (hours, minutes, seconds, milliseconds)
        }
        print("error parsing \(srtTime)")
        return (0, 0, 0, 0)
    }
    
    static private func absoluteTimeInSeconds(hrs: Int, mins: Int, secs: Int, millisec: Int) -> Double {
        return (Double(hrs) * 3600.0) + (Double(mins) * 60.0) + (Double(secs)) + (Double(millisec) / 1000.0)
    }
    
}
