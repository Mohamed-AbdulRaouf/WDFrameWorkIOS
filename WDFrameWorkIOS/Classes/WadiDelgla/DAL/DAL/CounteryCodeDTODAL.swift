//
//  countryCodeDTO.swift
//  DAL
//
//  Created by SimpleTouch on 11/10/20.
//  Copyright © 2020 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
import SwiftyJSON
public class CountryDTODAL : ICountryDTODAL,Codable{
    
    public var countryId: Observable<String?> = Observable<String?>(nil)
    
    public var countryCode: Observable<String?> = Observable<String?>(nil)
    
    public var dialCode: Observable<String?> = Observable<String?>(nil)
    
    public var emoji: Observable<String?> = Observable<String?>(nil)
    
    public var name: Observable<String?> = Observable<String?>(nil)
    
    public var hintNumber: Observable<String?> = Observable<String?>(nil)
    
    public var currency: Observable<String?> = Observable<String?>(nil)


    public init(){}
    
    enum CodingKeys: String, CodingKey {
        case CountryId = "CountryId"
        case CountryCode = "CountryCode"
        case DialCode = "DialCode"
        case Emoji = "Emoji"
        case Name = "Name"
        case HintNumber = "HintNumber"
        case currency = "currency"
      }
    public init(countryCode: String,dialCode: String,emoji: String,name: String,hintNumber: String) {
        self.countryCode.value = countryCode
        self.dialCode.value = dialCode
        self.emoji.value = emoji
        self.name.value = name
        self.hintNumber.value = hintNumber
    }
    
    public init(json:JSON)   {
        self.countryId.value = json[CodingKeys.CountryId.rawValue].stringValue
        self.countryCode.value = json[CodingKeys.CountryCode.rawValue].stringValue
        self.dialCode.value = json[CodingKeys.DialCode.rawValue].stringValue
        self.emoji.value = json[CodingKeys.Emoji.rawValue].stringValue
        self.name.value = json[CodingKeys.Name.rawValue].stringValue
        self.hintNumber.value = json[CodingKeys.HintNumber.rawValue].stringValue
        self.currency.value = json[CodingKeys.currency.rawValue].stringValue
     }
   public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(countryId.value, forKey: .CountryId)
        try container.encode(countryCode.value, forKey: .CountryCode)
        try container.encode(dialCode.value, forKey: .DialCode)
        try container.encode(emoji.value, forKey: .Emoji)
        try container.encode(name.value, forKey: .Name)
        try container.encode(hintNumber.value, forKey: .HintNumber)
        try container.encode(currency.value, forKey: .currency)
    }
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.countryId.value =  try container.decodeIfPresent(String.self, forKey: .CountryId)
        self.countryCode.value = try container.decodeIfPresent(String.self,forKey: .CountryCode)
        self.dialCode.value =  try container.decodeIfPresent(String.self, forKey: .DialCode)
        self.emoji.value = try container.decodeIfPresent(String.self,forKey: .Emoji)
        self.name.value =  try container.decodeIfPresent(String.self, forKey: .Name)
        self.hintNumber.value = try container.decodeIfPresent(String.self,forKey: .HintNumber)
        self.currency.value = try container.decodeIfPresent(String.self,forKey: .currency)
     }
    
}
