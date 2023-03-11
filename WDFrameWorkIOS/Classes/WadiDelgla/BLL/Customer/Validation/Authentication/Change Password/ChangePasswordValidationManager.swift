//
//  ChangePasswordValidationManager.swift
//  BLL
//
//  Created by SimpleTouch on 10/21/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
////import DAL

public class ChangePasswordValidationManagerBLL : IValidationManagerBLL{
    
    
    public var errorViewModel: IChangePasswordValidationDTOBLL?
    
    private let minUserPasswordLength = 3
    private let maxUserPasswordLength = 10
 
    required public init(errorModel: IChangePasswordValidationDTOBLL){
        self.errorViewModel = errorModel
    }
    
    public  func validate(model: INewPasswordDTODAL) -> Bool {
        var valid = true
        if !validateOldPassword(string: model.oldPassword.value ?? "", currentPassowrd: model.currentPassword.value ?? ""){
            valid = false
        }
        if !validateNewPassword(string: model.newPassword.value ?? ""){
            valid = false
        }
        
        if !validateConfirmPassword(password: model.newPassword.value ?? "", newpassword: model.confirmPassword.value ?? ""){
            valid = false
        }
        
        return valid
    }
    
}
// Fields to be validated
extension ChangePasswordValidationManagerBLL : IChangePasswordValidationManagerBLL {
   
    
    
    //MARK: validate First Name
    public func validateOldPassword(string: String,currentPassowrd currentPassword: String) -> Bool {
        if string == "" {
            errorViewModel?.msgOldPasswordError.value  = ValidationErrorBLL.ErrorMessages.msgEmptyPassword()
            return false
        }
        if string.withoutSpacesAndNewLines == "" || string.count < minUserPasswordLength || string.count > maxUserPasswordLength {
            errorViewModel?.msgOldPasswordError.value  = ValidationErrorBLL.ErrorMessages.msgInvalidPasswordLength()
            return false
        }
        if string != currentPassword {
            errorViewModel?.msgOldPasswordError.value  = ValidationErrorBLL.ErrorMessages.msgNotMatchPasswordWithCurrent()
            return false
        }
        errorViewModel?.msgOldPasswordError.value = ""
        return true
    }
    //MARK: validate Last Name
    
    public func validateNewPassword(string: String) -> Bool {
        if string == "" {
            errorViewModel?.msgNewPasswordError.value  = ValidationErrorBLL.ErrorMessages.msgEmptyPassword()
            return false
        }
        if string.withoutSpacesAndNewLines == "" || string.count < minUserPasswordLength || string.count > maxUserPasswordLength {
            errorViewModel?.msgNewPasswordError.value  = ValidationErrorBLL.ErrorMessages.msgInvalidPasswordLength()
            return false
        }
        errorViewModel?.msgNewPasswordError.value = ""
        return true
    }
    
   
    public func validateConfirmPassword(password: String, newpassword: String) -> Bool {
        if newpassword == "" {
            errorViewModel?.msgConfirmPasswordError.value  = ValidationErrorBLL.ErrorMessages.msgEmptyPassword()
            return false
        }
        if password != newpassword{
            errorViewModel?.msgConfirmPasswordError.value  = ValidationErrorBLL.ErrorMessages.msgNotMatchPasswords()
            return false
        }
        errorViewModel?.msgConfirmPasswordError.value = ""
        return true
    }
}
