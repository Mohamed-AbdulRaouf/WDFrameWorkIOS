//
//  ReferralCodeValidationManager.swift
//  BLL
//
//  Created by Nermeen Mohamed on 10/30/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
////import DAL

public class ReferralCodeValidationManagerBLL : IValidationManagerBLL{
    
    
    public var errorViewModel: IRefferalCodeValidationDTOBLL?
    
    required public init(errorModel: IRefferalCodeValidationDTOBLL){
        self.errorViewModel = errorModel
    }
    
    public  func validate(model: String) -> Bool {
        var valid = true
        if !validateReferralCode(string: model) {
            valid = false
        }
        return valid
    }
    
}
// Fields to be validated
extension ReferralCodeValidationManagerBLL : IReferralCodeValidationManagerBLL {
    public func validateReferralCode(string: String) -> Bool {
        if string == "" {
            errorViewModel?.msgSharedCodeError.value =  ValidationErrorBLL.ErrorMessages.msgEmptyReferralCode()
            return false
        }
        if string.withoutSpacesAndNewLines == "" || string.count < 2 {
            errorViewModel?.msgSharedCodeError.value  =  ValidationErrorBLL.ErrorMessages.msgInvalidReferralCode()
            return false
        }
        errorViewModel?.msgSharedCodeError.value = ""
        return true
    }
}
