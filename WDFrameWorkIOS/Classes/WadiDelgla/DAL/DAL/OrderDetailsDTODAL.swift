//
//  OrderDetailsDTO.swift
//  DAL
//
//  Created by SimpleTouch on 11/14/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
//import SwiftyJSON
public class OrderDetailsDTODAL :IOrderDetailsDTODAL{
    public var brandName: Observable<String?> = Observable<String?>(nil)
    
    public var brandLogo: Observable<String?> = Observable<String?>(nil)
    
    public var currencyCode: Observable<String?> = Observable<String?>(nil)
    
    public var orderTotal: Observable<Float?> = Observable<Float?>(nil)
    
    public var subTotal: Observable<Float?> = Observable<Float?>(nil)
    
    public var totalDiscount: Observable<Float?> = Observable<Float?>(nil)
    
    public var loyaltyDiscount: Observable<Float?> = Observable<Float?>(nil)
    
    public var couponDiscount: Observable<Float?> = Observable<Float?>(nil)
    
    public var deliveryFees: Observable<Float?> = Observable<Float?>(nil)
    
    public var totalTax: Observable<Float?> = Observable<Float?>(nil)
    
    public var isRewardProgramIdValid: Observable<Bool?> = Observable<Bool?>(nil)
    
 
    public init(){}
    
    enum CodingKeys: String, CodingKey {
        case BrandLogo = "BrandLogo"
        case BrandName = "BrandName"
        case CurrencyCode = "CurrencyCode"
        case OrderTotal = "OrderTotal"
        case SubTotal = "SubTotal"
        case TotalDiscount = "TotalDiscount"
        case LoyaltyDiscount = "LoyaltyDiscount"
        case CouponDiscount = "CouponDiscount"
        case TotalTax = "TotalTax"
        case DeliveryFees = "DeliveryFees"
        case IsRewardProgramIdValid = "IsRewardProgramIdValid"
    }
    public init(json:JSON)   {
        self.brandName.value = json[CodingKeys.BrandName.rawValue].stringValue
        self.brandLogo.value = json[CodingKeys.BrandLogo.rawValue].stringValue
        self.currencyCode.value = json[CodingKeys.CurrencyCode.rawValue].stringValue
        self.orderTotal.value = json[CodingKeys.OrderTotal.rawValue].floatValue
        self.subTotal.value = json[CodingKeys.SubTotal.rawValue].floatValue
        self.totalDiscount.value = json[CodingKeys.TotalDiscount.rawValue].floatValue
        self.loyaltyDiscount.value = json[CodingKeys.LoyaltyDiscount.rawValue].floatValue
        self.couponDiscount.value = json[CodingKeys.CouponDiscount.rawValue].floatValue
        self.totalTax.value = json[CodingKeys.TotalTax.rawValue].floatValue
        self.deliveryFees.value = json[CodingKeys.DeliveryFees.rawValue].floatValue
        self.isRewardProgramIdValid.value = json[CodingKeys.IsRewardProgramIdValid.rawValue].boolValue
    }
    
    
    
}
