//
//  Activity.swift
//  ios-demo
//
//  Created by Scott Weidenkopf on 11/27/15.
//  Copyright © 2015 City of Fort Wayne Rivergreenways. All rights reserved.
//

import Foundation

class Activity {
    
    // MARK: Properties
    var state: ActivityState?
    var duration: Double = 0 //minutes
    var distance: Double = 0 //miles
    var timestamp: Double //miliseconds since 1970
    var topSpeed: Double = 0 //mph
    var path: [CLLocationCoordinate2D]
    
    init(timestamp: Double) {
        state = ActivityState.CREATED
        self.timestamp = timestamp
        self.path = [CLLocationCoordinate2D]()
    }
}

//MARK: ActivityState
enum ActivityState {
    case CREATED
    case RECORDING
    case PAUSED
    case COMPLETED
}