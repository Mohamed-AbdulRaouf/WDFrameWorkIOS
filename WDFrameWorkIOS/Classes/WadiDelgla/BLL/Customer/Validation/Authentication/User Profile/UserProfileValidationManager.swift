//
//  UserProfileValidationManager.swift
//  BLL
//
//  Created by SimpleTouch on 10/21/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
////import DAL

public class UserProfileValidationManagerBLL : IValidationManagerBLL{
    
    
    public var errorViewModel: IUserProfileValidationDTOBLL?
    

    private let minUserNameLength = 2
    

    required public init(errorModel: IUserProfileValidationDTOBLL){
        self.errorViewModel = errorModel
    }
    
    public  func validate(model: IUserDTODAL) -> Bool {
        var valid = true
        
        if !validateFirstName(string: model.firstName.value ?? ""){
            valid = false
        }
        if !validateLastName(string: model.lastName.value ?? ""){
            valid = false
        }
        if !validateEmail(string: model.email.value ?? ""){
            valid = false
        }
       
        return valid
    }
    
}
// Fields to be validated
extension UserProfileValidationManagerBLL : IUserProfileValidationManagerBLL {
   
    //MARK: validate First Name
    public func validateFirstName(string: String) -> Bool {
        if string == "" {
            errorViewModel?.msgFirstNameError.value =  ValidationErrorBLL.ErrorMessages.msgEmptyName()
            return false
        }
        if string.withoutSpacesAndNewLines == "" || string.count < minUserNameLength {
            errorViewModel?.msgFirstNameError.value  =  ValidationErrorBLL.ErrorMessages.msgInvalidName()
            return false
        }
        errorViewModel?.msgFirstNameError.value = ""
        return true
    }
    //MARK: validate Last Name

    public func validateLastName(string: String) -> Bool {
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
   
    //MARK: validate Mobile number
    
    public func validateEmail(string: String) -> Bool
    {
        //        var validationError :String? = nil
        guard  string.withoutSpacesAndNewLines != "" else {
            errorViewModel?.msgEmailError.value = ""
            return true
        }
        if !string.isValidEmail() {
            errorViewModel?.msgEmailError.value  = ValidationErrorBLL.ErrorMessages.msgInvalidEmail()
            return false
        }
       
        errorViewModel?.msgEmailError.value = ""
        return true
    }
}
