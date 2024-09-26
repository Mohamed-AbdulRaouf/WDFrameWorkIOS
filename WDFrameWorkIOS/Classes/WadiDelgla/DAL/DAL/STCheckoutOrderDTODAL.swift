//
//  STCheckoutOrderDTO.swift
//  DAL
//
//  Created by SimpleTouch on 11/20/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
//import SwiftyJSON
public class STCheckoutOrderDTODAL : Codable, ISTCheckoutOrderDTODAL  {
    
    public var brandId: Int = 0
    
    public var isOnlinePayment: Bool? = false
    
    public var isBrandDeliveryAtStore: Bool? = false
    
    public var brandImage: String = ""
    
    public var brandName: String = ""
    
    public var allowCouponRedeem: Bool = false
    
    public var currencyCode: String = ""
    
    public var deliveryFees: Double = 0.0
    
    public var discountAmount: Double = 0.0
    
    public var equivalentAmount: Double = 0.0
    
    public var isDeliveryFeesPercent: Bool = false
    
    public var maxRedeemAmount: Float = 0
    
    public var minOrderToDeliver: Float = 0
    
    public var minRedeemAmount: Float = 0
    
    public var myPoints: Int = 0
    
    public var couponCode: String = ""
    
    public var redeemPointsAmount: Int = 0
    
    public var selectedAreaId: Int = 0
    
    public var selectedAreaName: String = ""
    
    public var isCustomerRegisterInBrand: Bool = false
    
    public var isCurrentRewardIdValid: Bool = false
    
    public var selectedAddressId: Int = 0
    
    public var isUserLogin: Bool = false
    
    public var userAddressDetails: String = ""
    
    public var cartItems: [STCartItemDTODAL] = []
    
    public var orderComment: String = ""
    
    public var orderPaymentTypeId: Int = 1
    
    public var isSelectDeliveryAtStore: Bool = false
    
    public var frontOrderReferenceId: String? = ""
    
    public var phone2: String? = ""
    public var merchantRefNumber: String? = ""
    public var referenceNumber: String? = ""
    public var referenceTransactionId: String = ""
    public var referenceInvoiceId: String = ""
    
    
    public  init(){ }
    
    
    enum CodingKeys: String, CodingKey {
        case brandId = "brandId"
        case brandImage = "brandImage"
        case brandName = "brandName"
        case allowCouponRedeem = "allowCouponRedeem"
        case currencyCode = "currencyCode"
        case discountAmount = "discountAmount"
        case equivalentAmount = "equivalentAmount"
        case maxRedeemAmount = "maxRedeemAmount"
        case isDeliveryFeesPercent = "isDeliveryFeesPercent"
        case minOrderToDeliver = "minOrderToDeliver"
        case minRedeemAmount = "minRedeemAmount"
        case myPoints = "myPoints"
        case couponCode = "couponCode"
        case redeemPointsAmount = "redeemPointsAmount"
        case selectedAreaId = "selectedAreaId"
        case selectedAreaName = "selectedAreaName"
        case isCustomerRegisterInBrand = "isCustomerRegisterInBrand"
        case isCurrentRewardIdValid = "isCurrentRewardIdValid"
        case selectedAddressId = "selectedAddressId"
        case cartItems = "cartItems"
        case isUserLogin = "isUserLogin"
        case userAddressDetails = "UserAddress"
        case orderComment = "OrderComment"
        case orderPaymentTypeId = "orderPaymentTypeId"
        case isOnlinePayment = "isOnlinePayment"
        case isBrandDeliveryAtStore = "isBrandDeliveryAtStore"
        case isSelectDeliveryAtStore = "isSelectDeliveryAtStore"
        case frontOrderReferenceId = "FrontOrderReferenceId"
        case phone2 = "Phone2"
        case merchantRefNumber = "merchantRefNumber"
        case referenceNumber = "referenceNumber"
        case referenceTransactionId = "ReferenceTransactionId"
        case referenceInvoiceId = "ReferenceInvoiceId"
    }
    
    
    public  func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(orderComment, forKey: .orderComment)
        try container.encode(brandId, forKey: .brandId)
        try container.encode(brandImage, forKey: .brandImage)
        try container.encode(brandName, forKey: .brandName)
        try container.encode(allowCouponRedeem, forKey: .allowCouponRedeem)
        try container.encode(currencyCode, forKey: .currencyCode)
        try container.encode(discountAmount, forKey: .discountAmount)
        try container.encode(equivalentAmount, forKey: .equivalentAmount)
        try container.encode(isDeliveryFeesPercent, forKey: .isDeliveryFeesPercent)
        try container.encode(maxRedeemAmount, forKey: .maxRedeemAmount)
        try container.encode(minOrderToDeliver, forKey: .minOrderToDeliver)
        try container.encode(minRedeemAmount, forKey: .minRedeemAmount)
        try container.encode(myPoints, forKey: .myPoints)
        try container.encode(couponCode, forKey: .couponCode)
        try container.encode(redeemPointsAmount, forKey: .redeemPointsAmount)
        try container.encode(selectedAreaId, forKey: .selectedAreaId)
        try container.encode(selectedAreaName, forKey: .selectedAreaName)
        try container.encode(isCustomerRegisterInBrand, forKey: .isCustomerRegisterInBrand)
        try container.encode(isCurrentRewardIdValid, forKey: .isCurrentRewardIdValid)
        try container.encode(selectedAddressId, forKey: .selectedAddressId)
        try container.encode(isUserLogin, forKey: .isUserLogin)
        try container.encode(userAddressDetails, forKey: .userAddressDetails)
        try container.encode(cartItems, forKey: .cartItems)
        try container.encode(orderPaymentTypeId, forKey: .orderPaymentTypeId)
        try container.encode(isOnlinePayment, forKey: .isOnlinePayment)
        try container.encode(isBrandDeliveryAtStore, forKey: .isBrandDeliveryAtStore)
        try container.encode(isSelectDeliveryAtStore, forKey: .isSelectDeliveryAtStore)
        try container.encode(frontOrderReferenceId, forKey: .frontOrderReferenceId)
        try container.encode(phone2, forKey: .phone2)
        try container.encode(merchantRefNumber, forKey: .merchantRefNumber)
        try container.encode(referenceNumber, forKey: .referenceNumber)
        try container.encode(referenceTransactionId, forKey: .referenceTransactionId)
        try container.encode(referenceInvoiceId, forKey: .referenceInvoiceId)
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        brandId = try container.decode(Int.self, forKey: .brandId)
        brandImage = try container.decode(String.self, forKey: .brandImage)
        brandName = try container.decode(String.self, forKey: .brandName)
        allowCouponRedeem = try container.decode(Bool.self, forKey: .allowCouponRedeem)
        currencyCode = try container.decode(String.self, forKey: .currencyCode)
        discountAmount = try container.decode(Double.self, forKey: .discountAmount)
        equivalentAmount = try container.decode(Double.self, forKey: .equivalentAmount)
        isDeliveryFeesPercent = try container.decode(Bool.self, forKey: .isDeliveryFeesPercent)
        maxRedeemAmount = try container.decode(Float.self, forKey: .maxRedeemAmount)
        minOrderToDeliver = try container.decode(Float.self, forKey: .minOrderToDeliver)
        myPoints = try container.decode(Int.self, forKey: .myPoints)
        couponCode = try container.decode(String.self, forKey: .couponCode)
        redeemPointsAmount = try container.decode(Int.self, forKey: .redeemPointsAmount)
        selectedAreaId = try container.decode(Int.self, forKey: .selectedAreaId)
        selectedAreaName = try container.decode(String.self, forKey: .selectedAreaName)
        isCustomerRegisterInBrand = try container.decode(Bool.self, forKey: .isCustomerRegisterInBrand)
        isCurrentRewardIdValid = try container.decode(Bool.self, forKey: .isCurrentRewardIdValid)
        selectedAddressId = try container.decode(Int.self, forKey: .selectedAddressId)
        userAddressDetails = try container.decode(String.self, forKey: .userAddressDetails)
        isUserLogin = try container.decode(Bool.self, forKey: .isUserLogin)
        cartItems = try container.decode([STCartItemDTODAL].self, forKey: .cartItems)
        orderComment = try container.decode(String.self, forKey: .orderComment)
        orderPaymentTypeId = try container.decode(Int.self, forKey: .orderPaymentTypeId)
        isOnlinePayment =  try container.decode(Bool.self, forKey: .isOnlinePayment)
        isBrandDeliveryAtStore = try container.decode(Bool.self, forKey: .isBrandDeliveryAtStore)
        isSelectDeliveryAtStore = try container.decode(Bool.self, forKey: .isSelectDeliveryAtStore)
        frontOrderReferenceId = try container.decode(String.self, forKey: .frontOrderReferenceId)
        phone2 = try container.decode(String.self, forKey: .phone2)
        merchantRefNumber = try container.decode(String.self, forKey: .merchantRefNumber)
        referenceNumber = try container.decode(String.self, forKey: .referenceNumber)
        referenceTransactionId = try container.decode(String.self, forKey: .referenceTransactionId)
        referenceInvoiceId = try container.decode(String.self, forKey: .referenceInvoiceId)
    }
    
    enum CALCCodingKeys: String, CodingKey {
        case CustomerMessage = "CustomerMessage"
        case AreaID = "AreaID"
        case UserAddressId = "UserAddressId"
        case RedeemPoints = "RedeemPoints"
        case CouponCode = "CouponCode"
        case brandId = "brandId"
        case orderCalcs = "orderCalcs"
        case orderComment = "OrderComment"
        case orderPaymentTypeId = "orderPaymentTypeId"
        case deliveryAtStore = "DeliveryAtStore"
        case frontOrderReferenceId = "FrontOrderReferenceId"
        case phone2 = "Phone2"
        case merchantRefNumber = "merchantRefNumber"
        case referenceNumber = "referenceNumber"
        case referenceTransactionId = "ReferenceTransactionId"
        case referenceInvoiceId = "ReferenceInvoiceId"
    }
    public  var JSONRepresentation: Dictionary<String, Any>  {
        var jsonedDict = [String:Any]()
        jsonedDict[CALCCodingKeys.CustomerMessage.rawValue] = ""
        jsonedDict[CALCCodingKeys.AreaID.rawValue] = selectedAreaId
        jsonedDict[CALCCodingKeys.UserAddressId.rawValue] = selectedAddressId
        jsonedDict[CALCCodingKeys.RedeemPoints.rawValue] = redeemPointsAmount
        jsonedDict[CALCCodingKeys.brandId.rawValue] = brandId
        jsonedDict[CALCCodingKeys.CouponCode.rawValue] = couponCode
        jsonedDict[CALCCodingKeys.orderComment.rawValue] = orderComment
        jsonedDict[CALCCodingKeys.orderPaymentTypeId.rawValue] = orderPaymentTypeId
        jsonedDict[CALCCodingKeys.deliveryAtStore.rawValue] = isSelectDeliveryAtStore
        jsonedDict[CALCCodingKeys.frontOrderReferenceId.rawValue] = frontOrderReferenceId
        jsonedDict[CALCCodingKeys.phone2.rawValue] = UserDefaults.orderPhone
        jsonedDict[CALCCodingKeys.merchantRefNumber.rawValue] = merchantRefNumber
        jsonedDict[CALCCodingKeys.referenceNumber.rawValue] = referenceNumber
        jsonedDict[CALCCodingKeys.referenceTransactionId.rawValue] = referenceTransactionId
        jsonedDict[CALCCodingKeys.referenceInvoiceId.rawValue] = referenceInvoiceId
        if cartItems.count > 0 {
            jsonedDict[CALCCodingKeys.orderCalcs.rawValue] = cartItems.map({$0.CALCJSONRepresentation})
        }
        return jsonedDict
    }
    
}
