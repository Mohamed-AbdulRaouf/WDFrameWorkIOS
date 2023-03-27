//
//  STKashierTokenDTO.swift
//  DAL
//
//  Created by SimpleTouch on 8/11/20.
//  Copyright © 2020 SimpleTouch. All rights reserved.
//

  
import Foundation
//import SwiftyJSON
public class STKashierTokenDTODAL : Codable,ISTKashierTokenDTODAL{
  
    public var cardNumber: String = ""
    public var token: String = ""
    public var cardExpiryMonth: String = ""
    public var cardExpiryYear: String = ""
    
    
    public  init(){}
    public init(cardNumber: String,token: String,cardExpiryMonth:String,cardExpiryYear:String){
        self.cardNumber = cardNumber
        self.token = token
        self.cardExpiryMonth = cardExpiryMonth
        self.cardExpiryYear = cardExpiryYear
    }
    
    enum CodingKeys: String, CodingKey {
        case cardNumber = "cardNumber"
        case token = "token"
        case cardExpiryMonth = "cardExpiryMonth"
        case cardExpiryYear = "cardExpiryYear"

    }
    
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(cardNumber, forKey: .cardNumber)
        try container.encode(token, forKey: .token)
        try container.encode(cardExpiryMonth, forKey: .cardExpiryMonth)
        try container.encode(cardExpiryYear, forKey: .cardExpiryYear)
    }
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.cardNumber =  try container.decode(String.self, forKey: .cardNumber)
        self.token =  try container.decode(String.self, forKey: .token)
        self.cardExpiryMonth =  try container.decode(String.self, forKey: .cardExpiryMonth)
        self.cardExpiryYear =  try container.decode(String.self, forKey: .cardExpiryYear)
    }
}
