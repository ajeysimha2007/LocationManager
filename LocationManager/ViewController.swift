//
//  ViewController.swift
//  LocationManager
//
//  Created by Ajey Simha on 02/11/16.
//  Copyright © 2016 Ajey Simha. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    let locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getLocation()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getLocation(){
        print("my location is - ")
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    private func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        switch status {
        case CLAuthorizationStatus.restricted:
            print("restricted")
            break
        case CLAuthorizationStatus.denied:
            print("denied")
            break
        case CLAuthorizationStatus.notDetermined:
            print("not determined")
            break
        case CLAuthorizationStatus.authorizedWhenInUse:
            print("allowed")
            break
        case CLAuthorizationStatus.authorizedAlways:
            print("allowed")
            break
        default:
            print("allowed")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error while updating location " + error.localizedDescription)
    }
    
    //func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        CLGeocoder().reverseGeocodeLocation(manager.location!, completionHandler: {(placemarks, error)->Void in
            if (error != nil) {
                print("Reverse geocoder failed with error" + error!.localizedDescription)
                self.locationManager.stopUpdatingLocation()
                return
            }
            
            if placemarks!.count > 0 {
                let pm = placemarks![0]
                print(pm.country)
                print(pm.administrativeArea)
                print(pm.locality)
                print(pm.postalCode)
                print(pm.isoCountryCode)
                print(pm.location?.coordinate.latitude)
                print(pm.location?.coordinate.longitude)

                self.locationManager.stopUpdatingLocation()
            }
            else {
                print("Problem with the data received from geocoder")
            }
        })
    }
}

