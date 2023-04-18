//
//  RegisterViewModel.swift
//  STMVVM
//
//  Created by SimpleTouch on 9/29/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
import ReactiveKit
//import DAL
//import BLL
import SVProgressHUD
protocol IRegisterViewModel: IBaseViewModel {
    
    var user_data : IRegisterDTODAL? {get set}
    var country_data: ICountryDTODAL? {get set}
    var apiClient: UserServiceBLL? { get set }
    var errorModel : IRegisterValidationDTOBLL? {get set}
    func register()
    var delegate: IRegisterViewController? {get set}
    func validateCustomer()

}
class RegisterViewModel: IRegisterViewModel{
     weak var delegate: IRegisterViewController?
     var user_data: IRegisterDTODAL?
    var country_data: ICountryDTODAL?
     var apiClient: UserServiceBLL?
     var errorModel : IRegisterValidationDTOBLL?
    public  init (user_data : IRegisterDTODAL ,apiClient: UserServiceBLL,errorModel : IRegisterValidationDTOBLL){
        self.user_data = user_data
        self.errorModel = errorModel
        self.apiClient = apiClient
//        self.country_data = country_data
    }
    
    /// This Function to call register API with registeration data
    func register() {
        self.user_data?.mobile.value = GlobalConstants.shared.mobile.getPhoneNumberOnlyWithCountry
        self.user_data?.membershipNumber.value = GlobalConstants.shared.membershipNumber
        self.user_data?.firstName.value = GlobalConstants.shared.firstName
        self.user_data?.lastName.value = GlobalConstants.shared.lastName
        self.user_data?.email.value = GlobalConstants.shared.email
        self.user_data?.gender.value = Gender.male.rawValue
        self.user_data?.password.value = GlobalConstants.shared.password
        self.user_data?.confirmPassword.value = GlobalConstants.shared.password
        self.user_data?.brandId.value = 0
        self.showHud()
        doInBackground {
            self.apiClient?.register(self.user_data!, hintNumber: self.country_data!.hintNumber.value) { (response) in
                doOnMain {
                    self.validateCustomer()
//                    self.hideHUD()
//                    guard let _ = response?.data else {
//                        self.errorModel = response?.error?.validateError as? IRegisterValidationDTOBLL
////                        self.delegate?.onUpdateLayout()
//                        if response?.error?.APIError != nil {
////                            self.delegate?.onError(response?.error?.APIError?.description ?? "")
//                        }
//                        return
//                    }
//                    self.delegate?.successfullyRegister()
                }
            }
        }
    }
    
    func validateCustomer() {
//        self.showHud()
//        doInBackground {
        self.apiClient?.validateCustomer(GlobalConstants.shared.mobile.getPhoneNumberOnlyWithCountry, "12", 0) { (response) in
                doOnMain {
                    self.hideHUD()
                    self.delegate?.successfullyRegister()
                }
            }
//        }
    }
}
