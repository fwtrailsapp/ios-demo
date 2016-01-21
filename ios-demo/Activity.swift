//
//  Activity.swift
//  ios-demo
//
//  Created by Scott Weidenkopf on 11/27/15.
//  Copyright © 2015 City of Fort Wayne Rivergreenways. All rights reserved.
//

import Foundation

class Activity: DictionarySerializable {
    
    // MARK: Properties
    var state: ActivityState?
    var duration: Double = 0 //minutes
    var distance: Double = 0 //miles
    var timestamp: Double //miliseconds since 1970
    var topSpeed: Double = 0 //mph
    var path: GMSMutablePath = GMSMutablePath()
    
    init(timestamp: Double) {
        state = ActivityState.CREATED
        self.timestamp = timestamp
    }
    
    func toDictionary() -> Dictionary<String, AnyObject> {
        return ["top_speed": topSpeed, "distance": distance, "duration": duration, "timestamp": timestamp]
    }
}



//MARK: ActivityState
enum ActivityState {
    case CREATED
    case RECORDING
    case PAUSED
    case COMPLETED
}