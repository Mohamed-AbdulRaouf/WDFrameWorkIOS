//
//  OrderItemChoiceDTO.swift
//  DAL
//
//  Created by SimpleTouch on 11/14/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
//import SwiftyJSON
public class OrderItemChoiceDTODAL :IOrderItemChoiceDTODAL{
    public var orderDetailID: Observable<Int?> = Observable<Int?>(nil)
    
    public var choiceId: Observable<Int?> = Observable<Int?>(nil)
    
    public var choiceName: Observable<String?> = Observable<String?>(nil)
    
    public var choiceTotal: Observable<Float?> = Observable<Float?>(nil)
    
    public var choicePrice: Observable<Float?> = Observable<Float?>(nil)
    
    public var choiceQTY: Observable<Int?> = Observable<Int?>(nil)
    
    public var specialTax: Observable<Float?> = Observable<Float?>(nil)
    
    public var currencyCode: Observable<String?> = Observable<String?>(nil)
    
    
    public init(){}
    
    enum CodingKeys: String, CodingKey {
        case OrderDetailID = "OrderDetailID"
        case ID = "ID"
        case ChoiceName = "ChoiceName"
        case ChoiceTotal = "ChoiceTotal"
        case Price = "Price"
        case QTY = "Qty"
        case SpecialTax = "SpecialTax"
        case CurrencyCode = "CurrencyCode"
     }
    public init(json:JSON)   {
        self.orderDetailID.value = json[CodingKeys.OrderDetailID.rawValue].intValue
        self.choiceId.value = json[CodingKeys.ID.rawValue].intValue
        self.choiceName.value = json[CodingKeys.ChoiceName.rawValue].stringValue
        self.choiceTotal.value = json[CodingKeys.ChoiceTotal.rawValue].floatValue
        self.choicePrice.value = json[CodingKeys.Price.rawValue].floatValue
        self.choiceQTY.value = json[CodingKeys.QTY.rawValue].intValue
        self.specialTax.value = json[CodingKeys.SpecialTax.rawValue].floatValue
        self.currencyCode.value = json[CodingKeys.CurrencyCode.rawValue].stringValue        
    }
    
    
    
}
