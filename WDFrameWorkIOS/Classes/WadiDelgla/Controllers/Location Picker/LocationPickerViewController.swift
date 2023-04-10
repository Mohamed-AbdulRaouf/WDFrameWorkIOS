//
//  LocationPickerViewController.swift
//  SimpleTouch
//
//  Created by SimpleTouch on 10/4/20.
//  Copyright © 2020 SimpleTouch. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import CoreLocation
//import DAL
// MARK: - IBOUTLETS - Variables
class LocationPickerViewController: UIViewController {
    
    // MARK: - IBOUTLETS
    @IBOutlet weak var locationConfirmAddressButton: UIButton!
    @IBOutlet weak var locationSkip: UIButton!
    @IBOutlet weak var locationAddressTextView: UITextView!
    @IBOutlet weak var locationSearchTextField: UITextField!
    @IBOutlet weak var locationMapView: GMSMapView!
    
    // MARK: - VARIABLES
    let locationManager = CLLocationManager()
    var initalLocation =  CLLocationCoordinate2D(latitude: 0, longitude: 0) // user location by default
    var pinMarker =  GMSMarker()
    var selectedAddress : GMSAddress?
    var selectAddressManually : (() -> Void)?
    var mapAddress : ((UserAddressDTODAL) -> Void)?
}
//MARK: - View Life Cycle
extension LocationPickerViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
    }
}
// MARK: - Internal
extension LocationPickerViewController {
    func setupUI(){
        
        self.navigationItem.title = "check_address_search".localized()
        self.title = "check_address_search".localized()
        self.locationConfirmAddressButton.setTitle("next".localized(), for: .normal)
        self.locationConfirmAddressButton.cornerRadius = 10.0
        
        self.locationSkip.setTitle("select_manually".localized(), for: .normal)
        self.locationSkip.setTitleColor(.black, for: .normal)
        
        if let currentLocation = locationManager.location?.coordinate {
            self.initalLocation = currentLocation
        }
        
        //Location Manager code to fetch current location
        self.locationManager.delegate = self
        self.locationMapView.delegate = self
        
        //GOOGLE MAPS SKD: COMPASS
        locationMapView.settings.compassButton = false
        
        //GOOGLE MAPS SDK: USER'S LOCATION
        locationMapView.isMyLocationEnabled = true
        locationMapView.settings.myLocationButton = true
        let padding = LocalizationSystem.sharedInstance.isCurrentLanguageArabic() ? UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 0) : UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 10)
        locationMapView.padding = padding
        
        self.getUserAAddressccessPermision()
        self.setupCamera()
    }
}
//MARK: - IBAction
extension LocationPickerViewController {
    @IBAction func onSkipTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true, {
            self.selectAddressManually!()
        })
    }
    
    @IBAction func onConfirmAddressTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true, {
            let address = UserAddressDTODAL(country: self.selectedAddress?.country ?? "", city: self.selectedAddress?.locality ?? "", area: self.selectedAddress?.administrativeArea ?? "", street: self.selectedAddress?.thoroughfare ?? "",lat: self.selectedAddress?.coordinate.latitude ?? 0.0,long: self.selectedAddress?.coordinate.longitude ?? 0.0)
            self.mapAddress!(address)
        })
    }
    
    @IBAction func onPinTapped(_ sender: Any) {
    }
    
    @IBAction func onCurrentLocationTapped(_ sender: Any) {
        setupCamera()
    }
    @IBAction func onLocationTapped(_ sender: Any) {
        goToPlaces()
    }
}
//MARK: - Functions
extension LocationPickerViewController {
    func plotMarker(AtCoordinate coordinate : CLLocationCoordinate2D, onMapView vwMap : GMSMapView,withSnippet snippet: String? = "") {
        self.pinMarker = GMSMarker(position: coordinate)
        let image = UIImage(named:"destinationmarker")
        self.pinMarker.title = "Location"
        self.pinMarker.snippet = snippet
        self.pinMarker.icon = image
        self.pinMarker.map = vwMap
        self.pinMarker.appearAnimation = GMSMarkerAnimation.pop
        
        
        
        //        let markerImage = R.image.ic_offer_pickup()
        //        let markerView = UIImageView(image: markerImage)
        //        pinMarker?.iconView = markerView
        //        pinMarker?.map = self.locationMapView
        
    }
    func getUserAAddressccessPermision(){
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    func setupCamera(){
        let camera = GMSCameraPosition.camera(withLatitude:initalLocation.latitude,longitude: initalLocation.longitude, zoom: 16.0)
        locationMapView.camera = camera
        DispatchQueue.main.async
            {
                self.locationMapView.clear() // clearing Pin before adding new
                self.plotMarker(AtCoordinate: self.initalLocation, onMapView: self.locationMapView)
        }
        self.reverseGeocodeCoordinate(coordinate: self.initalLocation)
        self.locationManager.startUpdatingLocation()
        
    }
    
    func goToPlaces(){
        locationAddressTextView.resignFirstResponder()
        let acController = GMSAutocompleteViewController()
        acController.delegate = self
        present(acController, animated: true, completion: nil)
        
    }
}
