//
//  LocationViewModel.swift
//  STDobites
//
//  Created by SimpleTouch on 10/24/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation

protocol ILocationViewModel: IBaseViewModel {
    
    var apiClient: LocationServiceBLL? { get set }
    var cartService: CartServiceBLL? {get set}
    func getCitiesAndAreas()
    var currentCity: SearchItemDTOModelDAL? {get set}
    var currentArea: SearchItemDTOModelDAL? {get set}
    var delegate: ILocationViewController? {get set}
    
    func validateOnChangeLocation()
    func validateOnCartHasItems()
    func validateOnCartHasItemsForCountry(country: ICountryDTODAL)
    func checkCityName(_ cities: [CityDTODAL])
    func checkAreaName(_ cities: [CityDTODAL])
    
}

class LocationViewModel: ILocationViewModel{
    weak var delegate: ILocationViewController?
    var cartService: CartServiceBLL?
    var currentCity: SearchItemDTOModelDAL? {
        get{
            return UserDefaults.currentCity
        }
        set{
            UserDefaults.currentCity = newValue
        }
    }
    
    var currentArea: SearchItemDTOModelDAL?{
        get{
            return UserDefaults.currentArea
        }
        set{
            UserDefaults.currentArea = newValue
        }
    }
    
    
    var apiClient: LocationServiceBLL?
    
    
    var onUpdateUserSuccessfully : (() -> Void)?
    var oldCityId : String?
    var oldCountryId: String?
    
    
    public  init (apiClient: LocationServiceBLL,cartService: CartServiceBLL){
        self.apiClient = apiClient
        self.cartService = cartService
        self.oldCityId = UserDefaults.currentCity?.id.value
        self.oldCountryId = UserDefaults.currentArea?.id.value
    }
    
    func getCitiesAndAreas() {
        self.showHud()
        doInBackground {
            self.apiClient?.getCitiesAndAreas(withBrandId: Config.BRAND_ID,forLang: LocalizationSystem.sharedInstance.getLanguage()) { (response) in
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
    func checkCityName(_ cities: [CityDTODAL]) {
        if let _ = currentCity , let city =  cities.filter({$0.id.value ?? ""  == self.currentCity?.id.value ?? ""}).first{
            self.currentCity = city
            self.delegate?.reloadData()
        }
    }
    func checkAreaName(_ cities: [CityDTODAL]){
        if let _ = currentArea {
            let areas = cities.filter({$0.id.value ?? "" == self.currentCity?.id.value ?? ""}).first?.areas.value ?? [SearchItemDTOModelDAL]()
            self.currentArea = areas.filter({$0.id.value ?? "" == self.currentArea?.id.value ?? ""}).first ?? SearchItemDTOModelDAL()
            self.delegate?.reloadData()
        }
    }
    
    func validateOnChangeLocation(){
        guard let currentCity = currentCity , let currentArea = currentArea else{
            self.delegate?.onError("select_city_and_area_msg".localized())
            return
        }
        if let order = UserDefaults.order, let oldCityId = oldCityId, let oldCountryId = UserDefaults.currentArea?.id.value {
            if oldCityId != currentCity.id.value ?? "" || oldCountryId != "\(Int(order.selectedAreaId))" {
                self.delegate?.onShowClearCartAlert()
                return
            }
        }
        self.delegate?.openHome()
    }
    func validateOnCartHasItems(){
        guard  cartService?.getCart() == nil else{
            self.delegate?.onShowClearCartByChangingLanguage()
            return
        }
        changeLanguage()
    }
    func validateOnCartHasItemsForCountry(country: ICountryDTODAL) {
        guard  cartService?.getCart() == nil else{
            self.delegate?.onShowClearCartAlert(messageText: "clear_cart_due_to_change_country".localized(), actionButtonText: "clear_cart".localized(), actionButtonClosure: {
                self.cartService?.deleteCart(completion: { (success) in
                    if success {
                        changeCountry(withCountry: country)
                    }
                })
            })
            return
        }
        changeCountry(withCountry: country)
    }
}
