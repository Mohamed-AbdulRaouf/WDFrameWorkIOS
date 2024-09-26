//
//  UserUseCases.swift
//  Netwroking
//
//  Created by SimpleTouch on 9/22/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Alamofire
import Network
////import DAL
//import Firebase
//import FirebaseAuth
//import STFirebase
//import STFirebase
public class UserUseCasesBLL : UserServiceBLL  {
   
    
    
    
    
    private var network: NetworkingBLL
    public init(network : NetworkingBLL ){
        self.network = network
       
    }
    /// This Function to Register user in App
    ///
    /// - Parameters:
    ///   - registerDTO: user's registeration details Object
    ///   - completion: it returns success or fail register user in App
    public func register(_ registerDTO:IRegisterDTODAL,hintNumber: String? = nil,completion: @escaping onSuccessBLL){
        //validate data
        let validationDTO = RegisterValidationDTOBLL()
        let validation = RegisterValidationManagerBLL(errorModel: validationDTO,hintNumber: hintNumber)
        
        guard validation.validate(model: registerDTO) else {
            completion(STResponseBLL(data: nil,error: STErrorBLL(validateError: validationDTO, APIError: nil)))
            return
        }
        
        //API
        let request = UserRouteBLL.register(registerDTO: registerDTO)
        network.sendRequest(request) { (response, error) in
            guard error == nil else {
                completion(STResponseBLL(data: nil, error: STErrorBLL(validateError: validationDTO , APIError: nil,networkError: NetworkErrorBLL(error: (error as NSError?)!))))
                return
            }
            if response?.statusCode == 200 && response?.messageCode == 605 {
                completion(STResponseBLL(data: true, error: nil))
            }else {
                completion(STResponseBLL(data: nil, error: STErrorBLL(validateError: validationDTO, APIError: StandardMessagesBLL(rawValue: response?.messageCode ?? 0),ErrorCode: response?.messageCode)))
            }
        }
    }
    
    /// This Function to Login user in App
    ///
    /// - Parameters:
    ///   - loginDTO: user's Login Data
    ///   - completion: it returns user Info details if success login
    public func login(_ loginDTO: ILoginDTODAL,_ hintNumber: String? = nil,completion: @escaping onSuccessBLL)  {
               
             //validate data
            let validationDTO = LoginValidationDTOBLL()
                   let validation = LoginValidationManagerBLL(errorModel: validationDTO, hintNumber: hintNumber)
               
                   
                   guard validation.validate(model: loginDTO) else {
                       completion(STResponseBLL(data: nil, error:STErrorBLL(validateError: validationDTO, APIError: nil)))
                       return
                   }
       
        //API
        let request = UserRouteBLL.login(loginDTO: loginDTO)
        network.sendRequest(request) { (response, error) in
            guard error == nil else {
                completion(STResponseBLL(data: nil, error: STErrorBLL(validateError: validationDTO , APIError: nil,networkError: NetworkErrorBLL(error: (error as NSError?)!))))
                return
            }
            
            if response?.statusCode == 200 && response?.messageCode == 601 {
                let user =  UserDTODAL(json: response?.data ?? "")
                completion(STResponseBLL(data: user, error:nil))
            }else {
                completion(STResponseBLL(data: nil, error: STErrorBLL(validateError: validationDTO, APIError: StandardMessagesBLL(rawValue: response?.messageCode ?? 0),ErrorCode: response?.messageCode)))
            }
        }
        
      
    }
    public func login(_ model: ILoginModelDAL,type: LoginTypeBLL,completion: @escaping onSuccessBLL){
        let strategy = LoginStrategyBLL(type: type)
        strategy.login(model: model, completion: completion)
    }
   
    /// This Function to reset user's password
    ///
    /// - Parameters:
    ///   - resetPasswordDTO: user phone number and new password
    ///   - completion: it returns success or fail reset password
    public func resetPassword(_ resetPasswordDTO: IResetPasswordDTODAL, completion: @escaping onSuccessBLL) {
        
        let validationDTO = ResetPasswordValidationDTO()
        let validation = ResetPasswordValidationManager(errorModel: validationDTO)
        
        guard validation.validate(model: resetPasswordDTO) else {
            completion(STResponseBLL(data: nil,error: STErrorBLL(validateError: validationDTO, APIError: nil)))
            return
        }
        //API
        let request = UserRouteBLL.verifyNewPassword(resetPasswordDTO: resetPasswordDTO)
        network.sendRequest(request) { (response, error) in
            guard error == nil else {
                completion(STResponseBLL(data: nil, error: STErrorBLL(validateError: validationDTO , APIError: nil,networkError: NetworkErrorBLL(error: (error as NSError?)!))))
                return
            }
            if response?.statusCode == 200 && response?.messageCode == 610 {
                completion(STResponseBLL(data: true, error: nil))
            }else {
                completion(STResponseBLL(data: nil, error: STErrorBLL(validateError: validationDTO, APIError: StandardMessagesBLL(rawValue: response?.messageCode ?? 0),ErrorCode: response?.messageCode)))
            }
        }
    }
    
    public func checkValidatePasswordDTO(_ resetPasswordDTO: IResetPasswordDTODAL,completion: @escaping onSuccessBLL){
        let validationDTO = ResetPasswordValidationDTO()
        let validation = ResetPasswordValidationManager(errorModel: validationDTO)
        
        guard validation.validate(model: resetPasswordDTO) else {
            completion(STResponseBLL(data: nil,error: STErrorBLL(validateError: validationDTO, APIError: nil)))
            return
        }
        completion(STResponseBLL(data: true,error: STErrorBLL(validateError: validationDTO, APIError: nil)))

    }
    
    /// This Function to update user info
    ///
    /// - Parameters:
    ///   - userDTO: user info
    ///   - completion: it returns success or fail update user info
    public func updateUser(_ userDTO: IUserDTODAL, completion: @escaping onSuccessBLL) {
        
        let validationDTO = UserProfileValidationDTOBLL()
        let validation = UserProfileValidationManagerBLL(errorModel: validationDTO)
        
        guard validation.validate(model: userDTO) else {
            completion(STResponseBLL(data: nil,error: STErrorBLL(validateError: validationDTO, APIError: nil)))
            return
        }
        //API
        let request = UserRouteBLL.updateUser(userDTO: userDTO)
        network.sendRequest(request) { (response, error) in
            guard error == nil else {
                completion(STResponseBLL(data: nil, error: STErrorBLL(validateError: validationDTO , APIError: nil,networkError: NetworkErrorBLL(error: (error as NSError?)!))))
                return
            }
            if response?.statusCode == 200 && response?.messageCode == 606 {
                completion(STResponseBLL(data: true, error: nil))
            }else {
                completion(STResponseBLL(data: nil, error: STErrorBLL(validateError: validationDTO, APIError: StandardMessagesBLL(rawValue: response?.messageCode ?? 0),ErrorCode: response?.messageCode)))
            }
        }
    }
    
    /// This Function to change password
    ///
    /// - Parameters:
    ///   - passwordDTO:  old and new Password Model
    ///   - completion: it returns success or fail update user's password
    public func updatePassword(_ passwordDTO: INewPasswordDTODAL,_ brandId: Int,completion: @escaping onSuccessBLL) {
        
        let validationDTO = ChangePasswordValidationDTOBLL()
        let validation = ChangePasswordValidationManagerBLL(errorModel: validationDTO)
        
        guard validation.validate(model: passwordDTO) else {
            completion(STResponseBLL(data: nil,error: STErrorBLL(validateError: validationDTO, APIError: nil)))
            return
        }
        //API
        let request = UserRouteBLL.updatePassword(passwordDTO: passwordDTO, brandId: brandId)
        network.sendRequest(request) { (response, error) in
            guard error == nil else {
                completion(STResponseBLL(data: nil, error: STErrorBLL(validateError: validationDTO , APIError: nil,networkError: NetworkErrorBLL(error: (error as NSError?)!))))
                return
            }
            if response?.statusCode == 200 && response?.messageCode == 610 {
                completion(STResponseBLL(data: true, error: nil))
            }else {
                completion(STResponseBLL(data: nil, error: STErrorBLL(validateError: validationDTO, APIError: StandardMessagesBLL(rawValue: response?.messageCode ?? 0),ErrorCode: response?.messageCode)))
            }
        }
    }
    /// This Function to update mobile token with firebase token
    ///
    /// - Parameters:
    ///   - userId: user Id
    ///   - completion: this returns success or fail update token
    public  func updateMobileToken(_ userId: String,_ brandId:Int,completion: @escaping onSuccessBLL){
        //API
        let request = UserRouteBLL.updateMobileToken(userId: userId, brandId: brandId)
        network.sendRequest(request) { (response, error) in
            guard error == nil else {
                completion(STResponseBLL(data: nil, error: STErrorBLL(validateError: nil , APIError: nil,networkError: NetworkErrorBLL(error: (error as NSError?)!))))
                return
            }
            if response?.statusCode == 200 && response?.messageCode == 611 {
                completion(STResponseBLL(data: true, error: nil))
            }else {
                completion(STResponseBLL(data: nil, error: STErrorBLL(validateError: nil, APIError: StandardMessagesBLL(rawValue: response?.messageCode ?? 0),ErrorCode: response?.messageCode)))
            }
        }
    }
    
    /// This Function to Check the sended verification code to complete the specific proceess
    ///
    /// - Parameters:
    ///   - verifyDTO: verification code model
    ///   - completion: it returns success or invalid verification code
    public func checkVerifyCode(_ verifyDTO: IVerificationCodeDTODAL, completion: @escaping onSuccessBLL) {
        
        //API
        let request = UserRouteBLL.checkVerificationCode(verifyCodeDTO: verifyDTO)
        network.sendRequest(request) { (response, error) in
            guard error == nil else {
                completion(STResponseBLL(data: nil, error: STErrorBLL(validateError: nil , APIError: nil,networkError: NetworkErrorBLL(error: (error as NSError?)!))))
                return
            }
            if response?.messageCode == 625 {
                completion(STResponseBLL(data: true, error: nil))
            }else {
                completion(STResponseBLL(data: nil, error: STErrorBLL(validateError: nil, APIError: StandardMessagesBLL(rawValue: response?.messageCode ?? 0),ErrorCode: response?.messageCode)))
            }
        }
    }
    public func validateCustomer(_ phoneNumber: String, _ countryId: String? = nil, _ brandId: Int = 0, completion: @escaping onSuccessBLL) {
        //API
        let request = UserRouteBLL.validateCustomer(phoneNumber: phoneNumber, brandId: brandId, countryId: countryId)
               network.sendRequest(request) { (response, error) in
                   guard error == nil else {
                       completion(STResponseBLL(data: nil, error: STErrorBLL(validateError: nil , APIError: nil,networkError: NetworkErrorBLL(error: (error as NSError?)!))))
                       return
                   }
                   if response?.statusCode == 200 && response?.messageCode == 625 {
                       completion(STResponseBLL(data: true, error: nil))
                   }else {
                       completion(STResponseBLL(data: nil, error: STErrorBLL(validateError: nil, APIError: StandardMessagesBLL(rawValue: response?.messageCode ?? 0),ErrorCode: response?.messageCode)))
                   }
               }
    }
   
    public func getUser(_ phoneNumber: String,_ brandId: Int, completion: @escaping onSuccessBLL) {
        //validate data
        let validationDTO = PhoneNumberValidationDTOBLL()
        let validation = PhoneNumberValidationManagerBLL(errorModel: validationDTO)
        
        guard validation.validate(model: phoneNumber) else {
            completion(STResponseBLL(data: nil,error: STErrorBLL(validateError: validationDTO, APIError: nil)))
            return
        }
        // API
        let request = UserRouteBLL.getUser(phoneNumber: phoneNumber, brandId: brandId)
        network.sendRequest(request) { (response, error) in
            guard error == nil else {
                completion(STResponseBLL(data: nil, error: STErrorBLL(validateError: nil , APIError: nil,networkError: NetworkErrorBLL(error: (error as NSError?)!))))
                return
            }
            if response?.statusCode == 200 && response?.messageCode == 601 {
                let user = UserDTODAL(json: response?.data ?? "")
                completion(STResponseBLL(data: user, error: nil))
            }else {
                completion(STResponseBLL(data: nil, error: STErrorBLL(validateError: nil, APIError: StandardMessagesBLL(rawValue: response?.messageCode ?? 0),ErrorCode: response?.messageCode)))
            }
        }
    }
}
extension UserUseCasesBLL{
    /// This Function to get the top referral customers
    ///
    /// - Parameter completion: This returns top referral customers models
    public func getTopReferralsCustomer(completion: @escaping onSuccessBLL) {
        //API
        let request = UserRouteBLL.getTopReferralCustomers
        network.sendRequest(request) { (response, error) in
            guard error == nil else {
                completion(STResponseBLL(data: nil, error: STErrorBLL(validateError: nil , APIError: nil,networkError: NetworkErrorBLL(error: (error as NSError?)!))))
                return
            }
            if response?.statusCode == 200 && response?.messageCode == 601 {
                guard let json = response?.data?.arrayValue else {
                    completion(STResponseBLL(data: nil, error: STErrorBLL(validateError: nil , APIError: StandardMessagesBLL.faildParseJson)))
                    return
                }
                let rankings =  json.map({try! TopRatedReferralsDTODAL.init(json: $0)})
                completion(STResponseBLL(data: rankings, error:nil))
            }else {
                completion(STResponseBLL(data: nil, error: STErrorBLL(validateError: nil, APIError: StandardMessagesBLL(rawValue: response?.messageCode ?? 0),ErrorCode: response?.messageCode)))
            }
        }
    }
    /// This Function to gain Rewards by using QR
    ///
    /// - Parameters:
    ///   - cipherCode: QR Code
    ///   - completion: This retruns gain Points if success or error message if fails
    public func gainRewardsByQR(_ cipherCode: String, completion: @escaping onSuccessBLL) {
        //API
        let request = UserRouteBLL.CustomerGainRewardByQR(cipherCode)
        network.sendRequest(request) { (response, error) in
            guard error == nil else {
                completion(STResponseBLL(data: nil, error: STErrorBLL(validateError: nil , APIError: nil,networkError: NetworkErrorBLL(error: (error as NSError?)!))))
                return
                
            }
            if  response?.messageCode == 601 {
                completion(STResponseBLL(data:  response?.data?["GainPoint"].stringValue, error:nil))
            }else {
                completion(STResponseBLL(data: nil, error: STErrorBLL(validateError: nil, APIError: StandardMessagesBLL(rawValue: response?.messageCode ?? 0),ErrorCode: response?.messageCode)))
            }
        }
    }
    /// This Function to Register to Brand by using referral code
    ///
    /// - Parameters:
    ///   - shareCode: share code
    ///   - brandId: brand Id to register for
    ///   - completion: this returns success or fail register to brand using share code
    public func registerToBrandByReferralCode(_ shareCode: String,_ brandId : Int,completion: @escaping onSuccessBLL){
        //validate data
        let validationDTO = RefferalCodeValidationDTOBLL()
        let validation = ReferralCodeValidationManagerBLL(errorModel: validationDTO)
        
        guard validation.validate(model: shareCode) else {
            completion(STResponseBLL(data: nil,error: STErrorBLL(validateError: validationDTO, APIError: nil)))
            return
        }
        
        //API
        let request = UserRouteBLL.registerToBrand(shareCode: shareCode, brandId: brandId)
        network.sendRequest(request) { (response, error) in
            guard error == nil else {
                completion(STResponseBLL(data: nil, error: STErrorBLL(validateError: validationDTO , APIError: nil,networkError: NetworkErrorBLL(error: (error as NSError?)!))))
                return
            }
            if response?.statusCode == 200 && response?.messageCode == 620 {
                completion(STResponseBLL(data: true, error: nil))
            }else {
                completion(STResponseBLL(data: nil, error: STErrorBLL(validateError: validationDTO, APIError: StandardMessagesBLL(rawValue: response?.messageCode ?? 0),ErrorCode: response?.messageCode)))
            }
        }
    }
    /// This Function to get customer previous orders
    ///
    /// - Parameters:
    ///   - requestOrders: request order List model
    ///   - completion: this returns Customer previous orders
    public  func getCustomerPreviousOrders(_ requestOrders: IRequestDTODAL,completion: @escaping onSuccessBLL){
        //API
        let request = UserRouteBLL.getCustomerPreviousORders(requestOrderDTO: requestOrders)
        network.sendRequest(request) { (response, error) in
            guard error == nil else {
                completion(STResponseBLL(data: nil, error: STErrorBLL(validateError: nil , APIError: nil,networkError: NetworkErrorBLL(error: (error as NSError?)!))))
                return
            }
            if response?.statusCode == 200 && response?.messageCode == 601 {
                guard let json = response?.data else {
                    completion(STResponseBLL(data: nil, error: STErrorBLL(validateError: nil , APIError: StandardMessagesBLL.faildParseJson)))
                    return
                }
                let order =  try! OrderListDTODAL.init(json: json)
                completion(STResponseBLL(data: order, error:nil))
            }else {
                completion(STResponseBLL(data: nil, error: STErrorBLL(validateError: nil, APIError: StandardMessagesBLL(rawValue: response?.messageCode ?? 0),ErrorCode: response?.messageCode)))
            }
        }
    }
    /// This Function to get customer addresses
    ///
    /// - Parameter completion: it returns user address List
    public func getCustomerAddresses(_ brandId:Int,completion: @escaping onSuccessBLL) {
        //API
        let request = UserRouteBLL.getCustomerAddresses(brandId: brandId)
        network.sendRequest(request) { (response, error) in
            guard error == nil else {
                completion(STResponseBLL(data: nil, error: STErrorBLL(validateError: nil , APIError: nil,networkError: NetworkErrorBLL(error: (error as NSError?)!))))
                return
            }
            if response?.statusCode == 200 && response?.messageCode == 601 {
                guard let json = response?.data?.arrayValue else {
                    completion(STResponseBLL(data: nil, error: STErrorBLL(validateError: nil , APIError: StandardMessagesBLL.faildParseJson)))
                    return
                }
                let addresses =  json.map({try! UserAddressDTODAL.init(json: $0)})
                completion(STResponseBLL(data: addresses, error:nil))
            }else {
                completion(STResponseBLL(data: nil, error: STErrorBLL(validateError: nil, APIError: StandardMessagesBLL(rawValue: response?.messageCode ?? 0),ErrorCode: response?.messageCode)))
            }
        }
    }
    /// This Function to get customer addresses by given area Id
    ///
    /// - Parameters:
    ///   - areaId: area Id
    ///   - completion: it returns user address List for specific area
    public func getCustomerAddressesByAreaId(_ areaId: String,_ brandId: Int, completion: @escaping onSuccessBLL) {
        //API
        let request = UserRouteBLL.getCustomerAddressesByAreaId(areaId: areaId,brandId: brandId)
        network.sendRequest(request) { (response, error) in
            guard error == nil else {
                completion(STResponseBLL(data: nil, error: STErrorBLL(validateError: nil , APIError: nil,networkError: NetworkErrorBLL(error: (error as NSError?)!))))
                return
            }
            if response?.statusCode == 200 && response?.messageCode == 601 {
                guard let json = response?.data?.arrayValue else {
                    completion(STResponseBLL(data: nil, error: STErrorBLL(validateError: nil , APIError: StandardMessagesBLL.faildParseJson)))
                    return
                }
                
                let addresses =  json.map({try! UserAddressDTODAL.init(json: $0)})
                completion(STResponseBLL(data: addresses, error:nil))
            }else {
                completion(STResponseBLL(data: nil, error: STErrorBLL(validateError: nil, APIError: StandardMessagesBLL(rawValue: response?.messageCode ?? 0),ErrorCode: response?.messageCode)))
            }
        }
    }
    /// This Function to add New address
    ///
    /// - Parameters:
    ///   - addressDTO: new address details model
    ///   - completion: this return success or fail add the new address
    public func addCustomerAddress(_ addressDTO: IUserAddressDTODAL, completion: @escaping onSuccessBLL) {
        //validate data
        let validationDTO = AddressValidationDTOBLL()
        let validation = AddressValidationManagerBLL(errorModel: validationDTO)
        
        guard validation.validate(model: addressDTO) else {
            completion(STResponseBLL(data: nil,error: STErrorBLL(validateError: validationDTO, APIError: nil)))
            return
        }
        //API
        let request = UserRouteBLL.addAddress(addressDTO: addressDTO)
        network.sendRequest(request) { (response, error) in
            guard error == nil else {
                completion(STResponseBLL(data: nil, error: STErrorBLL(validateError: nil , APIError: nil,networkError: NetworkErrorBLL(error: (error as NSError?)!))))
                return
            }
            if response?.statusCode == 200 && response?.messageCode == 607 {
                completion(STResponseBLL(data: true, error:nil))
            }else {
                completion(STResponseBLL(data: nil, error: STErrorBLL(validateError: nil, APIError: StandardMessagesBLL(rawValue: response?.messageCode ?? 0),ErrorCode: response?.messageCode)))
            }
        }
    }
    /// This Function to update customer address details
    ///
    /// - Parameters:
    ///   - addressDTO: the updated address model
    ///   - completion: this returns success or fail update address
    public func updateCustomerAddress(_ addressDTO: IUserAddressDTODAL, completion: @escaping onSuccessBLL) {
        //validate data
        let validationDTO = AddressValidationDTOBLL()
        let validation = AddressValidationManagerBLL(errorModel: validationDTO)
        
        guard validation.validate(model: addressDTO) else {
            completion(STResponseBLL(data: nil,error: STErrorBLL(validateError: validationDTO, APIError: nil)))
            return
        }
        //API
        let request = UserRouteBLL.updateAddress(addressDTO: addressDTO)
        network.sendRequest(request) { (response, error) in
            guard error == nil else {
                completion(STResponseBLL(data: nil, error: STErrorBLL(validateError: nil , APIError: nil,networkError: NetworkErrorBLL(error: (error as NSError?)!))))
                return
            }
            if response?.statusCode == 200 && response?.messageCode == 608 {
                completion(STResponseBLL(data: true, error:nil))
            }else {
                completion(STResponseBLL(data: nil, error: STErrorBLL(validateError: nil, APIError: StandardMessagesBLL(rawValue: response?.messageCode ?? 0),ErrorCode: response?.messageCode)))
            }
        }
    }
    /// This Function to get order receipt
    ///
    /// - Parameters:
    ///   - customerHistoryId: Order's History Id
    ///   - completion: it returns receipt details for given order customer history id
    public func getCustomerOrderDetails(_ customerHistoryId: Int, completion: @escaping onSuccessBLL) {
        //API
        let request = UserRouteBLL.getCustomerOderDetails(customerHistoryId: customerHistoryId)
        network.sendRequest(request) { (response, error) in
            guard error == nil else {
                completion(STResponseBLL(data: nil, error: STErrorBLL(validateError: nil , APIError: nil,networkError: NetworkErrorBLL(error: (error as NSError?)!))))
                return
            }
            if response?.statusCode == 200 && response?.messageCode == 601 {
                guard let json = response?.data else {
                    completion(STResponseBLL(data: nil, error: STErrorBLL(validateError: nil , APIError: StandardMessagesBLL.faildParseJson)))
                    return
                }
                let receipt =  try! ReceiptDTODAL.init(json: json)
                completion(STResponseBLL(data: receipt, error:nil))
            }else {
                completion(STResponseBLL(data: nil, error: STErrorBLL(validateError: nil, APIError: StandardMessagesBLL(rawValue: response?.messageCode ?? 0),ErrorCode: response?.messageCode)))
            }
        }
    }
    /// This Function to register user in Brand
    ///
    /// - Parameters:
    ///   - brandId: brand id
    ///   - completion: this returns success or fail register to brand
    public func registerUserInBrand(_ brandId: Int, completion: @escaping onSuccessBLL) {
        //API
        let request = UserRouteBLL.registerUserInBrand(brandId: brandId)
        network.sendRequest(request) { (response, error) in
            guard error == nil else {
                completion(STResponseBLL(data: nil, error: STErrorBLL(validateError: nil , APIError: nil,networkError: NetworkErrorBLL(error: (error as NSError?)!))))
                return
            }
            if  response?.messageCode == 620 {
                completion(STResponseBLL(data: true, error:nil))
            }else {
                completion(STResponseBLL(data: nil, error: STErrorBLL(validateError: nil, APIError: StandardMessagesBLL(rawValue: response?.messageCode ?? 0),ErrorCode: response?.messageCode)))
            }
        }
    }
    /// This Function to get not rted orders For brand Id
    ///
    /// - Parameters:
    ///   - requestOrders: brand Id
    ///   - completion: this returns not rated orders 
    public func getCustomerNotRatedOrders(_ requestOrders: IRequestDTODAL, completion: @escaping onSuccessBLL) {
        //API
        let request = UserRouteBLL.getNotRatedOrders(requestOrderDTO: requestOrders)
        network.sendRequest(request) { (response, error) in
            guard error == nil else {
                completion(STResponseBLL(data: nil, error: STErrorBLL(validateError: nil , APIError: nil,networkError: NetworkErrorBLL(error: (error as NSError?)!))))
                return
            }
            if response?.statusCode == 200 && response?.messageCode == 601 {
                guard let json = response?.data else {
                    completion(STResponseBLL(data: nil, error: STErrorBLL(validateError: nil , APIError: StandardMessagesBLL.faildParseJson)))
                    return
                }
                let order =  try! OrderListDTODAL.init(json: json)
                completion(STResponseBLL(data: order, error:nil))
            }else {
                completion(STResponseBLL(data: nil, error: STErrorBLL(validateError: nil, APIError: StandardMessagesBLL(rawValue: response?.messageCode ?? 0),ErrorCode: response?.messageCode)))
            }
        }
    }
    /// This Function to Send Verify Code to Phone number
    ///
    /// - Parameters:
    ///   - phoneNumber: User phone number
    ///   - completion: this returns verify code or fail send verification code

    public  func sendVerifyCodeViaFireBase(_ authDTO: IAuthPhoneNumberDTODAL,completion: @escaping onSuccessBLL) {
        //validate data
        let validationDTO = VerificationCodeValidationDTOBLL()
        let validation = VerificationCodeValidationManagerBLL(errorModel: validationDTO)
        
        guard validation.validate(model: authDTO) else {
            completion(STResponseBLL(data: nil,error: STErrorBLL(validateError: validationDTO, APIError: nil)))
            return
        }
        completion(STResponseBLL(data: true, error:nil))
        //API
        let phoneNumber = "\(authDTO.dialCode.value ?? "+2")\(authDTO.mobile.value ?? "")"
    }
    public func validateVerifificationCode(_ authDTO: IAuthPhoneNumberDTODAL, completion: @escaping onSuccessBLL) {
        //validate data
               let validationDTO = VerificationCodeValidationDTOBLL()
               let validation = VerificationCodeValidationManagerBLL(errorModel: validationDTO)
               
               guard validation.validate(model: authDTO) else {
                   completion(STResponseBLL(data: nil,error: STErrorBLL(validateError: validationDTO, APIError: nil)))
                   return
               }
                completion(STResponseBLL(data: true, error:nil))
    }
    public func checkVerifyCodeViaFireBase(_ authDTO: IAuthPhoneNumberDTODAL,completion: @escaping onSuccessBLL){
        //validate data
        let validationDTO = VerificationCodeValidationDTOBLL()
        let validation = VerificationCodeValidationManagerBLL(errorModel: validationDTO)
        
        guard validation.validate(model: authDTO) else {
            completion(STResponseBLL(data: nil,error: STErrorBLL(validateError: validationDTO, APIError: nil)))
            return
        }
         completion(STResponseBLL(data: true, error:nil))
    }
}
