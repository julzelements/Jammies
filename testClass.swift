//
//  testClass.swift
//  Jammies
//
//  Created by Julian Scharf on 15/9/17.
//  Copyright © 2017 Julian Scharf. All rights reserved.
//

import UIKit

class testClass: NSObject {
    
   
    func submitForm() {
        
        let endpoint = getApiEndPoint()
        let form = MultipartForm(endpoint: endpoint, asset: URL,  )
    }

}
