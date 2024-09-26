//
//  NearResturantsLocationsViewController.swift
//  STDobites
//
//  Created by Nermeen Mohamed on 10/30/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
class NearResturantsLocationsViewController: MapController ,IBaseController{
    
    // MARK: - Properties
    typealias T = INearResturantsLocationsViewModel
    var viewModel: INearResturantsLocationsViewModel?

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        //bind UI
        self.bindingData()
        self.navigationItem.title =  viewModel?.brandId == nil ?  R.string.localizable.brand_location() : R.string.localizable.brand_location()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //get nearest Resturants for specific Brand
        guard let _ =  viewModel?.brandId else{
            viewModel?.getNearResturants()
            return
        }
        
        // get brands locations in specific area
        viewModel?.getBrandLocationsByAreaId()
    }
}

// MARK: - Internal
extension NearResturantsLocationsViewController{
    func bindingData() {
        if let viewModel = viewModel{
            viewModel.onSuccessLoadLocations = {  [weak self]  in
                self?.dropPins(viewModel.brandLocations!)
                self?.zoomtoLocation()
            }
            viewModel.onError = { [weak self] error in
                self?.showMessage(andMessage: error)
            }
            viewModel.openDirectionMap = {  [weak self]  in
                guard self?.viewModel?.brandLocations?.count ?? 0 > 0 else {return}
                // apple map
                self?.dropPins(viewModel.brandLocations!)
                self?.zoomtoLocation()
                //google map
                if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!))
                {
                    UIApplication.shared.openURL(NSURL(string:
                    "comgooglemaps://?saddr=&daddr=\(Float(self?.viewModel?.brandLocations?[0].latitude.value ?? 0)),\(Float(self?.viewModel?.brandLocations?[0].longitude.value ?? 0))&directionsmode=driving")! as URL)
                } else
                {
                    NSLog("Can't use com.google.maps://");
                }

            }
        }
    }
}
