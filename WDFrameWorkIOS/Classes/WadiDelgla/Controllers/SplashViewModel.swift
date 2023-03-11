//
//  SplashViewModel.swift
//  STDobites
//
//  Created by Nermeen Mohamed on 10/28/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
//import BLL
//import DAL
protocol ISplashViewController:ICommonFunc {
    func onPresentLocation()
    func onPresentCountryList()
    func onPresentQRCodeVC()
}

protocol ISplashViewModel: IBaseViewModel {
    
    //MARK: - Variables
    var user_login_data : ILoginDTODAL! {get set}
    var apiClient: UserServiceBLL {get set}
    var apiCountry: CountryServiceBLL {get set}
    var delegate: ISplashViewController? {get set}
    //MARK: - Functions
    func sendLoginRequest()
    func viewDidLoad()
    
}

class SplashViewModel: ISplashViewModel{
    //MARK: - Variables
    weak var delegate: ISplashViewController?
    var user_login_data: ILoginDTODAL!
    var apiClient: UserServiceBLL
    var apiCountry: CountryServiceBLL
    public  init (user_login_data : ILoginDTODAL ,apiClient: UserServiceBLL,apiCountry: CountryServiceBLL ){
        self.user_login_data = user_login_data
        self.apiClient = apiClient
        self.apiCountry = apiCountry
        
    }
    //MARK: - Functions
    
    /// This Function check if user login before so get token if not open location to select city and area
    func viewDidLoad(){
        if let enable = UserDefaults.enableShowQRCodeVC , enable {
            self.delegate?.onPresentQRCodeVC()
        }else{
            self.getAllAvialableCountryList()
            if let _ =  UserDefaults.user ,let login = UserDefaults.loginData {
                self.user_login_data = login
                self.sendLoginRequest()
            }else{
                self.getBrandCountryList()
            }
            
        }
       
    }
    /// This Function to call Login API
    func sendLoginRequest(){
        doInBackground {
            
            self.apiClient.login(self.user_login_data, nil) { (response) in
                doOnMain {
                    guard let model = response?.data else {
                        // there is a problem to login with this data
                        UserDefaults.user = nil
                        UserDefaults.loginData = nil
                        self.getBrandCountryList()
                        return
                    }
                    if let model = model as? UserDTODAL {
                        UserDefaults.loginData = self.user_login_data as? LoginDTODAL
                        UserDefaults.user = model
                    }
                    
                    self.updateMobileToken(UserDefaults.user?.userId.value ?? "")
                }
            }
        }
    }
    /// This Function to update Mobile App token after login
    ///
    /// - Parameter userId: user id
    func updateMobileToken(_ userId:String){
        doInBackground {
            self.apiClient.updateMobileToken(userId,Config.BRAND_ID) { (response) in
                doOnMain {
                    self.getBrandCountryList()
                }
            }
        }
    }
    func getBrandCountryList() {
        self.showHud()
        doInBackground {
            self.apiCountry.getBrandAvailableCountries(Config.BRAND_ID, completion: { (response) in
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
                    if let data = response?.data as? [CountryDTODAL] {
                        if  K.shared.BRAND_COUNTRY_LIST == nil{
                            K.shared.BRAND_COUNTRY_LIST = []
                        }
                        K.shared.BRAND_COUNTRY_LIST = data
                        self.openInitController()
                    }
                }
                
            })
        }
    }
    func getAllAvialableCountryList() {
        doInBackground {
            self.apiCountry.getAllAvailableCountries(completion: { (response) in
                if let data = response?.data as? [CountryDTODAL] {
                    if  K.shared.ALL_AVAILABLE_COUNTRY_LIST == nil{
                        K.shared.ALL_AVAILABLE_COUNTRY_LIST = []
                    }
                    K.shared.ALL_AVAILABLE_COUNTRY_LIST = data
                }
            })
        }
    }
    func openInitController() {
        guard  UserDefaults.currentAppCountry == nil else {
            self.delegate?.onPresentLocation()
            return
        }
        UserDefaults.currentAppCountry = K.shared.BRAND_COUNTRY_LIST![0]
        self.delegate?.onPresentLocation()

        /*
        guard  UserDefaults.currentAppCountry == nil else {
            self.delegate?.onPresentLocation()
            return
        }
        guard let countries = K.shared.BRAND_COUNTRY_LIST,countries.count > 1 else{
            UserDefaults.currentAppCountry = K.shared.BRAND_COUNTRY_LIST![0]
            self.delegate?.onPresentLocation()
            return
        }
        self.delegate?.onPresentCountryList()
 */
    }
}
