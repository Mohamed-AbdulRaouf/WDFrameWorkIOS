//
//  UserRequest.swift
//  Netwroking
//
//  Created by SimpleTouch on 9/22/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Alamofire
////import DAL
enum UserRouteBLL: URLRequestBuilderBLL {
    
    
    
    // user
    case login(loginDTO: ILoginDTODAL)
    case loginWithCountry(model: IUserNameWithCountryLoginModelDAL)
    case loginB(loginDTO: ILoginBDTODAL)
    case register(registerDTO: IRegisterDTODAL)
    case resendVerifyCode(verifyCodeDTO: IVerificationCodeDTODAL)
    case checkVerificationCode(verifyCodeDTO: IVerificationCodeDTODAL)
    case verifyNewPassword(resetPasswordDTO: IResetPasswordDTODAL)
    case updateUser(userDTO: IUserDTODAL)
    case updatePassword(passwordDTO:INewPasswordDTODAL,brandId: Int)
    case updateMobileToken(userId: String,brandId:Int)
    case getTopReferralCustomers
    case CustomerGainRewardByQR(_ cipherCode: String)
    case registerToBrand(shareCode: String,brandId: Int)
    case getCustomerPreviousORders(requestOrderDTO: IRequestDTODAL)
    case getCustomerAddresses(brandId: Int)
    case getCustomerAddressesByAreaId(areaId: String,brandId: Int)
    case addAddress(addressDTO: IUserAddressDTODAL)
    case updateAddress(addressDTO: IUserAddressDTODAL)
    case getCustomerOderDetails(customerHistoryId: Int)
    case registerUserInBrand(brandId: Int)
    case getNotRatedOrders(requestOrderDTO: IRequestDTODAL)
    case validateCustomer(phoneNumber: String,brandId: Int,countryId: String?)
    case getUser(phoneNumber: String,brandId: Int)
    // MARK: - Path
    internal var path: ServerPathsBLL {
        switch self {
        case .login:
            return .LOGIN
        case .loginB:
            return .LOGIN
        case .loginWithCountry:
            return .LOGIN
        case .register:
            return .REGISTER
        case .resendVerifyCode:
            return .RESEND_VERIFY_CODE
        case .checkVerificationCode:
            return .CHECK_VERIFICATION_CODE
        case .verifyNewPassword:
            return .VERIFY_NEW_PASSWORD
        case .updateUser:
            return .UPDATE_USER
        case.updatePassword:
            return .UPDATE_PASSWORD
        case .updateMobileToken:
            return .UPDATE_MOBILE_TOKEN
        case  .getTopReferralCustomers:
            return .GET_TOP_RATED_CUSTOMERS
        case .CustomerGainRewardByQR:
            return .CUSTOMER_GAIN_REWARD_QR
        case .registerToBrand:
            return .REGISTER_TO_BRAND_BY_REFERRAL_CODE
        case .getCustomerPreviousORders:
            return .GET_PREVIOUS_ORDERS
        case .getCustomerAddresses:
            return .GET_CUSTOMER_ADDRESSES
        case .getCustomerAddressesByAreaId:
            return .GET_CUSTOMER_ADDRESSES_BY_AREAId
        case .addAddress:
            return .ADD_ADDRESS
        case .updateAddress:
            return .UPDATE_ADDRESS
        case .getCustomerOderDetails:
            return .GET_CUSTOMER_PREVIOUS_ORDER_DETAILS
        case .registerUserInBrand:
            return .REGISTER_USER_IN_BRAND
        case .getNotRatedOrders:
            return .GET_NOT_RATED_ORDER
        case .validateCustomer:
            return .VALIDATE_CUSTOMER
        case .getUser:
            return .GET_USER
        }
    }
    
    
    // MARK: - Parameters
    internal var parameters: Parameters? {
        var params = defaultParams
        switch self {
        case let .login(loginDTO):
            params[KBLL.APIParameterKey.userName] = loginDTO.mobile.value
            params["password"] = loginDTO.password.value
            params[KBLL.APIParameterKey.brandId] = loginDTO.brandId.value ?? 0
        //            params[KBLL.APIParameterKey.countryCode] = loginDTO.countryCode.value ?? 0
        case let .loginB(loginDTO):
            params[KBLL.APIParameterKey.userName] = loginDTO.mobile.value
                      params["password"] = loginDTO.password.value
                      params[KBLL.APIParameterKey.brandId] = loginDTO.brandId.value ?? 0
        case let .loginWithCountry(model):
            params[KBLL.APIParameterKey.userName] = model.mobile.value
                      params["password"] = model.password.value
                      params[KBLL.APIParameterKey.brandId] = model.brandId.value ?? 0

        case let .register(registerDTO):
            params[KBLL.APIParameterKey.brandId] = registerDTO.brandId.value ?? 0
            params[KBLL.APIParameterKey.firstName] = registerDTO.firstName.value
            params[KBLL.APIParameterKey.gender] = registerDTO.gender.value
            params[KBLL.APIParameterKey.id] = 0
            params[KBLL.APIParameterKey.lastName] = registerDTO.lastName.value
            params[KBLL.APIParameterKey.mobile] = registerDTO.mobile.value
            params[KBLL.APIParameterKey.password] = registerDTO.password.value
            params[KBLL.APIParameterKey.shareCode] = registerDTO.shareCode.value
            params[KBLL.APIParameterKey.email] = registerDTO.email.value
//            params[KBLL.APIParameterKey.countryCode] = registerDTO.countryCode.value
            
        case let .resendVerifyCode(verifyCodeDTO),
             let .checkVerificationCode(verifyCodeDTO):
            params[KBLL.APIParameterKey.verfingCode] = verifyCodeDTO.code.value
            params[KBLL.APIParameterKey.mobile] = verifyCodeDTO.mobile.value
            params[KBLL.APIParameterKey.brandId] = verifyCodeDTO.brandId.value ?? 0
        case let .verifyNewPassword(resetPasswordDTO):
            params[KBLL.APIParameterKey.mobile] = resetPasswordDTO.mobile.value
            params[KBLL.APIParameterKey.newPassword] = resetPasswordDTO.password.value
            params["brandId"] = resetPasswordDTO.brandId.value
//            params[KBLL.APIParameterKey.countryCode] = resetPasswordDTO.countryCode.value
            
        case let .updateUser(userDTO):
            params[KBLL.APIParameterKey.firstName] = userDTO.firstName.value
            params[KBLL.APIParameterKey.lastName] = userDTO.lastName.value
            params[KBLL.APIParameterKey.email] = userDTO.email.value
            params[KBLL.APIParameterKey.gender] = userDTO.gender.value
            params[KBLL.APIParameterKey.birthDay] = userDTO.birthday.value
            params[KBLL.APIParameterKey.birthMonth] = userDTO.birthmonth.value
        case let .updatePassword(passwordDTO,brandId):
            params["NewUserPassword"] = passwordDTO.newPassword.value
            params["brandId"] = brandId
        case let .updateMobileToken(userId,brandId):
            params["ID"] = userId
            params["MobileLang"] = Config.language
            params["BrandId"] = brandId
        case  .getTopReferralCustomers:
            break
        case let .CustomerGainRewardByQR(cipherCode):
            params[KBLL.APIParameterKey.qr] = cipherCode
        case let .registerToBrand(shareCode,brandId):
            params[KBLL.APIParameterKey.shareCode] = shareCode
            params[KBLL.APIParameterKey.brandId] = brandId
        case .getCustomerPreviousORders,.getCustomerAddresses,.getCustomerAddressesByAreaId,.getCustomerOderDetails:
            break;
        case let .addAddress(addressDTO):
            params[KBLL.APIParameterKey.areaId] = String(addressDTO.areaId.value ?? 0)
            params[KBLL.APIParameterKey.buildingNo] = String(addressDTO.buildingNo.value ?? "")
            params[KBLL.APIParameterKey.cityID] = String(addressDTO.cityId.value ?? 0)
            params[KBLL.APIParameterKey.companyName] = addressDTO.companyName.value ?? ""
            params[KBLL.APIParameterKey.description] = addressDTO.addressDescription.value ?? ""
            params[KBLL.APIParameterKey.streetName] = addressDTO.streetName.value ?? ""
            params[KBLL.APIParameterKey.floorNo] = addressDTO.floorNo.value ?? ""
            params["BrandId"] = String(addressDTO.brandId.value ?? 0)
            params["Latitude"] = String(addressDTO.latitude.value ?? 0.0)
            params["Longitude"] = String(addressDTO.longitude.value ?? 0.0)
        case let .updateAddress(addressDTO):
            params["ID"] = String(addressDTO.id.value ?? 0)
            params[KBLL.APIParameterKey.areaId] = String(addressDTO.areaId.value ?? 0)
            params[KBLL.APIParameterKey.buildingNo] = String(addressDTO.buildingNo.value ?? "")
            params[KBLL.APIParameterKey.cityID] = String(addressDTO.cityId.value ?? 0)
            params[KBLL.APIParameterKey.companyName] = addressDTO.companyName.value ?? ""
            params[KBLL.APIParameterKey.description] = addressDTO.addressDescription.value ?? ""
            params[KBLL.APIParameterKey.streetName] = addressDTO.streetName.value ?? ""
            params[KBLL.APIParameterKey.floorNo] = addressDTO.floorNo.value ?? ""
            params["BrandId"] = String(addressDTO.brandId.value ?? 0)
            params["Latitude"] = String(addressDTO.latitude.value ?? 0.0)
            params["Longitude"] = String(addressDTO.longitude.value ?? 0.0)
        case  .validateCustomer:
            break
        case .registerUserInBrand,.getNotRatedOrders,.getUser:
            break
        }
        return params
    }
    internal var headers: HTTPHeaders {
        var header = defaultHeaders
        switch self {
        case let .login(loginDTO):
            
            header[HTTPHeaderField.X_Dobites_Country_Id.rawValue] = loginDTO.countryId.value
            case let .loginB(loginDTO):
                       
                       header[HTTPHeaderField.X_Dobites_Country_Id.rawValue] = loginDTO.countryId.value
                    case let .loginWithCountry(model):
                   
                   header[HTTPHeaderField.X_Dobites_Country_Id.rawValue] = model.countryId.value

        case let .register(registerDTO):
            header[HTTPHeaderField.X_Dobites_Country_Id.rawValue] = registerDTO.countryId.value
        case let .verifyNewPassword(resetPasswordDTO):
            header[HTTPHeaderField.X_Dobites_Country_Id.rawValue] = resetPasswordDTO.countryId.value
        case let .validateCustomer(_, _, countryId):
            if let countryId = countryId {
                header[HTTPHeaderField.X_Dobites_Country_Id.rawValue] = countryId
            }
        default:
            break
        }
        return header
    }
    internal var urlParameters: [String]? {
        var params = [String]()
        switch self {
        case .getTopReferralCustomers:
            params.append(Config.language)
        case let .getCustomerPreviousORders(requestOrderDTO):
            params.append(String(requestOrderDTO.brandId.value ?? 0))
            params.append(String(requestOrderDTO.pageNumber.value ?? 0))
            params.append(String(requestOrderDTO.pageSize.value ?? 0))
            params.append(Config.language)
        case let .getCustomerAddressesByAreaId(areaId,brandId):
            params.append(areaId)
            params.append(String(brandId))
            params.append(Config.language)
        case let .getCustomerOderDetails(customerHistoryId):
            params.append(String(customerHistoryId))
            params.append(Config.language)
        case let .registerUserInBrand(brandId):
            params.append(String(brandId))
            params.append(String(Config.customerSourceId))
            params.append(Config.language)
        case let .getNotRatedOrders(requestOrderDTO):
            params.append(String(requestOrderDTO.brandId.value ?? 0))
            params.append(String(requestOrderDTO.pageNumber.value ?? 0))
            params.append(String(requestOrderDTO.pageSize.value ?? 0))
            params.append(Config.language)
        case let .validateCustomer(phoneNumber,brandId,countryId):
            params.append(phoneNumber)
//            params.append(countryId)
            params.append(String(brandId))
        case let .getUser(phoneNumber, brandId):
            params.append(phoneNumber)
            params.append(String(brandId))
        case let .getCustomerAddresses(brandId):
            params.append(String(brandId))
            params.append(Config.language)
        default:
            break
        }
        return params
    }
    internal var urlQueryParameters: [[String : String]]?{
        var params =  [[String : String]]()
        switch self {
        default:
            break
        }
        return params
    }
    
    // MARK: - Methods
    internal var method: HTTPMethod {
        switch self {
        case .getTopReferralCustomers,.getCustomerPreviousORders,.getCustomerAddresses,.getCustomerAddressesByAreaId,.getCustomerOderDetails,.registerUserInBrand,.getNotRatedOrders,.validateCustomer,.getUser:
            return .get
        default:
            return .post
        }
    }
}
