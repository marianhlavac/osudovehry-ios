//
//  Event.swift
//  osudovehry
//
//  Created by Marián Hlaváč on 21/01/2017.
//  Copyright © 2017 majko. All rights reserved.
//

import UIKit
import SwiftyJSON

class Event: NSObject {
    
    let name: String
    let desc: String
    let startsAt: Date
    let endsAt: Date
    let price: Int
    let coverPhoto: UIImage
    let attendeeCount: Int
    let url: String
    let results: [String]
    
    init(json: JSON, coverPhoto: UIImage) {
        name = json["name"].stringValue
        desc = json["description"].stringValue
        startsAt = json["starts-at"].dateValue!
        endsAt = json["ends-at"].dateValue!
        price = json["price"].intValue
        self.coverPhoto = coverPhoto
        attendeeCount = json["attendee-count"].intValue
        url = json["url"].exists() ? json["url"].stringValue : ""
        
        if (json["results"].exists()) {
            results = [
                json["results"]["first"].stringValue,
                json["results"]["second"].stringValue,
                json["results"]["third"].stringValue
            ]
        } else {
            results = [ ]
        }
    }
}
