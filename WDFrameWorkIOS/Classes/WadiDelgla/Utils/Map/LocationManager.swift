//
//  LocationManager.swift
//  DoBites
//
//  Created by SimpleTouch on 6/27/19.
//  Copyright © 2019 Nermeen Mohdamed. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
//import Toast_Swift
public class LocationManager: NSObject {
    static let sharedInstance = LocationManager()
    private var locationManager = CLLocationManager()
    private let operationQueue = OperationQueue()
    let geoCoder = CLGeocoder()

   private override init(){
        super.init()
        
        //Pause the operation queue because
        // we don't know if we have location permissions yet
        operationQueue.isSuspended = true
        locationManager.delegate = self
        
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
    }
}
//MARK: - CLLocationManagerDelegate Protocol
extension LocationManager : CLLocationManagerDelegate{
   public  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {}
    public  func locationManager(_ manager: CLLocationManager,
                                  didChangeAuthorization status: CLAuthorizationStatus) {}
    public func locationManager(_ manager: CLLocationManager,
                                  didFailWithError error: Error) {}
}
//MARK: - Functions
extension LocationManager {
    static func requestGPS() {
        LocationManager.sharedInstance.locationManager.requestLocation()
       }
    

    ///Checks the status of the location permission
    /// and adds the callback block to the queue to run when finished checking
    /// NOTE: Anything done in the UI should be enclosed in `DispatchQueue.main.async {}`
    func runLocationBlock(callback: @escaping () -> ()){
        
        //Get the current authorization status
        let authState = CLLocationManager.authorizationStatus()
        
        //If we have permissions, start executing the commands immediately
        // otherwise request permission
        if(authState == .authorizedAlways || authState == .authorizedWhenInUse){
            self.operationQueue.isSuspended = false
        }else if (authState == .notDetermined) {
            return
        }else{
            //Request permission
            locationManager.requestAlwaysAuthorization()
            doPostNotification(NotificationName.userNotAllowAccessLocation.rawValue)
        }
        
        //Create a closure with the callback function so we can add it to the operationQueue
        let block = { callback() }
        
        //Add block to the queue to be executed asynchronously
        self.operationQueue.addOperation(block)
    }
    func getLatitude() -> Double {
        guard let lat = locationManager.location?.coordinate.latitude else {
            return 0
        }
        return lat
    }
    
    func getLongitude() -> Double {
        guard let long = locationManager.location?.coordinate.longitude else {
            return 0
        }
        return long
        
    }
    func getCurrentLocation() -> CLLocationCoordinate2D{
        
        guard let currentLocation = locationManager.location?.coordinate else {
            return CLLocationCoordinate2D(latitude: 0, longitude: 0)
        }
        return currentLocation
    }
    func getAddressFromLatLon(pdblLatitude: Double, withLongitude pdblLongitude: Double,completion:@escaping ((String) -> Void)){
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        let lat: Double = Double("\(pdblLatitude)")!
        //21.228124
        let lon: Double = Double("\(pdblLongitude)")!
        //72.833770
        let ceo: CLGeocoder = CLGeocoder()
        center.latitude = lat
        center.longitude = lon
        
        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
        let lang: String = K.shared.APP_LANGUAGE == "ar" ? "ar" : "en_US"
        
        var address = ""
        
        ceo.reverseGeocodeLocation(loc,preferredLocale: Locale.init(identifier: lang), completionHandler:
            {(placemarks, error) in
                if (error != nil)
                {
                    print("reverse geodcode fail: \(error!.localizedDescription)")
                    
                }
                let pm = placemarks! as [CLPlacemark]
                
                if pm.count > 0 {
                    let pm = placemarks![0]
                    print(pm.country)
                    print(pm.locality)
                    print(pm.subLocality)
                    print(pm.thoroughfare)
                    print(pm.postalCode)
                    print(pm.subThoroughfare)
                    var addressString : String = ""
                    if pm.subLocality != nil {
                        addressString = addressString + pm.subLocality! + ", "
                    }
                    if pm.thoroughfare != nil {
                        addressString = addressString + pm.thoroughfare! + ", "
                    }
                    if pm.locality != nil {
                        addressString = addressString + pm.locality! + ", "
                    }
                    if pm.country != nil {
                        addressString = addressString + pm.country! + ", "
                    }
                    if pm.postalCode != nil {
                        addressString = addressString + pm.postalCode! + " "
                    }
                    print(addressString)
                    address = addressString
                    completion(address)
                }
        })
        
        
    }
    
    func getUserCurrentISOCountry(completion: @escaping (String?) -> Void) {
        runLocationBlock {
            let location = CLLocation(latitude: self.getLatitude(), longitude: self.getLongitude())
                       self.getCountry(forLocation: location) { country in
//                           completion(country?.isoCountryCode)
                        completion("EG")
                       }
        }
    }
    func getCountry(forLocation location: CLLocation,completion: @escaping (CLPlacemark?) -> Void){
        geoCoder.reverseGeocodeLocation(location) { (placemarks, error) in
            completion(placemarks?.first)
        }
    }
}
