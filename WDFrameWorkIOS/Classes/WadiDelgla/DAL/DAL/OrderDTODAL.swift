//
//  OrderDTO.swift
//  DAL
//
//  Created by Nermeen Mohamed on 10/31/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
//import SwiftyJSON
public class OrderDTODAL :IOrderDTODAL{
    public var brandId: Observable<Int?>  = Observable<Int?>(nil)
    
    public var brandName: Observable<String?> = Observable<String?>(nil)
    
    public var brandLogoURL: Observable<String?> = Observable<String?>(nil)
    
    public var currencyCode: Observable<String?> = Observable<String?>(nil)
    
    public var customerHistoryId: Observable<Int?> = Observable<Int?>(nil)
    
    public var orderNumber: Observable<Int?> = Observable<Int?>(nil)
    
    public var rating: Observable<Float?> = Observable<Float?>(nil)
    
    public var orderTotal: Observable<Double?> = Observable<Double?>(nil)
    
    public var orderDate: Observable<String?> = Observable<String?>(nil)
    
    public var isBrandHasRatingItems: Observable<Bool?> = Observable<Bool?>(nil)
    
    public var isOrderRatedBefore: Observable<Bool?> = Observable<Bool?>(nil)
    
    public var isCanceled: Observable<Bool?> = Observable<Bool?>(nil)
    
    public var orderSourceId: Observable<Int?> = Observable<Int?>(nil)
    
    public var orderSourceName: Observable<String?> = Observable<String?>(nil)
    
    public var orderStatusId: Observable<Int?> = Observable<Int?>(nil)
    
    public var orderStatus: Observable<String?> = Observable<String?>(nil)
    
    public var color: Observable<String?> = Observable<String?>(nil)
    
    public var colorCode: Observable<String?> = Observable<String?>(nil)
    
    public var isOrderStatusValidToRate: Observable<Bool?> = Observable<Bool?>(nil)
    
    public var isOrderHasDetails: Observable<Bool?> = Observable<Bool?>(nil)
    
    
    public init(){}
    
    enum CodingKeys: String, CodingKey {
        case brandId = "BrandID"
        case brandName = "BrandName"
        case logo = "Logo"
        case currencyCode = "CurrencyCode"
        case customerHistoryId = "CustomerHistoryId"
        case orderNumber = "OrderNumber"
        case rating = "Rating"
        case orderTotal = "OrderTotal"
        case orderDate = "OrderDate"
        case isOrderRatedBefore = "IsOrderRatedBefore"
        case isBrandHasRatingItems = "IsBrandHasRatingItems"
        case isCanceled = "IsCanceled"
        case orderSourceId = "OrderSourceId"
        case orderSourceName = "OrderSourceName"
        case orderStatusId = "OrderStatusId"
        case orderStatus = "OrderStatus"
        case color = "Color"
        case colorCode = "ColorCode"
        case isOrderStatusValidToRate = "IsOrderStatusValidToRate"
        case isOrderHasDetails = "IsOrderHasDetails"
    }
   public init(json:JSON)   {
        brandId.value = json[CodingKeys.brandId.rawValue].intValue
        brandName.value = json[CodingKeys.brandName.rawValue].stringValue
        brandLogoURL.value = json[CodingKeys.logo.rawValue].stringValue
        currencyCode.value = json[CodingKeys.currencyCode.rawValue].stringValue
        customerHistoryId.value = json[CodingKeys.customerHistoryId.rawValue].intValue
        orderNumber.value = json[CodingKeys.orderNumber.rawValue].intValue
        rating.value = json[CodingKeys.rating.rawValue].floatValue
        orderTotal.value = json[CodingKeys.orderTotal.rawValue].doubleValue
        orderDate.value = json[CodingKeys.orderDate.rawValue].stringValue
        isOrderRatedBefore.value = json[CodingKeys.isOrderRatedBefore.rawValue].boolValue
        isBrandHasRatingItems.value = json[CodingKeys.isBrandHasRatingItems.rawValue].boolValue
        isCanceled.value = json[CodingKeys.isCanceled.rawValue].boolValue
        orderSourceId.value = json[CodingKeys.orderSourceId.rawValue].intValue
        orderSourceName.value = json[CodingKeys.orderSourceName.rawValue].stringValue
        orderStatusId.value = json[CodingKeys.orderStatusId.rawValue].intValue
        orderStatus.value = json[CodingKeys.orderStatus.rawValue].stringValue
        color.value = json[CodingKeys.color.rawValue].stringValue
        colorCode.value = json[CodingKeys.colorCode.rawValue].stringValue
        isOrderStatusValidToRate.value = json[CodingKeys.isOrderStatusValidToRate.rawValue].boolValue
        isOrderHasDetails.value = json[CodingKeys.isOrderHasDetails.rawValue].boolValue

    }
   
    
    
}
