//
//  AddNewUserAddressViewModel.swift
//  STDobites
//
//  Created by Nermeen Mohamed on 11/3/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import SVProgressHUD
protocol  IAddNewUserAddressViewModel: IBaseViewModel {
    
    var address_data : IUserAddressDTODAL? {get set}
    var apiClient: UserServiceBLL? { get set }
    var errorModel : IAddressValidationDTOBLL? {get set}
    func updateAddress(completion: @escaping ((Bool) -> Void))
    func addAddress(completion: @escaping ((Bool) -> Void))
    func viewDidLoad()
    func onSaveTapped()
    func validateCityAndArea(completion: @escaping ((Bool) -> Void))
    var delegate: IAddNewUserAddressViewController? {get set}
    
    var apiLocation : LocationServiceBLL? { get set }
    func getCitiesAndAreas()
    var currentCity: SearchItemDTOModelDAL? {get set}
    var currentArea: SearchItemDTOModelDAL? {get set}
    var isFromCart: Bool? {get set}
}
class AddNewUserAddressViewModel: IAddNewUserAddressViewModel{
    var apiLocation: LocationServiceBLL?
    
    var currentCity: SearchItemDTOModelDAL?
       
    var currentArea: SearchItemDTOModelDAL?
    
    var isFromCart: Bool?
    
    weak var delegate: IAddNewUserAddressViewController?
    var address_data: IUserAddressDTODAL?
    var apiClient: UserServiceBLL?
    var errorModel : IAddressValidationDTOBLL?
    public  init (address_data : IUserAddressDTODAL ,apiClient: UserServiceBLL,apiLocation:LocationServiceBLL,errorModel : IAddressValidationDTOBLL){
        self.address_data = address_data
        self.errorModel = errorModel
        self.apiClient = apiClient
        self.apiLocation = apiLocation
       
    }
    func viewDidLoad(){
        if address_data?.id.value == nil{
            //new address
            self.currentCity = UserDefaults.currentCity
            self.currentArea = UserDefaults.currentArea
        }
        self.getCitiesAndAreas()
    }
    /// This Function to get cities and areas
    func getCitiesAndAreas() {
        self.showHud()
        doInBackground {
            self.apiLocation?.getCitiesAndAreas(withBrandId:0,forLang: LocalizationSystem.sharedInstance.getLanguage()) { (response) in
                doOnMain {
                    self.hideHUD()
                    guard let data = response?.data else {
                        if response?.error?.APIError != nil {
                            self.delegate?.onError(response?.error?.APIError?.description ?? "")
                        }
                        if response?.error?.networkError != nil {
                            self.delegate?.onError(response?.error?.networkError?.description ?? "")
                        }
                        return
                    }
                    self.delegate?.onSuccessLoadCitiesAndAreas(data as! [CityDTODAL])
                }
            }
        }
        
    }
    /// This Function to update user address
    ///
    /// - Parameter completion: it returns if user address updated or not
    func updateAddress(completion: @escaping ((Bool) -> Void)) {
        self.validateCityAndArea { (success) in
            guard success else {
                completion(false)
                return
            }
            self.showHud()
            doInBackground {
                self.apiClient?.updateCustomerAddress(self.address_data!) { (response) in
                    doOnMain {
                        self.hideHUD()
                        guard let _ = response?.data else {
                            self.errorModel = response?.error?.validateError as? IAddressValidationDTOBLL
                            self.delegate?.onUpdateLayout()
                            if response?.error?.APIError != nil {
                                self.delegate?.onError(response?.error?.APIError?.description ?? "")
                            }
                            return
                        }
                        self.delegate?.successUpdateUserAddress()
                    }
                }
            }
        }
       
    }
    /// This Function to add new address
    ///
    /// - Parameter completion: it returns if new user address added or not
    func addAddress(completion: @escaping ((Bool) -> Void)) {
        self.validateCityAndArea { (success) in
            guard success else {
                completion(false)
                return
            }
            self.showHud()
            self.address_data?.brandId.value = 0
            self.address_data?.streetName.value = "ST"
            self.address_data?.addressDescription.value = "ST"
            self.address_data?.buildingNo.value = "1"
            self.address_data?.floorNo.value = "1"
            self.address_data?.addressDescription.value = "ST"
            self.address_data?.addressDetailsText = ""
            self.address_data?.cityName.value = ""
            self.address_data?.companyName.value = "Wadi Degla"
            self.address_data?.latitude.value = 0.0
            self.address_data?.longitude.value = 0.0
            doInBackground {
                self.apiClient?.addCustomerAddress(self.address_data!) { (response) in
                    doOnMain {
                        self.hideHUD()
                        self.delegate?.successAddNewAddress()
                    }
                }
            }
        }
       
    }
    /// This Function check if user select city and area to continue
    ///
    /// - Parameter completion: if user not select city and area it will return error message
    func validateCityAndArea(completion: @escaping ((Bool) -> Void)){
        guard let _ = currentCity , let _ = currentArea else{
            self.delegate?.onError("select_city_and_area_msg".localized())
            completion(false)
            return
        }
        self.address_data?.cityId.value = Int(currentCity?.id.value?.description ?? "")
        self.address_data?.areaId.value = Int(currentArea?.id.value?.description ?? "")
        completion(true)
    }
    func onSaveTapped() {
        self.showHud()
        if self.address_data?.id.value != nil && self.address_data?.id.value != 0  {
            self.updateAddress { (_) in
                self.hideHUD()
            }
        }else{
            self.addAddress { (_) in
                self.hideHUD()
            }
        }
    }
    
}

