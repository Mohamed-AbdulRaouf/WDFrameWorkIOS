//
//  CalOrderResponseDTO.swift
//  DAL
//
//  Created by SimpleTouch on 11/21/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
import SwiftyJSON
public class CalOrderResponseDTODAL :ICalOrderResponseDTODAL{
    public var orderId: Observable<Int?> = Observable<Int?>(nil)
    
    public var pointEquivalent: Observable<Int?> = Observable<Int?>(nil)
    
    public var isCurrentRewardIdValid: Observable<Bool?> = Observable<Bool?>(nil)
    
    public var mobile: Observable<String?> = Observable<String?>(nil)
    
    public var currencyCode: Observable<String?> = Observable<String?>(nil)
    
    public var redeemPoint: Observable<Int?> = Observable<Int?>(nil)
    
    public var totalPay: Observable<Float?> = Observable<Float?>(nil)
    
    public var deliveryCharges: Observable<Float?> = Observable<Float?>(nil)
    
    public var discount: Observable<Float?> = Observable<Float?>(nil)
    
    public var taxAmount: Observable<Float?> = Observable<Float?>(nil)
    
    public var subTotal: Observable<Float?> = Observable<Float?>(nil)
    
    public var isMinOrderValueForCouponDicountValid: Observable<Bool?> = Observable<Bool?>(nil)
    
    public var minOrderValueForCouponDicount: Observable<Int?> = Observable<Int?>(nil)
    
    public var couponDicount: Observable<Float?> = Observable<Float?>(nil)
    
    public var loyaltyDiscount: Observable<Float?> = Observable<Float?>(nil)
    
    public var actualSubTotal: Observable<Float?> = Observable<Float?>(nil)
    
    public var itemsCount: Observable<Int?> = Observable<Int?>(nil)
    
    public var currentCustomerIsRegistered: Observable<Bool?> = Observable<Bool?>(nil)
    
    public var currentCustomerPointsInBrand: Observable<Int?> = Observable<Int?>(nil)
    
    public var equivalentPointsAmount: Observable<Float?> = Observable<Float?>(nil)
    
    public var minRedeemAmount: Observable<Float?> = Observable<Float?>(nil)
    
    public var maxRedeemAmount: Observable<Float?> = Observable<Float?>(nil)
    
    public var isOrderingOnlineAvailable: Observable<Bool?> = Observable<Bool?>(nil)
    
    public var orderComment: Observable<String?> = Observable<String?>(nil)
 
    public init(){}
    
    enum CodingKeys: String, CodingKey {
        case orderid = "orderid"
        case PointEquivalent = "PointEquivalent"
        case IsCurrentRewardIdValid = "IsCurrentRewardIdValid"
        case mobile = "mobile"
        case currencyCode = "currencyCode"
        case RedeemPoint = "RedeemPoint"
        case TotalPay = "TotalPay"
        case deliveryCharges = "deliveryCharges"
        case Discount = "Discount"
        case taxAmount = "taxAmount"
        case subTotal = "subTotal"
        case IsMinOrderValueForCouponDicountValid = "IsMinOrderValueForCouponDicountValid"
        case MinOrderValueForCouponDicount = "MinOrderValueForCouponDicount"
        case CouponDicount = "CouponDicount"
        case LoyaltyDiscount = "LoyaltyDiscount"
        case ActualSubTotal = "ActualSubTotal"
        case ItemsCount = "ItemsCount"
        case CurrentCustomerIsRegistered = "CurrentCustomerIsRegistered"
        case CurrentCustomerPointsInBrand = "CurrentCustomerPointsInBrand"
        case EquivalentPointsAmount = "EquivalentPointsAmount"
        case MinRedeemAmount = "MinRedeemAmount"
        case MaxRedeemAmount = "MaxRedeemAmount"
        case IsOrderingOnlineAvailable = "IsOrderingOnlineAvailable"
        case orderComment = "OrderComment"
    }
    public init(json:JSON)   {
        self.orderId.value = json[CodingKeys.orderid.rawValue].intValue
        self.pointEquivalent.value = json[CodingKeys.PointEquivalent.rawValue].intValue
        self.isCurrentRewardIdValid.value = json[CodingKeys.IsCurrentRewardIdValid.rawValue].boolValue
        self.mobile.value = json[CodingKeys.mobile.rawValue].stringValue
        self.currencyCode.value = json[CodingKeys.currencyCode.rawValue].stringValue
        self.redeemPoint.value = json[CodingKeys.RedeemPoint.rawValue].intValue
        self.totalPay.value = json[CodingKeys.TotalPay.rawValue].floatValue
        self.deliveryCharges.value = json[CodingKeys.deliveryCharges.rawValue].floatValue
        self.discount.value = json[CodingKeys.Discount.rawValue].floatValue
        self.taxAmount.value = json[CodingKeys.taxAmount.rawValue].floatValue
        self.subTotal.value = json[CodingKeys.subTotal.rawValue].floatValue
        self.isMinOrderValueForCouponDicountValid.value = json[CodingKeys.IsMinOrderValueForCouponDicountValid.rawValue].boolValue
        self.minOrderValueForCouponDicount.value = json[CodingKeys.MinOrderValueForCouponDicount.rawValue].intValue
        self.couponDicount.value = json[CodingKeys.CouponDicount.rawValue].floatValue
        self.loyaltyDiscount.value =  json[CodingKeys.LoyaltyDiscount.rawValue].floatValue
        self.actualSubTotal.value =  json[CodingKeys.ActualSubTotal.rawValue].floatValue
        self.itemsCount.value =  json[CodingKeys.ItemsCount.rawValue].intValue
        self.currentCustomerIsRegistered.value =  json[CodingKeys.CurrentCustomerIsRegistered.rawValue].boolValue
        self.currentCustomerPointsInBrand.value =  json[CodingKeys.CurrentCustomerPointsInBrand.rawValue].intValue
        self.equivalentPointsAmount.value =  json[CodingKeys.EquivalentPointsAmount.rawValue].floatValue
        self.minRedeemAmount.value =  json[CodingKeys.MinRedeemAmount.rawValue].floatValue
        self.maxRedeemAmount.value =  json[CodingKeys.MaxRedeemAmount.rawValue].floatValue
        self.isOrderingOnlineAvailable.value =  json[CodingKeys.IsOrderingOnlineAvailable.rawValue].boolValue
        self.orderComment.value = json[CodingKeys.orderComment.rawValue].stringValue
     }
    
    
    
}
