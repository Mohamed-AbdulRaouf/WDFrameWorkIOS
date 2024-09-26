//
//  VerificationCodeViewModel.swift
//  STDobites
//
//  Created by SimpleTouch on 10/23/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//
import Foundation
import Bond
import ReactiveKit

protocol IVerificationCodeViewModel: IBaseViewModel {
    var verificationCodeModel : IAuthPhoneNumberDTODAL! {get set}
    var apiClient: UserServiceBLL { get set }
    var errorModel : IVerificationCodeValidationDTOBLL {get set}
    func sendVerifyCode()
    func validateVerificationCode()
    func validateCustomer()
    var delegate: IVerificationCodeViewController? {get set}
}
class VerificationCodeViewModel: IVerificationCodeViewModel{
    
    weak var delegate: IVerificationCodeViewController?
    
    var verificationCodeModel: IAuthPhoneNumberDTODAL!
    
    var apiClient: UserServiceBLL
    
    var errorModel: IVerificationCodeValidationDTOBLL
    
    
    public  init (verificationCodeModel: IAuthPhoneNumberDTODAL ,apiClient: UserServiceBLL,errorModel : IVerificationCodeValidationDTOBLL){
        self.verificationCodeModel = verificationCodeModel
        self.errorModel = errorModel
        self.apiClient = apiClient
    }
    
    /// This Function to send verification code to user's phone number
    func sendVerifyCode() {
        self.showHud()
        guard self.verificationCodeModel.mobile.value != Config.TestUserPhoneNumber else {
            doOnMain {
                self.hideHUD()
            }
            return
        }
        doInBackground {
            self.apiClient.validateVerifificationCode(self.verificationCodeModel!, completion: { (response) in
                doOnMain {
                    self.hideHUD()
                    guard let _ = response?.data else {
                        
                        return
                    }
                    self.verifyPhoneNumber()
                    //                    self.delegate?.onSuccessCheckVerifyCode()
                }
            })
        }
    }
    
    func verifyPhoneNumber(){
        self.showHud()
        let phoneNumber = "\(self.verificationCodeModel.dialCode.value ?? "+2")\(self.verificationCodeModel.mobile.value ?? "")"
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
                        return
                    }
                    self.signIn()
                }
            })
        }
    }
    
    func signIn(){
        self.showHud()
    }
    func validateCustomer(){
        self.showHud()
        doInBackground {
            self.apiClient.validateCustomer(self.verificationCodeModel.mobile.value ?? "",self.verificationCodeModel.countryId.value ?? "", Config.BRAND_ID, completion: { (response) in
                doOnMain {
                    self.hideHUD()
                    guard let _ = response?.data else {
                        if response?.error?.APIError != nil {
                            self.delegate?.onError(response?.error?.APIError?.description ?? "")
                        }
                        return
                    }
                    self.delegate?.onSucessValidateCustomer()
                }
            })
        }
    }
}
