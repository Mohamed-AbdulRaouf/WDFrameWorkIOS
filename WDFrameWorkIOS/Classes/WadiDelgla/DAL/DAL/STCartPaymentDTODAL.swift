//
//  STCartPaymentDTO.swift
//  DAL
//
//  Created by SimpleTouch on 8/11/20.
//  Copyright © 2020 SimpleTouch. All rights reserved.
//

import Foundation
//import SwiftyJSON
public class STCartPaymentDTODAL : Codable,ISTCartPaymentDTODAL{
    
    public var cardData: CardDTODAL? = nil
    
    public var cardToken: STKashierTokenDTODAL? = nil
    
    public  init(){}
    public init(_ cardData: CardDTODAL?,_ cardToken: STKashierTokenDTODAL?) {
        self.cardData = cardData
        self.cardToken = cardToken
    }
    enum CodingKeys: String, CodingKey {
        case cardData = "cardData"
        case cardToken = "cardToken"
    }
    
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(cardData, forKey: .cardData)
        try container.encode(cardToken, forKey: .cardToken)
    }
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.cardData =  try container.decode(CardDTODAL.self, forKey: .cardData)
        self.cardToken =  try container.decode(STKashierTokenDTODAL.self, forKey: .cardToken)
    }
}

