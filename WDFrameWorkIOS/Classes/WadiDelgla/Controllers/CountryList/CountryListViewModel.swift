//
//  CountryListViewModel.swift
//  STDobites
//
//  Created by SimpleTouch on 11/10/20.
//  Copyright © 2020 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
import ReactiveKit
//import DAL
//import BLL
import SVProgressHUD

public protocol CountrySelectorDelegate:class {
    func selectCountry(country: ICountryDTODAL)
}

protocol ICountryListViewModel: IBaseViewModel {
    var apiClient: CountryServiceBLL? { get set }
    var countryList: [ICountryDTODAL]? {get set}
    var delegate: ICountryListViewController? {get set}
    var sourceDelegate: CountrySelectorDelegate? {get set}
    var brandId: Int? {get set}
    func viewDidLoad()
//    func getCountryList()
}
class CountryListViewModel: ICountryListViewModel{
    var apiClient: CountryServiceBLL?
    
    weak var delegate: ICountryListViewController?
    
    weak var sourceDelegate: CountrySelectorDelegate?
    
    var countryList: [ICountryDTODAL]?
    
    var brandId: Int?
    public  init (apiClient: CountryServiceBLL){
        self.apiClient = apiClient
    }
    
    
    func viewDidLoad(){
        self.countryList?.removeAll()
        guard let _ = sourceDelegate else { return }
        if let _ = brandId {
            self.getBrandCountryList()
        }else{
            self.getAllAvailableCountryList()
        }
    }
    
    func getAllAvailableCountryList() {
        guard K.shared.ALL_AVAILABLE_COUNTRY_LIST == nil else {
                   self.countryList = K.shared.ALL_AVAILABLE_COUNTRY_LIST
                   return
               }
               self.showHud()
               doInBackground {
                   self.apiClient?.getAllAvailableCountries(completion: { (response) in
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
                           K.shared.ALL_AVAILABLE_COUNTRY_LIST = data as? [CountryDTODAL]
                           self.countryList = K.shared.ALL_AVAILABLE_COUNTRY_LIST
                           self.delegate?.onReloadTableView()
                       }
                   })
               }
    }
    func getBrandCountryList() {
        guard K.shared.BRAND_COUNTRY_LIST == nil else {
            self.countryList = K.shared.BRAND_COUNTRY_LIST
            return
        }
        self.showHud()
        doInBackground {
            self.apiClient?.getBrandAvailableCountries(self.brandId!,completion: { (response) in
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
                    K.shared.BRAND_COUNTRY_LIST = data as? [CountryDTODAL]
                    self.countryList = K.shared.BRAND_COUNTRY_LIST
                    self.delegate?.onReloadTableView()
                }
            })
        }
    }
}
