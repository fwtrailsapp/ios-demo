//
//  ActivityClient.swift
//  ios-demo
//
//  Created by Scott Weidenkopf on 1/20/16.
//  Copyright © 2016 City of Fort Wayne Rivergreenways. All rights reserved.
//

import Foundation

class ActivityClient {
    func createActivity(activity: Activity) -> Bool{
        let url = "http://149.164.222.0:8080/trails/api/1/activity"
        do {
            try WebStore.sendObjectJSON(url, object: activity)
        }
        catch _ {
            return false
        }
        
        return true

    }
}