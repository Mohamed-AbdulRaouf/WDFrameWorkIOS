//
//  MenuSizeDTO.swift
//  DAL
//
//  Created by SimpleTouch on 11/13/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
//import SwiftyJSON
public  class MenuSizeDTODAL : IMenuSizeDTODAL{
    public var sizeId: Observable<Int?> = Observable<Int?>(nil)
    
    public var itemId: Observable<Int?> = Observable<Int?>(nil)
    
    public var sizeCode: Observable<String?> = Observable<String?>(nil)
    
    public var sizeName: Observable<String?> = Observable<String?>(nil)
    
    public var sizePrice: Observable<Float?> = Observable<Float?>(nil)
    
    public var currencyCode: Observable<String?> = Observable<String?>(nil)
    
    public var isSelected: Observable<Bool?> = Observable<Bool?>(nil)
    
    public var choiceGroups: Observable<[IChoiceGroupsDTODAL]?> = Observable<[IChoiceGroupsDTODAL]?>(nil)
      
    public init(){}
    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case ItemID = "ItemID"
        case Code = "Code"
        case Name = "Name"
        case Price = "Price"
        case ChoiceGroups = "ChoiceGroups"
        case CurrencyCode = "CurrencyCode"
        case IsSelected = "IsSelected"
    }
    public init(json: JSON)  {
        self.sizeId.value = json[CodingKeys.id.rawValue].intValue
        self.itemId.value =  json[CodingKeys.ItemID.rawValue].intValue
        self.sizeCode.value = json[CodingKeys.Code.rawValue].string
        self.sizeName.value = json[CodingKeys.Name.rawValue].stringValue
        self.sizePrice.value = json[CodingKeys.Price.rawValue].floatValue
        self.currencyCode.value = json[CodingKeys.CurrencyCode.rawValue].string
        self.isSelected.value = false
        self.choiceGroups.value = json[CodingKeys.ChoiceGroups.rawValue].arrayValue.map({try! ChoiceGroupsDTODAL.init(json: $0)})
    }
    public init(sizeId: Int?,itemId: Int?,sizeCode: String?,sizeName: String?,sizePrice: Float?,currencyCode: String?,isSelected: Bool?,choiceGroups: [IChoiceGroupsDTODAL]?){
        self.sizeId.value = sizeId
        self.itemId.value =  itemId
        self.sizeCode.value = sizeCode
        self.sizeName.value = sizeName
        self.sizePrice.value = sizePrice
        self.currencyCode.value = currencyCode
        self.isSelected.value = isSelected
        self.choiceGroups.value = choiceGroups
    }
    public  func copy() -> Any{
        let copy = MenuSizeDTODAL(sizeId: sizeId.value, itemId: itemId.value, sizeCode: sizeCode.value, sizeName: sizeName.value, sizePrice: sizePrice.value, currencyCode: currencyCode.value, isSelected: isSelected.value, choiceGroups:  choiceGroups.value?.map({$0.copy() as! IChoiceGroupsDTODAL}))
        return copy
    }
}
