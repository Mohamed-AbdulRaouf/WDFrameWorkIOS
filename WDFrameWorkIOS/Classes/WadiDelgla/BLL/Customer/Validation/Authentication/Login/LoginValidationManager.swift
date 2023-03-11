//
//  LoginValidationManager.swift
//  BLL
//
//  Created by SimpleTouch on 10/9/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
////import DAL

public class LoginValidationManagerBLL : IUserValidationManagerBLL{
    
    
    
    
    public var errorViewModel: ILoginValidationDTOBLL?
    
    private var userPhoneNumberLength = 11
    private let minUserPasswordLength = 3
    private let maxUserPasswordLength = 10
    
   
    public required init(errorModel: ILoginValidationDTOBLL, hintNumber: String?) {
          self.errorViewModel = errorModel
        self.userPhoneNumberLength = hintNumber?.count ?? 11
    }
    public  func validate(model: ILoginDTODAL) -> Bool {
        var valid = true
        
        if !validateMobileNumber(string: model.mobile.value ?? ""){
            valid = false
        }
        if !validatePassword(string: model.password.value ?? ""){
            valid = false
        }
        return valid
    }
    
}
// Fields to be validated
extension LoginValidationManagerBLL : ILoginValidationManagerBLL { 
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
  
    //MARK: validate Password
    
    public func validatePassword(string: String) -> Bool
    {
        if string == "" || string.isEmpty {
            print(RBLL.string.localizable.empty_password())
            errorViewModel?.msgPasswordError.value = ValidationErrorBLL.ErrorMessages.msgEmptyPassword()
            return false
        }
        if string.withoutSpacesAndNewLines == "" || string.count < minUserPasswordLength || string.count > maxUserPasswordLength {
            errorViewModel?.msgPasswordError.value  = ValidationErrorBLL.ErrorMessages.msgInvalidPassword()
            return false
        }
        errorViewModel?.msgPasswordError.value = ""
        return true
    }
    public func testPass(string: String) -> ValidationResultBLL {
        if string == "" || string.isEmpty {
            print(RBLL.string.localizable.empty_password())
//            errorViewModel?.msgPasswordError.value = ValidationError.ErrorMessages.msgEmptyPassword()
            
            return .Invalid(ValidationErrorBLL.ErrorMessages.msgEmptyPassword())
        }
        if string.withoutSpacesAndNewLines == "" || string.count < minUserPasswordLength || string.count > maxUserPasswordLength {
//            errorViewModel?.msgPasswordError.value  = ValidationError.ErrorMessages.msgInvalidPassword()
            return .Invalid(ValidationErrorBLL.ErrorMessages.msgInvalidPassword())
        }
        errorViewModel?.msgPasswordError.value = ""
        return .Valid
    }
    
}
public enum ValidationResultBLL {
    case Valid
    case Invalid(String)
}
