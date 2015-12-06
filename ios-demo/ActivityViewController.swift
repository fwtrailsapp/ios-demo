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
            // add currLocation coordinates to activity.path
            activity!.path.append(currLocation.coordinate)
            
            // if previous time and previous location have been set, calculate the
            // statistics
            if previousTime != nil && previousLocation != nil {
                // for calculating the current speed
                let timeDifferenceHours = currTime.timeIntervalSinceDate(previousTime!) / (3600 as Double)
                let spatialDistanceMiles = currLocation.distanceFromLocation(previousLocation!) / 1609.34
                
                // for calculating activity totals...
                activity!.duration += (timeDifferenceHours * 60)
                activity!.distance += spatialDistanceMiles
                
                activityStatistics.text = "Activity Duration: \(activity!.duration)" +
                    "\nDistance Travelled: \(activity!.distance)" +
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
        let alert = UIAlertController(title: "Finish Activity",
            message: "Would you like to save or discard this activity?",
            preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Save", style: UIAlertActionStyle.Default, handler: saveHandler))
        alert.addAction(UIAlertAction(title: "Discard", style: UIAlertActionStyle.Default, handler: discardHandler))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func recordControllerTapped() {
        if activity == nil {
            activity = Activity(timestamp: NSDate().timeIntervalSince1970 * 1000)
        }
        
        switch activity!.state! {
        case .PAUSED, .CREATED:
            activity!.state! = ActivityState.RECORDING
            recordController.image = UIImage(named: "Pause")
        case .RECORDING:
            activity!.state! = ActivityState.PAUSED
            recordController.image = UIImage(named: "Play")
            previousLocation = nil
            previousTime = nil
        default:
            return
        }
    }
    
    func saveHandler(action: UIAlertAction) {
        
    }
    
    func discardHandler(action: UIAlertAction) {
        
    }
}

