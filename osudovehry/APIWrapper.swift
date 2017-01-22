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
                
                let group = DispatchGroup()
                
                for event in json.arrayValue {
                    group.enter()
                    Alamofire.request(event["cover-photo"].stringValue).response { response in
                        let coverPhoto = UIImage(data: response.data!, scale:1)
                        self.events.append(Event(json: event, coverPhoto: coverPhoto!))
                        group.leave()
                    }
                }
                
                group.notify(queue: .main) {
                    NotificationCenter.default.post(name: NotificationTypes.dataChange, object: nil)
                }
            case .failure(let error):
                print(error)
                // TODO: do something, ffs
            }
        }
    }
    
    func getSortedEvents() -> [Event] {
        return events.sorted(by: { $0.startsAt.compare($1.startsAt) == ComparisonResult.orderedDescending })
    }
    
    func getEvents() -> [Event] {
        return getSortedEvents()
    }
    
    func getUpcomingEvents() -> [Event] {
        return getSortedEvents().filter() {
            switch $0.startsAt.compare(Date()) {
            case .orderedDescending:
                return true
            default:
                return false
            }
        }
    }
    
    func getEventsWithResults() -> [Event] {
        return getSortedEvents().filter() {
            return $0.results.count > 0
        }
    }
}
