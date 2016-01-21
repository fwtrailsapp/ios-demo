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
    
    class func sendObjectJSON(url: String, object: DictionarySerializable) throws {
        let params = object.toDictionary()
        let serializer = JSONParameterSerializer()
        let headers = ["Content-Type": "application/json"]
        let opt = try HTTP.POST(url, requestSerializer: serializer, headers: headers, parameters: params)
        opt.start { response in
            //
        }
    }
    
    /*
    class func getObjectJSON(url: String) throws -> Dictionary<String, Any> {
        
    }*/       
    
}