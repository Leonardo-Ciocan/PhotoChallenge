//
//  Notification.swift
//  PhotoChallenge
//
//  Created by Leonardo Ciocan on 13/06/2016.
//  Copyright © 2016 lc. All rights reserved.
//

import Foundation
import SwiftyJSON

class Notification {
    var type = 0
    var payload = ""
    
    init(json:JSON) {
        if let type = json["type"].int {
            self.type = type
        }
        
        if let payload = json["payload"].string {
            self.payload = payload
        }
    }
}