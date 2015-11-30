//
//  Activity.swift
//  ios-demo
//
//  Created by Scott Weidenkopf on 11/27/15.
//  Copyright © 2015 City of Fort Wayne Rivergreenways. All rights reserved.
//

import Foundation

class Activity {
    
    var state: ActivityState?
    
    init() {
        state = ActivityState.CREATED
    }
}

enum ActivityState {
    case CREATED
    case RECORDING
    case PAUSED
    case COMPLETED
}