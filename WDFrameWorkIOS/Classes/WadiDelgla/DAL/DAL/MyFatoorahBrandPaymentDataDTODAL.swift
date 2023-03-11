//
//  MyFatoorahBrandPAymentDataDTO.swift
//  DAL
//
//  Created by Nermeen Mohamed on 28/06/2021.
//  Copyright © 2021 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
import SwiftyJSON
public  class MyFatoorahBrandPaymentDataDTODAL : IMyFatoorahBrandPaymentDataDTODAL,Codable{
    
    public var brandId: Observable<Int?> = Observable<Int?>(nil)

    public var paymentBaseUrl: Observable<String?> = Observable<String?>(nil)
    
    public var paymentToken: Observable<String?> = Observable<String?>(nil)
    
    public var paymentMethod: Observable<Int?> = Observable<Int?>(nil)
     
    public init(){}
    enum CodingKeys: String, CodingKey {
        case BrandID = "BrandID"
        case PaymentBaseUrl = "PaymentBaseUrl"
        case PaymentToken = "PaymentToken"
        case PaymentMethod = "PaymentMethod"
     }
     public init(json: JSON)  {
        self.brandId.value = json[CodingKeys.BrandID.rawValue].intValue
        self.paymentBaseUrl.value = json[CodingKeys.PaymentBaseUrl.rawValue].stringValue
        self.paymentToken.value = json[CodingKeys.PaymentToken.rawValue].stringValue
        self.paymentMethod.value = json[CodingKeys.PaymentMethod.rawValue].intValue
    }
     public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(brandId.value, forKey: .BrandID)
            try container.encode(paymentBaseUrl.value, forKey: .PaymentBaseUrl)
            try container.encode(paymentToken.value, forKey: .PaymentToken)
            try container.encode(paymentMethod.value, forKey: .PaymentMethod)

        }
        required public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)

            self.brandId.value =  try container.decodeIfPresent(Int.self, forKey: .BrandID)
            self.paymentBaseUrl.value = try container.decodeIfPresent(String.self,forKey: .PaymentBaseUrl)
            self.paymentToken.value = try container.decodeIfPresent(String.self,forKey: .PaymentToken)
            self.paymentMethod.value =  try container.decodeIfPresent(Int.self, forKey: .PaymentMethod)
        }
}
