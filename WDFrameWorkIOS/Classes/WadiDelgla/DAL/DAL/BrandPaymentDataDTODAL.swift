//
//  BrandPaymentDataDTO.swift
//  DAL
//
//  Created by SimpleTouch on 8/9/20.
//  Copyright © 2020 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
//import SwiftyJSON
public  class BrandPaymentDataDTODAL : IBrandPaymentDataDTODAL,Codable{
    public var brandId: Observable<Int?> = Observable<Int?>(nil)
    
    public var merchantId: Observable<String?> = Observable<String?>(nil)
    
    public var apiKey: Observable<String?> = Observable<String?>(nil)
 
    public init(){}
    enum CodingKeys: String, CodingKey {
        case BrandID = "BrandID"
        case MerchantId = "MerchantId"
        case APIKey = "APIKey"
     }
     public init(json: JSON)  {
        self.brandId.value = json[CodingKeys.BrandID.rawValue].intValue
        self.merchantId.value = json[CodingKeys.MerchantId.rawValue].stringValue
        self.apiKey.value = json[CodingKeys.APIKey.rawValue].stringValue
    }
     public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(brandId.value, forKey: .BrandID)
            try container.encode(merchantId.value, forKey: .MerchantId)
            try container.encode(apiKey.value, forKey: .APIKey)
        }
        required public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)

            self.brandId.value =  try container.decodeIfPresent(Int.self, forKey: .BrandID)
            self.merchantId.value = try container.decodeIfPresent(String.self,forKey: .MerchantId)
            self.apiKey.value = try container.decodeIfPresent(String.self,forKey: .APIKey)
        }
}
