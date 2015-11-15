//
//  ViewController.swift
//  ios-demo
//
//  Created by Scott Weidenkopf on 11/8/15.
//  Copyright © 2015 City of Fort Wayne Rivergreenways. All rights reserved.
//

import UIKit

class ViewController: UIViewController, CLLocationManagerDelegate {

    // MARK: Properties
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var activityStatistics: UITextView!
    
    let locationManager = CLLocationManager()
    let stdZoom: Float = 15
    let activityStart = NSDate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
        self.mapView.myLocationEnabled = true
        self.mapView.settings.myLocationButton = true
        
        self.mapView.addObserver(self, forKeyPath: "myLocation", options: NSKeyValueObservingOptions.New, context: nil)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        let myLocation: CLLocation = change![NSKeyValueChangeNewKey] as! CLLocation
        self.mapView.camera = GMSCameraPosition.cameraWithTarget(myLocation.coordinate, zoom: stdZoom)
        
        let currTime = NSDate()
        updateActivityStatistics(currTime, currLocation: myLocation.coordinate);
        
        self.mapView.settings.myLocationButton = true
    }
    
    func updateActivityStatistics(currTime: NSDate, currLocation: CLLocationCoordinate2D) {
        
    }

}

