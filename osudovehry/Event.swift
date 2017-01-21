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
    let startsAt: String
    let endsAt: String
    let price: Int
    let coverPhotoUrl: String
    let attendeeCount: Int
    
    init(json: JSON) {
        name = json["name"].stringValue
        desc = json["description"].stringValue
        startsAt = json["starts-at"].dateValue!
        endsAt = json["ends-at"].dateValue!
        price = json["price"].intValue
        coverPhotoUrl = json["cover-photo-url"].stringValue
        attendeeCount = json["attendee-count"].intValue
    }
}
