//
//  VerificationCodeValidationManager.swift
//  BLL
//
//  Created by SimpleTouch on 10/16/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
////import DAL
import SwifterSwift
public class VerificationCodeValidationManagerBLL : IValidationManagerBLL{
    
    
    public var errorViewModel: IVerificationCodeValidationDTOBLL?
    
    private let userPhoneNumberLength = 11
    
    required public init(errorModel: IVerificationCodeValidationDTOBLL){
        self.errorViewModel = errorModel
    }
    
    public  func validate(model: IAuthPhoneNumberDTODAL) -> Bool {
        var valid = true
        
        if !validateMobileNumber(string: model.mobile.value ?? ""){
            valid = false
        }
        return valid
    }
    
}
// Fields to be validated
extension VerificationCodeValidationManagerBLL : IVerificationCodeValidationManagerBLL {
    //MARK: validate Mobile number    
    public func validateMobileNumber(string: String,hintNumber: String = "01001234567") -> Bool {
        //        var validationError :String? = nil
               if string == "" {
                   errorViewModel?.msgPhoneNumberError.value  = ValidationErrorBLL.ErrorMessages.msgEmptyMobileNo()
                   return false
               }
        if string.withoutSpacesAndNewLines == "" || string.count != hintNumber.count || !string.isDigits {
                   errorViewModel?.msgPhoneNumberError.value  = ValidationErrorBLL.ErrorMessages.msgInvalidMobileNo()
                   return false
               }
               errorViewModel?.msgPhoneNumberError.value = ""
               return true
    }
}
