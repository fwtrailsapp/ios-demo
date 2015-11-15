//
//  ViewController.swift
//  ios-demo
//
//  Created by Scott Weidenkopf on 11/8/15.
//  Copyright © 2015 City of Fort Wayne Rivergreenways. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: Properties
    @IBOutlet weak var mapView: GMSMapView!
    
    let locationManager = CLLocationManager()
    let stdZoom: Float = 12
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager.requestWhenInUseAuthorization()
        self.mapView.myLocationEnabled = true
        self.mapView.settings.myLocationButton = true
        
        if let myLocation = mapView.myLocation {
            print("my location enabled")
            let update = GMSCameraUpdate.setTarget(myLocation.coordinate, zoom: stdZoom)
            self.mapView.moveCamera(update)
        } else {
            print("my location could not be enabled")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

