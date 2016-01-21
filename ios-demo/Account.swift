//
//  Account.swift
//  ios-demo
//
//  Created by Scott Weidenkopf on 1/18/16.
//  Copyright © 2016 City of Fort Wayne Rivergreenways. All rights reserved.
//

import Foundation

class Account: DictionarySerializable {
    
    var email: String
    var password: String
    
    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
    
    func toDictionary() -> Dictionary<String, AnyObject> {
        return ["email": email, "password": password]
    }
}