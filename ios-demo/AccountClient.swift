//
//  AccountClient.swift
//  ios-demo
//
//  Created by Scott Weidenkopf on 1/18/16.
//  Copyright © 2016 City of Fort Wayne Rivergreenways. All rights reserved.
//

import Foundation

class AccountClient {
    
    func createAccount(account: Account) -> Bool {
        let url = "http://localhost:8080/trails/account/create"
        do {
            try WebStore.sendObjectJSON(url, object: account)
        }
        catch _ {
            return false
        }
        
        return true
    }
    
    func getAccount() {
        
    }
    
    
}