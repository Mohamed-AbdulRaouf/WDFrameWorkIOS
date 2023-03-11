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
            
//        guard let locValue : CLLocationCoordinate2D = manager.location?.coordinate else { return }
//        print("Locations = \(locValue.latitude) \(locValue.longitude)")
//
//        if let location = locations.first {
//            let camera = GMSCameraPosition.camera(withLatitude: (location.coordinate.latitude), longitude: (location.coordinate.longitude), zoom: 17.0)
//
//            self.locationMapView?.animate(to: camera)
//
//            //Finally stop updating location otherwise it will come again and again in this delegate
//            self.locationManager.stopUpdatingLocation()
//
//        }
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
