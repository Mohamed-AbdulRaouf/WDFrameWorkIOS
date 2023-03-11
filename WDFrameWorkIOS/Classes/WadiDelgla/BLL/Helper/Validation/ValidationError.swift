//
//  ValidationError.swift
//  BLL
//
//  Created by SimpleTouch on 10/1/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation

struct ValidationErrorBLL {
    
    var errorString: String!
    
    init(message: String) {
        
        errorString = message
    }
    
    struct ErrorMessages {
        
        static func msgEmptyEmail() -> String{
            return RBLL.string.localizable.empty_email()
        }
        static func msgInvalidEmail() -> String{
            return  RBLL.string.localizable.invalid_email_address()
        }
        static func msgEmptyName() -> String{
            return RBLL.string.localizable.empty_name()
        }
        static func msgEmptyLastName() -> String{ return RBLL.string.localizable.empty_last_name()
        }
        
        static func msgEmptyField() -> String{ return RBLL.string.localizable.empty_field()
        }
        static func msgInvalidAlphaNumericTest() -> String{
            return "Please enter a valid AlphaNumeric Text"
        }
        static func msgEmptyMobileNo() -> String{ return RBLL.string.localizable.empty_phone_number()
        }
        static func msgInvalidMobileNo() -> String{ return RBLL.string.localizable.invalid_phone_number()
        }
        static func msgLimitedText() -> String{ return "Please enter text upto the specified limit"}
        static func msgInvalidName() -> String{ return RBLL.string.localizable.invalid_first_name() }
        static func msgInvalidLastName() -> String{
            return RBLL.string.localizable.invalid_last_name()
        }
        
        static func msgEmptyPassword() -> String{
            return RBLL.string.localizable.empty_password()
        }
        static func msgInvalidPassword() -> String{
            return RBLL.string.localizable.invalid_password()
        }
        
        static func msgEmptyText() -> String{
            return "Please enter the text"
        }
        static func msgEmptyVerifyCode() -> String{
            return  RBLL.string.localizable.empty_verify_code()
        }
        static func msgInvalidVerifyCode() -> String{
            return  RBLL.string.localizable.invalid_verification_code()
        }
        static func msgInvalidPasswordLength() -> String{
            return RBLL.string.localizable.invalid_password_length("3", "10")
        }
        static func msgNotMatchPasswords() -> String{
            return  RBLL.string.localizable.password_not_match()
        }
        static func msgNotMatchPasswordWithCurrent() -> String{
            return RBLL.string.localizable.password_not_match_to_current()
        }
        static func msgInvalidReferralCode() -> String{
            return RBLL.string.localizable.invalid_referral_code()
        }
        static func msgEmptyReferralCode() -> String{
            return RBLL.string.localizable.empty_referral_code()
        }
        static func msgEmptyBuildingNo() -> String{
            return  RBLL.string.localizable.empty_building_no()
        }
        
        static func msgInvalidBuildingNo() -> String{
            return RBLL.string.localizable.invalid_building_no()
        }
        static func  msgEmptyStreetName() -> String{
            return RBLL.string.localizable.empty_street_name()
        }
        static func  msgInvalidStreetName() -> String{
            return RBLL.string.localizable.invalid_street_name()
        }
        static func msgEmptyFloorNo() -> String{
            return RBLL.string.localizable.empty_floor_no()
        }
        static func msgInvalidFloorNo() -> String{
            return RBLL.string.localizable.invalid_floor_no()
        }
        /* Order */
        static func msgEmptyUserAddressId() -> String{
            return RBLL.string.localizable.empty_user_address_id()
        }
        /* Payment */
        static func msgEmptyCreditCardName() -> String{
            return RBLL.string.localizable.empty_card_name()
        }
        static func msgEmptyCreditCardNumber() -> String{
            return RBLL.string.localizable.empty_card_number()
        }
        static func msgEmptyCreditCardExpiryDate() -> String{
            return RBLL.string.localizable.empty_card_expiry_date()
        }
        static func msgEmptyCreditCardCVV() -> String{
            return RBLL.string.localizable.empty_card_cvv()
        }
        static func msgInvalidCreditCardName() -> String {
             return RBLL.string.localizable.invalid_card_name()
        }
        static func msgInvalidCreditCardNumber() -> String {
             return RBLL.string.localizable.invalid_card_number()
        }
        static func msgInvalidCreditCardExpiryDate() -> String {
             return RBLL.string.localizable.invalid_card_expiry_date()
        }
        static func msgExpiredCreditCardExpiryDate() -> String {
             return RBLL.string.localizable.expired_card()
        }
        static func msgInvalidCreditCardCVV() -> String {
             return RBLL.string.localizable.invalid_card_cvv()
        }
      
    }
}
