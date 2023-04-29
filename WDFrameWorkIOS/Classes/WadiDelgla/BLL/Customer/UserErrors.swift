//
//  UserErrors.swift
//  BLL
//
//  Created by SimpleTouch on 9/26/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import RswiftResources

public enum ErrorsCodeBLL : Int{
    case notActiveAccount = 615
    case noDataFound = 603
    case ItemsInCartChanged = 674
    case InvalidMinOrderToDeliver = 675
    case EmptyAddress = 643
    case BranchisInactive = 672
}

 
public enum StandardMessagesBLL: Error, CustomStringConvertible {
    case noValidId
    case noValidGender
    case noValidPassword
    case noValidPhoneNumber
    case mobileExist
    case noValidEmail
    case emailExist
    case noValidCustomerSource
    case noValidShareCode
    case noValidMobileToken
    case userNotFound
    case errorOccure
    case inactiveAccount
    case notActiveAccount
    case phoneNumberNotFound
    case faildUpdateVerifyCode
    case faildSendVerifyCode
    case invalidVerifyCode
    case faildUpdatePassword
    case invalidMobileLanguage
    case noDataFound
    case faildParseJson
    case invalidQRCode
    case expiredQRCode
    case usedQRCode
    case invalidReferralCode
    case invalidInputData
    case notFoundBrand
    case customerAlreadyRegisterInBrand
    case faildRegisterToBrand
    case InvalidCouponCode
    case CouponCodeNotInCampain
    case ExpiredCouponCode
    case CouponCodeAssignToAnotherOne
    case CouponCodeIsUsedBefore
    case DiscountExceedingMaxAllowLimit
    case NotEnoughPoints
    case NotAllowTwoDiscountType
    case EmptyAddress
    case NoOnlineOrder
    case BrandNotAvailable
    case ItemsInCartChanged
    case InvalidMinOrderToDeliver
    case FailedValidateCustomer
    case InvalidRate
    case BranchisInactive
    case customError(errorCode: Int)
    
    init(rawValue: Int) {
         self = .customError(errorCode: rawValue)
//        switch rawValue {
//        case 615:
//            self = .notActiveAccount
//        default:
//            self = .customError(errorCode: rawValue)
//        }
    }
    
     public var description: String {
        switch self {
        case .noValidPassword:
            return RBLL.string.localizable.invalid_password()
        case .noValidId:
            return RBLL.string.localizable.invalid_id()
        case .noValidGender:
            return RBLL.string.localizable.invalid_gender()
        case .noValidPhoneNumber:
            return RBLL.string.localizable.invalid_phone_number()
        case .mobileExist:
            return RBLL.string.localizable.phone_number_exist()
        case .noValidEmail:
            return RBLL.string.localizable.invalid_email_address()
        case .emailExist:
            return RBLL.string.localizable.email_address_exist()
        case .noValidCustomerSource:
            return RBLL.string.localizable.invalid_customer_source()
        case .noValidShareCode:
            return RBLL.string.localizable.invalid_share_code()
        case .noValidMobileToken:
            return RBLL.string.localizable.invalid_mobile_token()
        case .userNotFound:
            return RBLL.string.localizable.user_not_found()
        case .errorOccure:
            return  RBLL.string.localizable.error_occure()
        case .inactiveAccount:
            return RBLL.string.localizable.inactive_account()
        case .notActiveAccount:
            return RBLL.string.localizable.not_active_account()
        case .phoneNumberNotFound:
            return RBLL.string.localizable.number_not_found()
        case .faildUpdateVerifyCode:
            return RBLL.string.localizable.faild_update_verify_code()
        case .faildSendVerifyCode:
            return RBLL.string.localizable.faild_send_verify_code()
        case .invalidVerifyCode:
            return RBLL.string.localizable.invalid_verification_code()
        case .faildUpdatePassword:
            return RBLL.string.localizable.faild_upfate_password()
        case .invalidMobileLanguage:
            return RBLL.string.localizable.invalid_mobile_language()
        case .noDataFound:
            return RBLL.string.localizable.no_data_found()
        case .faildParseJson:
            return RBLL.string.localizable.faild_parse_data()
        case .invalidQRCode:
            return RBLL.string.localizable.invalid_qr_code()
        case .expiredQRCode:
            return RBLL.string.localizable.qr_code_expired_or_used_before()
        case .usedQRCode:
            return RBLL.string.localizable.code_used_before()
        case .invalidReferralCode:
            return RBLL.string.localizable.invalid_referral_code()
        case .invalidInputData:
            return RBLL.string.localizable.invalid_input_data()
         case .notFoundBrand:
            return RBLL.string.localizable.not_found_brand()
        case .customerAlreadyRegisterInBrand:
             return RBLL.string.localizable.customer_register_before_to_brand()
        case .faildRegisterToBrand:
            return RBLL.string.localizable.faild_register_to_brand()
        case .InvalidCouponCode:
            return RBLL.string.localizable.coupon_code_not_correct()
        case .CouponCodeNotInCampain:
            return RBLL.string.localizable.coupon_code_not_in_campaign()
        case .ExpiredCouponCode:
            return RBLL.string.localizable.coupon_code_is_expired()
        case .CouponCodeAssignToAnotherOne:
            return RBLL.string.localizable.coupon_code_is_assigned_to_another_one()
        case .CouponCodeIsUsedBefore:
            return RBLL.string.localizable.coupon_code_used_before()
        case .DiscountExceedingMaxAllowLimit:
            return RBLL.string.localizable.coupon_code_exceeding_maximum()
        case .NotEnoughPoints:
            return RBLL.string.localizable.coupon_code_points_enough()
        case .NotAllowTwoDiscountType:
            return RBLL.string.localizable.can_not_use_two_type()
        case .EmptyAddress:
            return RBLL.string.localizable.empty_user_address_id()
        case .NoOnlineOrder:
            return RBLL.string.localizable.online_order_not_availble()
        case .BrandNotAvailable:
            return RBLL.string.localizable.branch_not_available()
        case .ItemsInCartChanged:
            return RBLL.string.localizable.items_changed()
        case .InvalidMinOrderToDeliver:
            return RBLL.string.localizable.min_order_invalid()
        case .FailedValidateCustomer:
            return RBLL.string.localizable.failed_validate_customer()
        case .InvalidRate:
            return RBLL.string.localizable.invalid_rate()
        case .BranchisInactive:
            return "branch_inactive".localized()
        case let .customError(errorCode):
            return HandleAPIErrorsBLL.handleError(errorCode: errorCode)
        }
    }
}
