//
//  LoginDTO.swift
//  DAL
//
//  Created by SimpleTouch on 9/23/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
public  class LoginDTODAL : BaseUserDTODAL,Codable, ILoginDTODAL{
    public var password = Observable<String?>(nil)
    public var brandId: Observable<Int?> = Observable<Int?>(nil)
    public var countryId: Observable<String?> = Observable<String?>(nil)
    public var dialCode: Observable<String?> = Observable<String?>(nil)
    public var hintNumber: Observable<String?> = Observable<String?>(nil)
    enum CodingKeys: String, CodingKey {
        case mobile = "Mobile"
        case password = "Password"
        case brandId = "BrandID"
        case countryId = "countryId"
        case dialCode = "DialCode"
        case hintNumber = "HintNumber"
    }
    public override init(){}
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(mobile.value, forKey: .mobile)
        try container.encode(password.value, forKey: .password)
        try container.encode(brandId.value, forKey: .brandId)
        try container.encode(countryId.value, forKey: .countryId)
        try container.encode(dialCode.value, forKey: .dialCode)
        try container.encode(hintNumber.value, forKey: .hintNumber)
    }
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        super.init()
        mobile.value = try container.decodeIfPresent(String.self,forKey: .mobile)
        password.value = try container.decodeIfPresent(String.self,forKey: .password)
        countryId.value = try container.decodeIfPresent(String.self,forKey: .countryId)
        dialCode.value = try container.decodeIfPresent(String.self,forKey: .dialCode)
        hintNumber.value = try container.decodeIfPresent(String.self,forKey: .hintNumber)
        brandId.value =  try container.decodeIfPresent(Int.self,forKey: .brandId)
    }
}
