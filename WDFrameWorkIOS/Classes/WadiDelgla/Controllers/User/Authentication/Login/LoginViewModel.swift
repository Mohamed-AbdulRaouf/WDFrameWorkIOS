//
//  LoginViewModel.swift
//  STDobites
//
//  Created by SimpleTouch on 10/9/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
import ReactiveKit
//import DAL
//import BLL
//import RxCocoa
protocol ILoginViewModel: IBaseViewModel {
    
    var user_login_data : ILoginDTODAL! {get set}
    var user_data : IUserDTODAL! {get set}
    var country_data: ICountryDTODAL! {get set}
    var apiClient: UserServiceBLL {get set}
    var errorModel : ILoginValidationDTOBLL? {get set}
    func sendLoginRequest()
    var delegate: ILoginViewController? {get set}
}


class LoginViewModel: ILoginViewModel{
    weak var delegate: ILoginViewController?
    var errorModel : ILoginValidationDTOBLL?

    var user_login_data: ILoginDTODAL!
    var user_data: IUserDTODAL!
    var country_data: ICountryDTODAL!
    var apiClient: UserServiceBLL
    
    
    public  init (user_login_data : ILoginDTODAL, user_data: IUserDTODAL ,apiClient: UserServiceBLL,errorModel : ILoginValidationDTOBLL){
        self.user_data = user_data
        self.user_login_data = user_login_data
        self.errorModel = errorModel
        self.apiClient = apiClient
    }
 
    
    /// This Function to Login user with phone number and password
    func sendLoginRequest() {
        self.showHud()
        doInBackground {
            self.user_login_data.mobile.value = GlobalConstants.shared.mobile
            self.user_login_data.password.value = GlobalConstants.shared.password
            self.user_login_data.hintNumber.value = "01001234567"
            self.user_login_data.countryId.value = "12"
            self.user_login_data.dialCode.value = "+20"
            self.user_login_data.brandId.value = 0
            
            self.country_data.hintNumber.value = "01001234567"
//            self.user_login_data.countryId.value = "1"
//            self.country_data.hintNumber.value = "+2"
            
            self.apiClient.login(self.user_login_data,  self.country_data.hintNumber.value) { (response) in
                doOnMain {
                    self.hideHUD()
                    guard let model = response?.data else {
                        self.errorModel = response?.error?.validateError as? ILoginValidationDTOBLL
                        
                        self.delegate?.onUpdateLayout()
                        if response?.error?.APIError != nil {
                            
                            if response?.error?.ErrorCode! == ErrorsCodeBLL.notActiveAccount.rawValue {
                                self.delegate?.onAcctivateAccount()
                            }else{
                                 self.delegate?.onError(response?.error?.APIError?.description ?? "")
                            }
                           
                        }
                        
                        return
                    }
                    
//                    self.delegate?.onUpdateLayout()
                    if let model = model as? UserDTODAL {
                        self.user_login_data.hintNumber = self.country_data.hintNumber
                        UserDefaults.loginData = self.user_login_data as? LoginDTODAL
                         UserDefaults.user = model
                    }
                   
                    self.updateMobileToken(UserDefaults.user?.userId.value ?? "")
                }
            }
        }
    }
    /// This Function to update mobile token with firebase so can use firebase featrures
    ///
    /// - Parameter userId: user id
    func updateMobileToken(_ userId:String){
        self.showHud()
        doInBackground {
            self.apiClient.updateMobileToken(userId,Config.BRAND_ID) { (response) in
                doOnMain {
                    self.hideHUD()
                    self.delegate?.onSuccessLogin()
                }
                
            }
        }
    }
    
    
}
