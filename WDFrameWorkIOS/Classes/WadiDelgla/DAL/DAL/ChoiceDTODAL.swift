//
//  ChoiceDTO.swift
//  DAL
//
//  Created by SimpleTouch on 11/13/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
import SwiftyJSON
public  class ChoiceDTODAL : IChoiceDTODAL{
 
    public var choiceId: Observable<Int?> = Observable<Int?>(nil)
    
    public var choiceName: Observable<String?> = Observable<String?>(nil)
    
    public var choicePrice: Observable<Float?> = Observable<Float?>(nil)
    
    public var isSelectedChoice: Observable<Bool?> = Observable<Bool?>(nil)
    
    public var currencyCode: Observable<String?> = Observable<String?>(nil)
    
    public var itemChoiceSizeID: Observable<Int?> = Observable<Int?>(nil)
    
 
    public init(){}
    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case Name = "Name"
        case Price = "Price"
        case ItemChoiceSizeID = "ItemChoiceSizeID"
        case CurrencyCode = "CurrencyCode"
    }
    public init(json: JSON)  {
        self.choiceId.value = json[CodingKeys.id.rawValue].intValue
        self.choiceName.value =  json[CodingKeys.Name.rawValue].stringValue
        self.choicePrice.value = json[CodingKeys.Price.rawValue].floatValue
        self.itemChoiceSizeID.value = json[CodingKeys.ItemChoiceSizeID.rawValue].intValue
        self.currencyCode.value =  json[CodingKeys.CurrencyCode.rawValue].stringValue
        self.isSelectedChoice.value = false
    }
    public init(choiceId: Int?,choiceName: String?,choicePrice: Float?,itemChoiceSizeID: Int?,currencyCode: String?,isSelectedChoice: Bool?){
        self.choiceId.value = choiceId
        self.choiceName.value =  choiceName
        self.choicePrice.value = choicePrice
        self.itemChoiceSizeID.value = itemChoiceSizeID
        self.currencyCode.value =  currencyCode
        self.isSelectedChoice.value = isSelectedChoice

    }
   
    public  func copy() -> Any{
        let copy = ChoiceDTODAL(choiceId: choiceId.value, choiceName: choiceName.value, choicePrice: choicePrice.value, itemChoiceSizeID: itemChoiceSizeID.value, currencyCode: currencyCode.value, isSelectedChoice: isSelectedChoice.value)
        return copy
    }
    
}
