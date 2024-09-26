//
//  LocationPickerViewController+CLLocationManagerDelegate.swift
//  SimpleTouch
//
//  Created by SimpleTouch on 10/4/20.
//  Copyright © 2020 SimpleTouch. All rights reserved.
//

import UIKit
import GoogleMaps
//MARK: - CLLocationManagerDelegate Protocol
extension LocationPickerViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: (error)")
    }
}
