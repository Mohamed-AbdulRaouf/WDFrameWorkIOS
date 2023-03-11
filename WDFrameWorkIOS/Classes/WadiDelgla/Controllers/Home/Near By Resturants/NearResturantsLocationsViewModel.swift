//
//  NearResturantsLocationsViewModel.swift
//  STDobites
//
//  Created by Nermeen Mohamed on 10/30/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
import ReactiveKit
//import DAL
//import BLL
import SVProgressHUD
protocol INearResturantsLocationsViewModel: IBaseViewModel {
    
    var apiClient: BrandServiceBLL? { get set }
    var onSuccessLoadLocations :  (() -> Void)? { get set }
    var onError: ((String) -> Void)? { get set }
    var openDirectionMap :  (() -> Void)? { get set }
    var brandLocations :[IBrandLocationDTODAL]? {get set}
    func getNearResturants()
    func getBrandLocationsByAreaId()
    var brandId: Int? {get set}
}
class NearResturantsLocationsViewModel: INearResturantsLocationsViewModel{
    var apiClient: BrandServiceBLL?
    var onSuccessLoadLocations: (() -> Void)?
    var onError: ((String) -> Void)?
    var openDirectionMap: (() -> Void)?
    var brandLocations: [IBrandLocationDTODAL]?
    var brandId: Int?
   
    public  init (apiClient: BrandServiceBLL){
        self.apiClient = apiClient
    }
    
    func getNearResturants() {
        self.showHud()
        doInBackground {
            self.apiClient?.getBranchsNearBy(LocationManager.sharedInstance.getLatitude(), LocationManager.sharedInstance.getLongitude(), completion: { (response) in
                doOnMain {
                    self.hideHUD()
                    guard let data = response?.data else {
                        if response?.error?.APIError != nil {
                            self.onError!(response?.error?.APIError?.description ?? "")
                        }
                        if response?.error?.networkError != nil {
                            self.onError!(response?.error?.networkError?.description ?? "")
                        }
                        return
                    }
                    self.brandLocations = data as? [IBrandLocationDTODAL]
                    self.onSuccessLoadLocations!()
                }
            })
            
        }
    }
    func getBrandLocationsByAreaId(){
        LocationManager.sharedInstance.runLocationBlock {
            doOnMain {
                self.showHud()
                doInBackground {
                    self.apiClient?.getBrandLocationsByAreaId(UserDefaults.currentArea?.id.value?.description ?? "0",brandId:"\(self.brandId!)") { (response) in
                        doOnMain {
                            self.hideHUD()
                            guard let data = response?.data else {
                                if response?.error?.APIError != nil {
                                    self.onError!(response?.error?.APIError?.description ?? "")
                                }
                                if response?.error?.networkError != nil {
                                    self.onError!(response?.error?.networkError?.description ?? "")
                                }
                                return
                            }
                            self.brandLocations?.removeAll()
                            if let arr = data as? [IBrandLocationDTODAL] {
                                self.brandLocations = arr
                                self.openDirectionMap!()
                            }
                        }
                    }
                }
            }
        }
    }
    
}
