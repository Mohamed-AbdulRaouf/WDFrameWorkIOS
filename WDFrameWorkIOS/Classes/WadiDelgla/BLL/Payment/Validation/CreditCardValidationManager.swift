//
//  CreditCardValidationManager.swift
//  BLL
//
//  Created by SimpleTouch on 8/6/20.
//  Copyright © 2020 SimpleTouch. All rights reserved.
//

import Foundation
////import DAL

public class CreditCardValidationManagerBLL : IValidationManagerBLL{
  
    
    public var errorViewModel: ICreditCardValidationDTOBLL?
    private let cardDataNumberLength = 16
    private let cvvLength = 3
    private let expiryDateLength = 4

    required public init(errorModel: ICreditCardValidationDTOBLL){
        self.errorViewModel = errorModel
    }
    
    
     public  func validate(model: ICardDTODAL) -> Bool {
        var valid = true
        
        if !validateCardHolderName(string: model.cardHolderName.value ?? ""){
            valid = false
        }
        if !validateCardNumber(string: model.cardNumber.value ?? ""){
            valid = false
        }
        if !validateCardExpiryDate(string: model.cardExpiryDate.value ?? ""){
            valid = false
        }
        if !validateCardCvv(string: model.cardCvv.value ?? ""){
            valid = false
        }
        return valid
    }
   
}
// Fields to be validated
extension CreditCardValidationManagerBLL : ICreditCardValidationManagerBLL {
   
    public func validateCardHolderName(string: String) -> Bool {
                 if string.withoutSpacesAndNewLines == ""  {
                     errorViewModel?.msgCardHolderNameError.value  =  ValidationErrorBLL.ErrorMessages.msgEmptyCreditCardName()
                     return false
                 }
                 errorViewModel?.msgCardHolderNameError.value = ""
                 return true
      }
    
    public func validateCardNumber(string: String) -> Bool {
         
        if string == "" {
            errorViewModel?.msgCardNumberError.value  = ValidationErrorBLL.ErrorMessages.msgEmptyCreditCardNumber()
            return false
        }
        if string.withoutSpacesAndNewLines == "" || string.count != cardDataNumberLength || !string.isDigits {
            errorViewModel?.msgCardNumberError.value  = ValidationErrorBLL.ErrorMessages.msgInvalidCreditCardNumber()
            return false
        }
        errorViewModel?.msgCardNumberError.value = ""
        return true
    }
    
  
    
    public func validateCardExpiryDate(string: String) -> Bool {
         if string == "" {
                   errorViewModel?.msgCardExpiryDateError.value  = ValidationErrorBLL.ErrorMessages.msgEmptyCreditCardExpiryDate()
                   return false
               }
               if string.withoutSpacesAndNewLines == "" || string.count != expiryDateLength || !string.isDigits {
                   errorViewModel?.msgCardExpiryDateError.value  = ValidationErrorBLL.ErrorMessages.msgInvalidCreditCardExpiryDate()
                   return false
               }
        if !string.isExpiryDate()  {
            errorViewModel?.msgCardExpiryDateError.value  = ValidationErrorBLL.ErrorMessages.msgExpiredCreditCardExpiryDate()
            return false
        }
               errorViewModel?.msgCardExpiryDateError.value = ""
               return true
    }
    
    public func validateCardCvv(string: String) -> Bool {
         if string == "" {
                   errorViewModel?.msgCardCVVError.value  = ValidationErrorBLL.ErrorMessages.msgEmptyCreditCardCVV()
                   return false
               }
               if string.withoutSpacesAndNewLines == "" || string.count != cvvLength || !string.isDigits {
                   errorViewModel?.msgCardCVVError.value  = ValidationErrorBLL.ErrorMessages.msgInvalidCreditCardCVV()
                   return false
               }
               errorViewModel?.msgCardCVVError.value = ""
               return true
    }
    
}
