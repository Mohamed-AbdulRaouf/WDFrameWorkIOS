//
//  ForgotPasswordVerifyCodeViewModel.swift
//  STDobites
//
//  Created by SimpleTouch on 10/16/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//


import Foundation
import Bond
import ReactiveKit

protocol IForgotPasswordVerifyCodeViewModel: IBaseViewModel{
    
    var verificationCodeModel : IAuthPhoneNumberDTODAL! {get set}
    var apiClient: UserServiceBLL { get set }
    var errorModel : IPhoneNumberValidationDTOBLL? {get set}
    func sendVerifyCode()
    func getUser()
    var delegate: IForgetPasswordViewController? {get set}
}
class ForgotPasswordVerifyCodeViewModel: IForgotPasswordVerifyCodeViewModel{
    weak var delegate: IForgetPasswordViewController?
    
    var verificationCodeModel: IAuthPhoneNumberDTODAL!
    
    var apiClient: UserServiceBLL
    
    var errorModel: IPhoneNumberValidationDTOBLL?
    
    
    public  init (verificationCodeModel : IAuthPhoneNumberDTODAL ,apiClient: UserServiceBLL,errorModel : IPhoneNumberValidationDTOBLL){
        self.verificationCodeModel = verificationCodeModel
        self.errorModel = errorModel
        self.apiClient = apiClient
    }
    /// This Function to send verification code for reset password
    func sendVerifyCode() {
        self.showHud()
        guard self.verificationCodeModel.mobile.value != Config.TestUserPhoneNumber else {
            doOnMain {
                self.hideHUD()
                self.delegate?.onSuccess(self.verificationCodeModel!)
            }
            return
        }
        doInBackground {
            self.apiClient.validateVerifificationCode(self.verificationCodeModel!, completion: { (response) in
                doOnMain {
                    self.hideHUD()
                    guard let _ = response?.data else {
                        self.delegate?.onUpdateLayout()
                        return
                    }
                    self.verifyPhoneNumber()
                }
            })
        }
    }
    func verifyPhoneNumber(){
        self.showHud()
        let phoneNumber = "\(self.verificationCodeModel.dialCode.value ?? "+2")\(self.verificationCodeModel.mobile.value ?? "")"
    }
    func getUser() {
        self.showHud()
        doInBackground {
            self.apiClient.getUser(self.verificationCodeModel.mobile.value ?? "",0, completion: { (response) in
                doOnMain {
                    self.hideHUD()
                    guard let _ = response?.data else {
                        self.errorModel = response?.error?.validateError as? IPhoneNumberValidationDTOBLL
                        self.delegate?.onUpdateLayout()
                        if response?.error?.APIError != nil {
                            self.delegate?.onError(response?.error?.APIError?.description ?? "")
                        }
                        return
                    }
                    self.sendVerifyCode()
                }
            })
        }
        
    }
}


