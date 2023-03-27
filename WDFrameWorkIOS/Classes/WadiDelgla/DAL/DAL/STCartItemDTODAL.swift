//
//  STCartItemDTO.swift
//  DAL
//
//  Created by SimpleTouch on 11/20/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
//import SwiftyJSON
public class STCartItemDTODAL:Codable, ISTCartItemDTODAL  {
    public var itemId: Int = 0
    
    public var itemName: String = ""
    
    public var sizeId: Int = 0
    
    public var sizeName: String = ""
    
    public var amount: Int = 0
    
    public var priceWithChoices: Double = 0.0
    
    public var itemPrice: Double = 0.0
    
    public var subTotal: Double = 0.0
    
    public var itemImage: String = ""
    
    public var itemSizeId: Int = 0
    
    public var itemSizeChoiceDetailsId: Int = 0
    
    public var itemComment: String = ""
    
    public var visualCode: String = ""
    
    public var itemCurrencyCode: String = ""
    
    public var choices: [STItemAttributeDTODAL] = []
    
    public init(){}
    
    enum ItemCodingKeys: String, CodingKey {
        case itemId = "itemId"
        case itemName = "itemName"
        case sizeId = "sizeId"
        case sizeName = "sizeName"
        case amount = "amount"
        case priceWithChoices = "priceWithChoices"
        case itemPrice = "itemPrice"
        case subTotal = "subTotal"
        case itemImage = "itemImage"
        case itemSizeId = "itemSizeId"
        case itemSizeChoiceDetailsId = "itemSizeChoiceDetailsId"
        case itemComment = "itemComment"
        case visualCode = "visualCode"
        case itemCurrencyCode = "itemCurrencyCode"
        case choices = "choices"
    }
    public func increament(){
        self.amount += 1
        self.subTotal = self.priceWithChoices * Double(self.amount)
    }
    public func decreament(){
        self.amount -= 1
        self.subTotal = self.priceWithChoices * Double(self.amount)
    }
    public func updateItemComment(_ comment: String) {
        self.itemComment = comment
    }
   
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: ItemCodingKeys.self)
        try container.encode(itemId, forKey: .itemId)
        try container.encode(itemName, forKey: .itemName)
        try container.encode(sizeId, forKey: .sizeId)
        try container.encode(sizeName, forKey: .sizeName)
        try container.encode(amount, forKey: .amount)
        try container.encode(priceWithChoices, forKey: .priceWithChoices)
        try container.encode(itemPrice, forKey: .itemPrice)
        try container.encode(subTotal, forKey: .subTotal)
        try container.encode(itemImage, forKey: .itemImage)
        try container.encode(itemSizeId, forKey: .itemSizeId)
        try container.encode(itemSizeChoiceDetailsId, forKey: .itemSizeChoiceDetailsId)
        try container.encode(itemComment, forKey: .itemComment)
        try container.encode(visualCode, forKey: .visualCode)
        try container.encode(itemCurrencyCode, forKey: .itemCurrencyCode)
        try container.encode(choices, forKey: .choices)
    }
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ItemCodingKeys.self)
        itemId = try container.decode(Int.self, forKey: .itemId)
        itemName = try container.decode(String.self, forKey: .itemName)
        sizeId = try container.decode(Int.self, forKey: .sizeId)
        sizeName = try container.decode(String.self, forKey: .sizeName)
        amount = try container.decode(Int.self, forKey: .amount)
        priceWithChoices = try container.decode(Double.self, forKey: .priceWithChoices)
        itemPrice = try container.decode(Double.self, forKey: .itemPrice)
        subTotal = try container.decode(Double.self, forKey: .subTotal)
        itemImage = try container.decode(String.self, forKey: .itemImage)
        itemSizeId = try container.decode(Int.self, forKey: .itemSizeId)
        itemSizeChoiceDetailsId = try container.decode(Int.self, forKey: .itemSizeChoiceDetailsId)
        itemComment = try container.decode(String.self, forKey: .itemComment)
        visualCode = try container.decode(String.self, forKey: .visualCode)
        itemCurrencyCode = try container.decode(String.self, forKey: .itemCurrencyCode)
        choices = try container.decode([STItemAttributeDTODAL].self, forKey: .choices)
    }
    
    enum CalcCodingKeys: String, CodingKey {
        case Comment = "Comment"
        case itemSizeId = "itemSizeId"
        case Quantity = "Quantity"
        case Price = "Price"
        case itemSizeChoiceDetailId = "itemSizeChoiceDetailId"
    }
    
    var CALCJSONRepresentation: Dictionary<String, Any>  {
        var jsonedDict = [String:Any]()
        
        jsonedDict[CalcCodingKeys.Comment.rawValue] = itemComment
        jsonedDict[CalcCodingKeys.itemSizeId.rawValue] = itemSizeId
        jsonedDict[CalcCodingKeys.Quantity.rawValue] = amount
        jsonedDict[CalcCodingKeys.Price.rawValue] = priceWithChoices
        if self.choices.count > 0 {
            jsonedDict[CalcCodingKeys.itemSizeChoiceDetailId.rawValue] =  choices.map({$0.choiceId})
        }

        return jsonedDict
    }
}
