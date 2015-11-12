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
    @IBOutlet weak var exerciseTypePicker: UIPickerView!
    
    @IBAction func activityStartButton(sender: UIButton) {
        
    }
    
    let fwLat = 41.0804
    let fwLong = -85.1392
    let stdZoom: Float = 12
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let target = CLLocationCoordinate2D(latitude: fwLat, longitude:fwLong);
        let update = GMSCameraUpdate.setTarget(target, zoom: stdZoom)
        mapView.moveCamera(update)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

