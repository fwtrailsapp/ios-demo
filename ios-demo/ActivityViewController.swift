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
    
    @IBOutlet weak var recordController: UIImageView!
    @IBOutlet weak var completeActivity: UIImageView!
    
    @IBOutlet weak var durationView: UITextView!
    @IBOutlet weak var distanceView: UITextView!
    @IBOutlet weak var speedView: UITextView!
    @IBOutlet weak var caloriesView: UITextView!
    
    let locationManager = CLLocationManager()
    let stdZoom: Float = 17
    var previousLocation: CLLocation?
    var previousTime: NSDate?
    var activity: Activity?
    let scottBMR = 1754.84
    let bikingMET = 7.5
    var caloriesBurned: Double = 0
    
    //MARK: View Controller Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
        self.mapView.myLocationEnabled = true
        self.mapView.settings.myLocationButton = true
        _ = KMLManager(gmap: mapView)
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
            activity!.path.addCoordinate(currLocation.coordinate)
            
            // display that path
            let polyline = GMSPolyline(path: activity!.path)
            polyline.map = mapView
            polyline.strokeWidth = 4
            
            // if previous time and previous location have been set, calculate the
            // statistics
            if previousTime != nil && previousLocation != nil {
                // for calculating the current speed
                let metersPerMile = 1609.34
                let secondsPerHour = 3600.0
                let timeDifferenceHours = currTime.timeIntervalSinceDate(previousTime!) / secondsPerHour
                let spatialDistanceMiles = currLocation.distanceFromLocation(previousLocation!) / metersPerMile
                
                // for calculating activity totals...
                activity!.duration += (timeDifferenceHours * 60)
                activity!.distance += spatialDistanceMiles
                
                let currSpeed = spatialDistanceMiles / timeDifferenceHours
                if currSpeed > activity!.topSpeed {
                    activity!.topSpeed = currSpeed
                }
                
                var formattedDuration = ""
                var formattedDistance = ""
                let formattedSpeed = formatNumber(currSpeed)
                
                // Change units of duration
                if activity!.duration < 1 { // convert to seconds
                    formattedDuration = formatNumber(activity!.duration * 60) + "s"
                } else if activity!.duration <= 60 { // leave as minutes
                    formattedDuration = formatNumber(activity!.duration) + "m"
                } else { // convert to hours
                    formattedDuration = formatNumber(activity!.duration / 60) + "h"
                }
                
                // Change units of distance
                if activity!.distance < 1 {
                    formattedDistance = formatNumber(activity!.distance * 5280) + "ft"
                } else {
                    formattedDistance = formatNumber(activity!.distance) + "mi"
                }
                
                caloriesBurned = (scottBMR / 24) * bikingMET * (activity!.duration / 60)
                
                durationView.text = formattedDuration
                distanceView.text = formattedDistance
                speedView.text = formattedSpeed
                caloriesView.text = "\(formatNumber(caloriesBurned))"
            }
            
            // Save the current time and current location
            previousTime = currTime
            previousLocation = currLocation
        }
    }
    
    // add touch recognition to play/pause and stop buttons
    func addGestures() {
        let toggle = UITapGestureRecognizer(target: self, action:Selector("recordControllerTapped"))
        recordController.addGestureRecognizer(toggle)
        
        let stop = UITapGestureRecognizer(target: self, action:Selector("completeActivityTapped"))
        completeActivity.addGestureRecognizer(stop)
    }
    
    // action function for stop button
    func completeActivityTapped() {
        if activity != nil && (activity!.state == .PAUSED || activity!.state == .RECORDING) {
            let alert = UIAlertController(title: "Finish Activity",
                message: "Would you like to save or discard this activity?",
                preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Save", style: UIAlertActionStyle.Default, handler: saveHandler))
            alert.addAction(UIAlertAction(title: "Discard", style: UIAlertActionStyle.Default, handler: discardHandler))
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    // action function for play/pause button 
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
    
    // Does all of the same stuff as discardHandler, but creates a summary 
    // pop up window
    func saveHandler(action: UIAlertAction) {
        let alert = UIAlertController(title: "Activity Saved",
            message:    "\nActivity Duration: \(formatNumber(activity!.duration))" +
                        "\nTotal Distance: \(formatNumber(activity!.distance))" +
                        "\nTop Speed: \(formatNumber(activity!.topSpeed))" +
                        "\nAverage Speed: \(formatNumber(activity!.distance / (activity!.duration / 60)))" +
                        "\nCalories Burned: \(formatNumber(caloriesBurned))",
            preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Cancel, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
        let client = ActivityClient()
        client.createActivity(activity!)
        discardHandler(action)
    }
    
    // Method for handling discard selection when activity is
    // completed. 
    // Clears all of the activity statistics, sets the activity to
    // nil, setes the recordController image to play, and clears the map
    func discardHandler(action: UIAlertAction) {
        clearText()
        activity = nil
        recordController.image = UIImage(named: "Play")
        mapView.clear()
    }
    
    // Helper method to clear all of the text views
    func clearText() {
        distanceView.text = ""
        durationView.text = ""
        speedView.text = ""
        caloriesView.text = ""
    }
    
    // Helper method to format numbers
    func formatNumber(number: Double) -> String {
        return String(format: "%.1f", number)
    }
}

