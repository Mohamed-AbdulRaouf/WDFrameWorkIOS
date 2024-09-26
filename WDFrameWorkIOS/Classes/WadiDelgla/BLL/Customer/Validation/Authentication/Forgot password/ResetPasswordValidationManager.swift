//
//  ResetPasswordValidationManager.swift
//  BLL
//
//  Created by SimpleTouch on 10/16/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
////import DAL

public class ResetPasswordValidationManager : IValidationManagerBLL{
    
    
    public var errorViewModel: IResetPasswordValidationDTOBLL?
    
    private let minUserPasswordLength = 3
    private let maxUserPasswordLength = 10
    private let verificationCodeLength = 6

    required public init(errorModel: IResetPasswordValidationDTOBLL){
        self.errorViewModel = errorModel
    }
    
    public  func validate(model: IResetPasswordDTODAL) -> Bool {
        var valid = true
        
        if !validatePassword(string: model.password.value ?? ""){
            valid = false
        }
        if !validateConfirmPassword(password: model.password.value ?? "", newpassword: model.confirmPassword.value ?? ""){
            valid = false
        }
        return valid
    }
    
}
// Fields to be validated
extension ResetPasswordValidationManager : IResetPasswordValidationManagerBLL {

    //MARK: validate Password
    public func validatePassword(string: String) -> Bool {
        if string == "" {
            errorViewModel?.msgPasswordError.value  = ValidationErrorBLL.ErrorMessages.msgEmptyPassword()
            return false
        }
        if string.withoutSpacesAndNewLines == "" || string.count < minUserPasswordLength || string.count > maxUserPasswordLength {
            errorViewModel?.msgPasswordError.value  = ValidationErrorBLL.ErrorMessages.msgInvalidPasswordLength()
            return false
        }
        errorViewModel?.msgPasswordError.value = ""
        return true
    }
    //MARK: validate Confirm Password

    public func validateConfirmPassword(password: String,newpassword: String) -> Bool {
        if newpassword == "" {
            errorViewModel?.msgConfirmPassowrdError.value  = ValidationErrorBLL.ErrorMessages.msgEmptyPassword()
            return false
        }
        if password != newpassword{
            errorViewModel?.msgConfirmPassowrdError.value  = ValidationErrorBLL.ErrorMessages.msgNotMatchPasswords()
            return false
        }
        errorViewModel?.msgConfirmPassowrdError.value = ""
        return true
    }
}
