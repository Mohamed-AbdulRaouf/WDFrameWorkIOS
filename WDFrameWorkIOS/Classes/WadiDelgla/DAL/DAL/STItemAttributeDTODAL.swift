//
//  STItemAttributeDTO.swift
//  DAL
//
//  Created by SimpleTouch on 11/20/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
//import SwiftyJSON
public class STItemAttributeDTODAL : Codable,ISTItemAttributeDTODAL{
    public var itemId: Int = 0
    
    public var sizeId: Int = 0
    
    public var choiceId: Int = 0
    
    public var itemChoicePrice: Float = 0.0
    
    public var amount: Int = 0
    
    public var itemChoiceName: String = ""
    
    public var itemCurrencyCode: String = ""
    
    public  init(){}
    
    enum CodingKeys: String, CodingKey {
        case itemId = "itemId"
        case sizeId = "sizeId"
        case choiceId = "choiceId"
        case itemChoicePrice = "itemChoicePrice"
        case amount = "amount"
        case itemChoiceName = "itemChoiceName"
        case itemCurrencyCode = "itemCurrencyCode"
    }
    
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(itemId, forKey: .itemId)
        try container.encode(sizeId, forKey: .sizeId)
        try container.encode(choiceId, forKey: .choiceId)
        try container.encode(itemChoicePrice, forKey: .itemChoicePrice)
        try container.encode(amount, forKey: .amount)
        try container.encode(itemChoiceName, forKey: .itemChoiceName)
        try container.encode(itemCurrencyCode, forKey: .itemCurrencyCode)
    }
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.itemId =  try container.decode(Int.self, forKey: .itemId)
        self.sizeId =  try container.decode(Int.self, forKey: .sizeId)
        self.choiceId =  try container.decode(Int.self, forKey: .choiceId)
        self.itemChoicePrice =  try container.decode(Float.self, forKey: .itemChoicePrice)
        self.amount =  try container.decode(Int.self, forKey: .amount)
        self.itemChoiceName =  try container.decode(String.self, forKey: .itemChoiceName)
        self.itemCurrencyCode =  try container.decode(String.self, forKey: .itemCurrencyCode)
    }
}
