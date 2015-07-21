//
//  ViewController.swift
//  Location
//
//  Created by Isaac Overacker on 7/21/15.
//  Copyright (c) 2015 Isaac Overacker. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var altitudeLabel: UILabel!
    
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.locationManager.delegate = self
        if CLLocationManager.authorizationStatus() == CLAuthorizationStatus.NotDetermined {
            self.locationManager.requestWhenInUseAuthorization()
        }
        
        self.locationManager.startUpdatingLocation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        if let newLocation = locations.last as? CLLocation {
            self.latitudeLabel.text = String(format: "Latitude: %.2f", newLocation.coordinate.latitude)
            self.longitudeLabel.text = String(format: "Longitude: %.2f", newLocation.coordinate.longitude)
            self.altitudeLabel.text = String(format: "Altitude: %.2f", newLocation.altitude)
        }
    }


}

