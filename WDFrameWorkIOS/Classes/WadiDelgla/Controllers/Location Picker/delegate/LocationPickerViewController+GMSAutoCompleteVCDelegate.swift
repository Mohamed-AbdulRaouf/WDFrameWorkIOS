//
//  LocationPickerViewController+GMSAutoCompleteVCDelegate.swift
//  SimpleTouch
//
//  Created by SimpleTouch on 10/4/20.
//  Copyright © 2020 SimpleTouch. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
//MARK: - GMSAutocompleteViewControllerDelegate Protocol
extension LocationPickerViewController: GMSAutocompleteViewControllerDelegate {
    
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        print("place name: \(String(describing: place.name))")
        dismiss(animated: true, completion: nil)
        self.reverseGeocodeCoordinate(coordinate: place.coordinate)
        self.locationMapView.clear()
//        self.locationSearchTextField.text = place.name
        
       
        let cord2D = CLLocationCoordinate2D(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
        
        plotMarker(AtCoordinate: cord2D, onMapView: self.locationMapView,withSnippet: place.name)
        
        self.locationMapView.camera = GMSCameraPosition.camera(withTarget: cord2D, zoom: 18.0)
        
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print(error.localizedDescription)
    }
   
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
}
