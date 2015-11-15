//
//  KMLManager.swift
//  ios-demo
//
//  Created by Jared P on 11/15/15.
//  Copyright © 2015 City of Fort Wayne Rivergreenways. All rights reserved.
//

import Foundation


class KMLManager {
    init() {
        loadUrl("https://gist.githubusercontent.com/libjared/4b703481eccad557807c/raw/78ebe13d134c8fdb4c14c62c37cad5b2a02af133/dude.kml")
    }
    
    func loadUrl(url : String) {
        let root = KMLParser.parseKMLAtURL(NSURL(string: url))
        if (root == nil) {
            print("Failed at parse.")
            return;
        }
        let placemarks = root.placemarks() as! [KMLPlacemark]
        print("Found \(placemarks.count) placemarks!!!!!")
        let first = placemarks[0]
        guard let linestr = first.geometry as? KMLLineString else {
            print("First isn't a line string.")
            return
        }
        
        let trailstart = linestr.coordinates[0] as! KMLCoordinate
        let lat = Float(trailstart.latitude)
        let long = Float(trailstart.longitude)
        print("Trail called \(first.name) starts at \(lat) and \(long)")
    }
}