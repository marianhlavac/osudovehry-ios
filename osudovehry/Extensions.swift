//
//  Extensions.swift
//  osudovehry
//
//  Created by Marián Hlaváč on 21/01/2017.
//  Copyright © 2017 majko. All rights reserved.
//

import UIKit
import SwiftyJSON

extension JSON {
    public var dateValue: Date? {
        get {
            if let string = self.string {
                return JSON.jsonDateFormatter.date(from: string)
            }
            return nil
        }
    }
    
    private static let jsonDateFormatter: DateFormatter = {
        let fmt = DateFormatter()
        fmt.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        fmt.timeZone = TimeZone(secondsFromGMT: 0)
        return fmt
    }()
}
