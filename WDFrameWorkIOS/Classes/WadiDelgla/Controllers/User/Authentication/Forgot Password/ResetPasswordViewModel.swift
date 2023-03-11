//
//  ResetPasswordViewModel.swift
//  STDobites
//
//  Created by SimpleTouch on 10/16/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//


import Foundation
import Bond
import ReactiveKit
//import DAL
//import BLL
//import STFirebaseSDK
protocol IResetPasswordViewModel: IBaseViewModel {
    
    var newPasswordModel : IResetPasswordDTODAL! {get set}
    var verificationCodeModel : IAuthPhoneNumberDTODAL! {get set}
    var apiClient: UserServiceBLL { get set }
    var errorModel : IResetPasswordValidationDTOBLL {get set}
    var onTimeOut : (() -> Void)? { get set }
    func changePassword()
    func sendVerifyCode()
    var delegate: IResetPasswordViewController? {get set}
    func validateVerificationCode()
    func checkResetPasswordDTO()
}
class ResetPasswordViewModel: IResetPasswordViewModel{
    weak var delegate: IResetPasswordViewController?
    
    var newPasswordModel: IResetPasswordDTODAL!
    
    var verificationCodeModel: IAuthPhoneNumberDTODAL!
    
    var apiClient: UserServiceBLL
    
    var errorModel: IResetPasswordValidationDTOBLL
    
    
    var onTimeOut: (() -> Void)?
    
    
    public  init (newPasswordModel : IResetPasswordDTODAL ,verificationCodeModel: IVerificationCodeDTODAL ,apiClient: UserServiceBLL,errorModel : IResetPasswordValidationDTOBLL){
        self.newPasswordModel = newPasswordModel
        self.newPasswordModel.mobile = verificationCodeModel.mobile
        self.newPasswordModel.brandId.value = 0
        self.errorModel = errorModel
        self.apiClient = apiClient
        
    }
    
    /// This Function to reset password if user forgot it
    func changePassword() {
        self.showHud()
        self.newPasswordModel.mobile = self.verificationCodeModel.mobile
        self.newPasswordModel.countryId = self.verificationCodeModel.countryId
        doInBackground {
            self.apiClient.resetPassword(self.newPasswordModel, completion: { (response) in
                doOnMain {
                    self.hideHUD()
                    guard let _ = response?.data else {
                        self.errorModel = response?.error?.validateError as! IResetPasswordValidationDTOBLL
                        self.delegate?.onUpdateLayout()
                        if response?.error?.APIError != nil {
                            self.delegate?.onError(response?.error?.APIError?.description ?? "")
                        }
                        
                        return
                    }
                    self.delegate?.onUpdateLayout()
                    self.delegate?.onSuccessUpdatePassword()
                }
                
            })
        }
    }
    
    /// This Function to send verify code
    func sendVerifyCode() {
        self.showHud()
        if self.verificationCodeModel.mobile.value == Config.TestUserPhoneNumber {
            doOnMain {
                self.hideHUD()
                return
            }
            
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
//        doInBackground {
//            STFirebaseLib.verifyPhoneNumber(withPhoneNumber: phoneNumber, withLang: K.shared.APP_LANGUAGE) { (verificationID, error) in
//                doOnMain {
//                    self.hideHUD()
//                    guard let _ = verificationID else {
//                        if error != nil {
//                            self.delegate?.onError(error ?? "")
//                        }
//                        return
//                    }
//                    self.verificationCodeModel.verificationId.value = verificationID
//                    self.delegate?.onSuccessSendVerifyCode()
//                }
//            }
//        }
    }
    /// This Function to verify verification code that user entered
    func validateVerificationCode() {
        self.showHud()
        guard self.verificationCodeModel.mobile.value != Config.TestUserPhoneNumber else {
            doOnMain {
                self.hideHUD()
                if self.verificationCodeModel.verificationCode.value != Config.TestVerifyCode{
                    self.delegate?.onError("Invalid Verification Code")
                    return
                }
                self.delegate?.onSuccessCheckVerifyCode()
                
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
                    self.signIn()
                    //                    self.delegate?.onSuccessCheckVerifyCode()
                }
            })
        }
    }
    func signIn(){
        self.showHud()
//        STFirebaseLib.signIn(withVerificationID: self.verificationCodeModel!.verificationId.value ?? "", verificationCode:  self.verificationCodeModel!.verificationCode.value ?? "", withLang: K.shared.APP_LANGUAGE) { (success, error) in
//            self.hideHUD()
//            guard let _ = success else{
//                if error != nil {
//                    self.delegate?.onError(error ?? "")
//                    return
//                }
//                return
//            }
//            self.delegate?.onSuccessCheckVerifyCode()
//        }
    }
    func checkResetPasswordDTO() {
        self.showHud()
        self.newPasswordModel.mobile = self.verificationCodeModel.mobile
        doInBackground {
            self.apiClient.checkValidatePasswordDTO(self.newPasswordModel!, completion: { (response) in
                doOnMain {
                    self.hideHUD()
                    guard let _ = response?.data else {
                        self.errorModel = response?.error?.validateError as! IResetPasswordValidationDTOBLL
                        self.delegate?.onUpdateLayout()
                        if response?.error?.APIError != nil {
                            self.delegate?.onError(response?.error?.APIError?.description ?? "")
                        }
                        return
                    }
                    self.validateVerificationCode()
                }
            })
        }
    }
}


