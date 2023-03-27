//
//  OrderItemDTO.swift
//  DAL
//
//  Created by SimpleTouch on 11/14/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
//import SwiftyJSON
public class OrderItemDTODAL : IOrderItemDTODAL{
    public var currencyCode: Observable<String?> = Observable<String?>(nil)
    
    public var orderDetailID: Observable<Int?> = Observable<Int?>(nil)
    
    public var itemId: Observable<Int?> = Observable<Int?>(nil)
    
    public var itemTitle: Observable<String?> = Observable<String?>(nil)
    
    public var itemQty: Observable<Int?> = Observable<Int?>(nil)
    
    public var itemPrice: Observable<Float?> = Observable<Float?>(nil)
    
    public var itemTotal: Observable<Float?> = Observable<Float?>(nil)
    
    public var sizeName: Observable<String?> = Observable<String?>(nil)
    
    public var couponTotalDiscount: Observable<Float?> = Observable<Float?>(nil)
    
    public var couponDiscountApply: Observable<Float?> = Observable<Float?>(nil)
    
    public var specialTax: Observable<Float?> = Observable<Float?>(nil)
    
    public var isItemHasChoices: Observable<Bool?> = Observable<Bool?>(nil)
    
    public var itemChoices: Observable<[IOrderItemChoiceDTODAL]?> = Observable<[IOrderItemChoiceDTODAL]?>(nil)
    
    public var itemImage: Observable<String?> = Observable<String?>(nil)
    
    public var imagePath: Observable<String?> = Observable<String?>(nil)
    public init(){}
    
    enum CodingKeys: String, CodingKey {
        case CurrencyCode = "CurrencyCode"
        case OrderDetailID = "OrderDetailID"
        case ItemID = "ItemID"
        case ItemTitle = "ItemTitle"
        case ItemQty = "ItemQty"
        case ItemPrice = "ItemPrice"
        case ItemTotal = "ItemTotal"
        case SizeName = "SizeName"
        case CouponTotalDiscount = "CouponTotalDiscount"
        case CouponDiscountApply = "CouponDiscountApply"
        case SpecialTax = "SpecialTax"
        case IsItemHasChoices = "IsItemHasChoices"
        case ItemChoices = "ItemChoices"
        case ItemImage = "ItemImage"
        case ImagePath = "ImagePath"
    }
    public init(json:JSON)   {
        self.currencyCode.value = json[CodingKeys.CurrencyCode.rawValue].stringValue
        self.orderDetailID.value = json[CodingKeys.OrderDetailID.rawValue].intValue
        self.itemId.value = json[CodingKeys.ItemID.rawValue].intValue
        self.itemTitle.value = json[CodingKeys.ItemTitle.rawValue].stringValue
        self.itemQty.value = json[CodingKeys.ItemQty.rawValue].intValue
        self.itemPrice.value = json[CodingKeys.ItemPrice.rawValue].floatValue
        self.itemTotal.value = json[CodingKeys.ItemTotal.rawValue].floatValue
        self.sizeName.value = json[CodingKeys.SizeName.rawValue].stringValue
        self.couponTotalDiscount.value = json[CodingKeys.CouponTotalDiscount.rawValue].floatValue
        self.couponDiscountApply.value = json[CodingKeys.CouponDiscountApply.rawValue].floatValue
        self.specialTax.value = json[CodingKeys.SpecialTax.rawValue].floatValue
        self.isItemHasChoices.value = json[CodingKeys.IsItemHasChoices.rawValue].boolValue
        self.itemChoices.value = json[CodingKeys.ItemChoices.rawValue].arrayValue.map({try! OrderItemChoiceDTODAL.init(json: $0)})
        self.itemImage.value = json[CodingKeys.ItemImage.rawValue].stringValue
        self.imagePath.value = json[CodingKeys.ImagePath.rawValue].stringValue
    }
}
