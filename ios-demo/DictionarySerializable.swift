//
//  DictionarySerializable.swift
//  ios-demo
//
//  Created by Scott Weidenkopf on 1/18/16.
//  Copyright © 2016 City of Fort Wayne Rivergreenways. All rights reserved.
//

import Foundation

protocol DictionarySerializable {
    
    func toDictionary() -> Dictionary<String, AnyObject>
    
}