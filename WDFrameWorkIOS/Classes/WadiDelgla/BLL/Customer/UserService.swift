//
//  UserAuthenticationServices.swift
//  Netwroking
//
//  Created by SimpleTouch on 9/22/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Alamofire
////import DAL
public typealias onSuccessBLL = (STResponseBLL?) -> ()
//MARK:- User
public protocol UserServiceBLL :AnyObject {
    func register(_ registerDTO:IRegisterDTODAL,hintNumber: String?,completion: @escaping onSuccessBLL)
    func login(_ loginDTO: ILoginDTODAL,_ hintNumber: String?,completion: @escaping onSuccessBLL)
    func login(_ model: ILoginModelDAL,type: LoginTypeBLL,completion: @escaping onSuccessBLL)
    func resetPassword(_ resetPasswordDTO: IResetPasswordDTODAL,completion: @escaping onSuccessBLL)
    func updateUser(_ userDTO: IUserDTODAL,completion: @escaping onSuccessBLL)
    func updatePassword(_ passwordDTO: INewPasswordDTODAL,_ brandId: Int,completion: @escaping onSuccessBLL)
    func updateMobileToken(_ userId: String,_ brandId:Int,completion: @escaping onSuccessBLL)
    func checkVerifyCode(_ verifyDTO: IVerificationCodeDTODAL, completion: @escaping onSuccessBLL)
    func getTopReferralsCustomer(completion: @escaping onSuccessBLL)
    func gainRewardsByQR(_ cipherCode: String,completion: @escaping onSuccessBLL)
    func registerToBrandByReferralCode(_ shareCode: String,_ brandId : Int,completion: @escaping onSuccessBLL)
    func getCustomerPreviousOrders(_ requestOrders: IRequestDTODAL,completion: @escaping onSuccessBLL)
    func getCustomerAddresses(_ brandId:Int,completion: @escaping onSuccessBLL)
    func getCustomerAddressesByAreaId(_ areaId: String,_ brandId: Int,completion: @escaping onSuccessBLL)
    func addCustomerAddress(_ addressDTO: IUserAddressDTODAL,completion: @escaping onSuccessBLL)
    func updateCustomerAddress(_ addressDTO: IUserAddressDTODAL,completion: @escaping onSuccessBLL)
    func getCustomerOrderDetails(_ customerHistoryId: Int,completion: @escaping onSuccessBLL)
    func registerUserInBrand(_ brandId: Int,completion: @escaping onSuccessBLL)
    func getCustomerNotRatedOrders(_ requestOrders: IRequestDTODAL,completion: @escaping onSuccessBLL)
//    func sendVerifyCodeViaFireBase(_ authDTO: IAuthPhoneNumberDTO,completion: @escaping onSuccess)
//    func checkVerifyCodeViaFireBase(_ authDTO: IAuthPhoneNumberDTO,completion: @escaping onSuccess)
    func validateVerifificationCode(_ authDTO: IAuthPhoneNumberDTODAL,completion: @escaping onSuccessBLL)
    
    func validateCustomer(_ phoneNumber: String,_ countryId: String?,_ brandId: Int, completion: @escaping onSuccessBLL)
    func checkValidatePasswordDTO(_ resetPasswordDTO: IResetPasswordDTODAL,completion: @escaping onSuccessBLL)
    func getUser(_ phoneNumber: String,_ brandId: Int,completion: @escaping onSuccessBLL)
}
 
