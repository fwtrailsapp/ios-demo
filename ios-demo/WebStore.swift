//
//  WebStore.swift
//  ios-demo
//
//  Created by Scott Weidenkopf on 12/23/15.
//  Copyright © 2015 City of Fort Wayne Rivergreenways. All rights reserved.
//

import Foundation
import SwiftHTTP

class WebStore {
    
    init() {
        
    }
    
    class func addAccount() {
        let params = ["first_name": "scott", "last_name": "weidenkopfs", "weight": "156", "age": 21, "sex": "M", "height": "68", "password": "123", "email": "scottyseus.maximus.rex@gmail.com"]
        print(params)
        do {
            let opt = try HTTP.POST("http://localhost:8080/trails/add_account", parameters: params, headers: ["Content-Type": "application/json"])
            opt.start { response in
                print("sending request")
            }
        } catch let error {
            print("got an error creating the request: \(error)")
        }
    }
    
}