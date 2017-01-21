//
//  APIWrapper.swift
//  osudovehry
//
//  Created by Marián Hlaváč on 21/01/2017.
//  Copyright © 2017 majko. All rights reserved.
//

import Alamofire
import SwiftyJSON

enum APIWrapperResult {
    case success(JSON)
    case failure(Error)
}

class APIWrapper {
    
    // This is singleton
    private init() { }
    static let service: APIWrapper = APIWrapper()
    
    var events : [Event] = []
    
    func fetchData() {
        Alamofire.request("http://private-1f7cd-osudovehry.apiary-mock.com/events").responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                self.events.removeAll()
                for event in json.arrayValue {
                    self.events.append(Event(json: event))
                }
                
                NotificationCenter.default.post(name: NotificationTypes.dataChange, object: nil)
            case .failure(let error):
                print(error)
                // TODO: do something, ffs
            }
        }
    }
    
    func getEvents() -> [Event] {
        return events
    }
    
    func getUpcomingEvents() -> [Event] {
        return events.filter() {
            switch $0.startsAt.compare(Date()) {
            case .orderedDescending:
                return true
            default:
                return false
            }
        }
    }
}
