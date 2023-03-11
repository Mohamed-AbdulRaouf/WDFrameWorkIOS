//
//  LocationPickerViewController+ GMSMapViewDelegate.swift
//  SimpleTouch
//
//  Created by SimpleTouch on 10/5/20.
//  Copyright © 2020 SimpleTouch. All rights reserved.
//

import UIKit
import GoogleMaps
//MARK: - GMSMapViewDelegate PROTOCOL
extension LocationPickerViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        print("You tapped at \(coordinate.latitude), \(coordinate.longitude)")
        locationMapView.clear() // clearing Pin before adding new
        plotMarker(AtCoordinate: coordinate, onMapView: mapView)
        reverseGeocodeCoordinate(coordinate: coordinate)
    }
    
    
 
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        var destinationLocation = CLLocation()
        destinationLocation = CLLocation(latitude: position.target.latitude,  longitude: position.target.longitude)
        let  destinationCoordinate = destinationLocation.coordinate
        updateLocationoordinates(coordinates: destinationCoordinate)
    }
    
    // UpdteLocationCoordinate
     func updateLocationoordinates(coordinates:CLLocationCoordinate2D) {
         CATransaction.begin()
         CATransaction.setAnimationDuration(1.0)
         pinMarker =  GMSMarker(position: coordinates)
         CATransaction.commit()
     }
    // MARK: - Geocoding
       func reverseGeocodeCoordinate(coordinate: CLLocationCoordinate2D) {
           let geocoder = GMSGeocoder()
           geocoder.reverseGeocodeCoordinate(coordinate) { [weak self] response, error in
               if let address = response?.firstResult() {
                   print(address)
                   let lines = address.lines?.joined(separator: "\n")
                   self?.locationAddressTextView.text = lines
                
                   self?.selectedAddress = address
                   UIView.animate(withDuration: 0.25, animations: {
                       self?.view.layoutIfNeeded()
                   })
               }
           }
       }
}

