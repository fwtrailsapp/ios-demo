//
//  ViewController.swift
//  ios-demo
//
//  Created by Scott Weidenkopf on 11/8/15.
//  Copyright © 2015 City of Fort Wayne Rivergreenways. All rights reserved.
//

import UIKit

class ActivityViewController: UIViewController, CLLocationManagerDelegate {

    // MARK: Properties
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var activityStatistics: UITextView!
    @IBOutlet weak var recordController: UIImageView!
    @IBOutlet weak var completeActivity: UIImageView!
    
    let locationManager = CLLocationManager()
    let stdZoom: Float = 15
    let activityStartTime = NSDate()
    var activityStartLocation: CLLocation?
    var previousLocation: CLLocation?
    var previousTime: NSDate?
    var activity: Activity?
    
    //MARK: View Controller Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
        self.mapView.myLocationEnabled = true
        self.mapView.settings.myLocationButton = true
        let mgr = KMLManager(gmap: mapView)
        self.mapView.addObserver(self, forKeyPath: "myLocation", options: NSKeyValueObservingOptions.New, context: nil)
        
        addGestures()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Location Manager Overrides
    /*
        Method that handles changes in the user's location. It refreshes the map to
        refocus on the user and calls updates the user's activity statistics.
    */
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        let myLocation: CLLocation = change![NSKeyValueChangeNewKey] as! CLLocation
        
        // Set the start of the activity if it isn't set
        if activityStartLocation == nil {
            activityStartLocation = myLocation
        }
        
        self.mapView.camera = GMSCameraPosition.cameraWithTarget(myLocation.coordinate, zoom: stdZoom)
        
        let currTime = NSDate()
        updateActivityStatistics(currTime, currLocation: myLocation)
    }
    
    /*
        Updates the activity statistics bar at the bottom of the activity screen.
        These statistics are: activity duration, total distance traveled, and
        current speed.
    */
    func updateActivityStatistics(currTime: NSDate, currLocation: CLLocation) {
        
        if activity != nil && activity!.state! == ActivityState.RECORDING {
            // if previous time and previous location have been set, calculate the
            // statistics
            if previousTime != nil && previousLocation != nil {
                // for calculating the current speed
                let timeDifferenceHours = currTime.timeIntervalSinceDate(previousTime!) / (3600 as Double)
                let spatialDistanceMiles = currLocation.distanceFromLocation(previousLocation!) / 1609.34
                
                // for calculating activity totals...
                let totalDistanceTraveledMiles = currLocation.distanceFromLocation(activityStartLocation!) / 1609.34
                let totalTimeDifferenceMin = currTime.timeIntervalSinceDate(activityStartTime) / (60 as Double)
                
                activityStatistics.text = "Activity Duration: \(totalTimeDifferenceMin)" +
                    "\nDistance Travelled: \(totalDistanceTraveledMiles)" +
                "\nCurrent Speed: \(spatialDistanceMiles / timeDifferenceHours)"
                
                
            }
            
            // Save the current time and current location
            previousTime = currTime
            previousLocation = currLocation
        }
    }
    
    func addGestures() {
        let toggle = UITapGestureRecognizer(target: self, action:Selector("recordControllerTapped"))
        recordController.addGestureRecognizer(toggle)
        
        let stop = UITapGestureRecognizer(target: self, action:Selector("completeActivityTapped"))
        completeActivity.addGestureRecognizer(stop)
    }
    
    func completeActivityTapped() {
        
    }
    
    func recordControllerTapped() {
        if activity == nil {
            activity = Activity()
        }
        
        switch activity!.state! {
        case .PAUSED, .CREATED:
            activity!.state! = ActivityState.RECORDING
            recordController.image = UIImage(named: "Pause")
        case .RECORDING:
            activity!.state! = ActivityState.PAUSED
            recordController.image = UIImage(named: "Play")
        default:
            return
        }
    }
}

