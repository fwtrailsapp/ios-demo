//
//  KMLManager.swift
//  ios-demo
//
//  Created by Jared P on 11/15/15.
//  Copyright © 2015 City of Fort Wayne Rivergreenways. All rights reserved.
//

import Foundation


class KMLManager {
    // MARK: InstanceData
    let gmap : GMSMapView
    
    // MARK : Functions
    init(gmap : GMSMapView) {
        self.gmap = gmap
        loadUrl("https://gist.githubusercontent.com/libjared/4b703481eccad557807c/raw/78ebe13d134c8fdb4c14c62c37cad5b2a02af133/dude.kml")
    }
    
    func loadUrl(url : String) {
        let root = KMLParser.parseKMLAtURL(NSURL(string: url))
        if root == nil {
            print("Failed at parse.")
            return
        }
        let placemarks = root.placemarks() as! [KMLPlacemark]
        
        for trail in placemarks {
            let linestr = trail.geometry as! KMLLineString
            let path = GMSMutablePath()
            for coord in linestr.coordinates {
                let lat = Float(coord.latitude)
                let long = Float(coord.longitude)
                path.addLatitude(CLLocationDegrees(lat), longitude: CLLocationDegrees(long))
            }
            let poly = GMSPolyline(path: path)
            poly.strokeWidth = 6
            poly.strokeColor = UIColor.blackColor()
            poly.map = gmap
        }
    }
}