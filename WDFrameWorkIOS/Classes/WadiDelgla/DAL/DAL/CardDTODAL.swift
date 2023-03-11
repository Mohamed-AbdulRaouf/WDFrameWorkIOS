//
//  CardDTO.swift
//  DAL
//
//  Created by SimpleTouch on 8/6/20.
//  Copyright © 2020 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
import SwiftyJSON
public class CardDTODAL :Codable,ICardDTODAL{
    public var cardHolderName: Observable<String?> = Observable<String?>(nil)
    
    public var cardNumber: Observable<String?> = Observable<String?>(nil)
    
    public var cardExpiryDate: Observable<String?> = Observable<String?>(nil)
    
    public var cardCvv: Observable<String?> = Observable<String?>(nil)
        
    public init(){}
    
    enum CodingKeys: String, CodingKey {
            case cardHolderName = "cardHolderName"
            case cardNumber = "cardNumber"
            case cardExpiryDate = "cardExpiryDate"
            case cardCvv = "cardCvv"
       }
       
       
       public func encode(to encoder: Encoder) throws {
           var container = encoder.container(keyedBy: CodingKeys.self)
           
        try container.encode(cardHolderName.value, forKey: .cardHolderName)
        try container.encode(cardNumber.value, forKey: .cardNumber)
        try container.encode(cardExpiryDate.value, forKey: .cardExpiryDate)
        try container.encode(cardCvv.value, forKey: .cardCvv)
        
       }
       required public init(from decoder: Decoder) throws {
           let container = try decoder.container(keyedBy: CodingKeys.self)
        self.cardHolderName.value =  try container.decode(String.self, forKey: .cardHolderName)
        self.cardNumber.value = try container.decode(String.self, forKey: .cardNumber)
        self.cardExpiryDate.value =  try container.decode(String.self, forKey: .cardExpiryDate)
        self.cardCvv.value = try container.decode(String.self, forKey: .cardCvv)
       }
    
}
