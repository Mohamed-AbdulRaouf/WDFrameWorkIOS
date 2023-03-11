//
//  PhoneNumberValidationManager.swift
//  BLL
//
//  Created by SimpleTouch on 1/30/20.
//  Copyright © 2020 SimpleTouch. All rights reserved.
//

import Foundation
////import DAL

public class PhoneNumberValidationManagerBLL : IValidationManagerBLL{
    
    
    public var errorViewModel: IPhoneNumberValidationDTOBLL?
    
    private let userPhoneNumberLength = 11
    
    required public init(errorModel: IPhoneNumberValidationDTOBLL){ 
        self.errorViewModel = errorModel
    }
    
    public  func validate(model: String) -> Bool {
        var valid = true
        
        if !validateMobileNumber(string: model ?? ""){
            valid = false
        }
      
        return valid
    }
    
}
// Fields to be validated
extension PhoneNumberValidationManagerBLL : IPhoneNumberValidationManagerBLL {
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
    
    
}
