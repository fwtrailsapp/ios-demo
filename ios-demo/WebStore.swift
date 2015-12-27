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
        let params = ["f_name": "'scott'", "l_name": "'weidenkopf'", "weight": "156", "age": "21", "sex": "'M'", "height": "68", "password": "'123'", "pk_email": "'email'"]
        print(params)
        let serializer = JSONParameterSerializer()
        let URL = "http://localhost:8080/trails/add_account"
        
        do {
            let opt = try HTTP.POST(URL, requestSerializer: serializer, headers: ["Content-Type": "application/json"], parameters: params)
            opt.start { response in
                print("sending request")
            }
        } catch let error {
            print("got an error creating the request: \(error)")
        }
    }
    
}