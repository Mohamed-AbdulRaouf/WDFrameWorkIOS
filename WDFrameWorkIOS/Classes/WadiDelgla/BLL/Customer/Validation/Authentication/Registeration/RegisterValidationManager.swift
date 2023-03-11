//
//  ValidationManager.swift
//  BLL
//
//  Created by SimpleTouch on 10/1/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
////import DAL

public class RegisterValidationManagerBLL : IUserValidationManagerBLL{
  
    
    public var errorViewModel: IRegisterValidationDTOBLL?
    private var userPhoneNumberLength = 11
    private let minUserPasswordLength = 3
    private let maxUserPasswordLength = 10
    private let minUserNameLength = 2

    required public init(errorModel: IRegisterValidationDTOBLL){
        self.errorViewModel = errorModel
    }
    public required init(errorModel: IRegisterValidationDTOBLL, hintNumber: String?) {
        self.errorViewModel = errorModel
        self.userPhoneNumberLength = hintNumber?.count ?? 11
    }
    
     public  func validate(model: IRegisterDTODAL) -> Bool {
        var valid = true
        
        if !validateMobileNumber(string: model.mobile.value ?? ""){
            valid = false
        }
        if !validateFirstNameString(string: model.firstName.value ?? ""){
            valid = false
        }
        if !validateLastNameString(string: model.lastName.value ?? ""){
            valid = false
        }
        if !validateEmailId(string: model.email.value ?? ""){
            valid = false
        }
        if !validatePassword(string: model.password.value ?? ""){
            valid = false
        }
        if !validateConfirmPassword(password: model.password.value ?? "", confirmedPassword: model.confirmPassword.value ?? ""){
            valid = false
        }
        return valid
    }
   
}
// Fields to be validated
extension RegisterValidationManagerBLL : IRegisterValidationManagerBLL {
  
    
    //MARK: validate Mobile number
    
    public func validateMobileNumber(string: String) -> Bool
    {
        //        var validationError :String? = nil
        if string == "" {
            errorViewModel?.msgPhoneNumberError.value  = ValidationErrorBLL.ErrorMessages.msgEmptyMobileNo()
            return false
        }
        if string.withoutSpacesAndNewLines == "" || string.count != userPhoneNumberLength || !string.isDigits {
            errorViewModel?.msgPhoneNumberError.value  = ValidationErrorBLL.ErrorMessages.msgInvalidMobileNo()
            return false
        }
        errorViewModel?.msgPhoneNumberError.value = ""
        return true
    }
    //MARK: validate First name
    
    public func validateFirstNameString(string: String) -> Bool
    {
        if string == "" {
            errorViewModel?.msgFirstNAmeError.value =  ValidationErrorBLL.ErrorMessages.msgEmptyName()
            return false
        }
        if string.withoutSpacesAndNewLines == "" || string.count < minUserNameLength {
            errorViewModel?.msgFirstNAmeError.value  =  ValidationErrorBLL.ErrorMessages.msgInvalidName()
            return false
        }
        errorViewModel?.msgFirstNAmeError.value = ""
        return true
    }
    //MARK: validate Last name
    
   public func validateLastNameString(string: String) -> Bool
    {
        if string == "" {
            errorViewModel?.msgLastNameError.value =  ValidationErrorBLL.ErrorMessages.msgEmptyName()
            return false
        }
        if string.withoutSpacesAndNewLines == "" || string.count < minUserNameLength {
            errorViewModel?.msgLastNameError.value  =  ValidationErrorBLL.ErrorMessages.msgInvalidLastName()
            return false
        }
        errorViewModel?.msgLastNameError.value = ""
        return true
    }
    
    //MARK: validate Email
    
   public func validateEmailId(string: String) -> Bool
    {
        if string.withoutSpacesAndNewLines != ""{
            if !string.isValidEmail() {
                errorViewModel?.msgEmailError.value  = ValidationErrorBLL.ErrorMessages.msgInvalidEmail()
                return false
            }
        }
       
        errorViewModel?.msgEmailError.value = ""
        return true
    }
    //MARK: validate Password
    
   public func validatePassword(string: String) -> Bool
    {
        if string == "" || string.isEmpty {
            errorViewModel?.msgPasswordError.value = ValidationErrorBLL.ErrorMessages.msgEmptyPassword()
            return false
        }
        if string.withoutSpacesAndNewLines == "" || string.count < minUserPasswordLength || string.count > maxUserPasswordLength{
            errorViewModel?.msgPasswordError.value  = ValidationErrorBLL.ErrorMessages.msgInvalidPasswordLength()
            return false
        }
        errorViewModel?.msgPasswordError.value = ""
        return true
    }
    
     public func validateConfirmPassword(password: String, confirmedPassword: String) -> Bool {
         if confirmedPassword == "" {
             errorViewModel?.msgConfirmPasswordError.value  = ValidationErrorBLL.ErrorMessages.msgEmptyPassword()
             return false
         }
         if password != confirmedPassword{
             errorViewModel?.msgConfirmPasswordError.value  = ValidationErrorBLL.ErrorMessages.msgNotMatchPasswords()
             return false
         }
         errorViewModel?.msgConfirmPasswordError.value = ""
         return true
     }
}
