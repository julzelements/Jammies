//
//  SubtitleIO.swift
//  TimeMock
//
//  Created by Julian Scharf on 13/7/17.
//  Copyright © 2017 Julian Scharf. All rights reserved.
//

import UIKit

enum SubtitleIO {
    
    static func getRawStringFromFileInBundle(fileName: String, fileExtension: String) -> String {
        let bundle = Bundle.main
        if let url = bundle.url(forResource: fileName, withExtension: fileExtension) {
            
            do {
                return try String(contentsOf: url, encoding: .utf8)
            } catch {
                return "could not read contents of URL as a string"
            }
            
        }
        return "could not obtain URL"
    }
}
