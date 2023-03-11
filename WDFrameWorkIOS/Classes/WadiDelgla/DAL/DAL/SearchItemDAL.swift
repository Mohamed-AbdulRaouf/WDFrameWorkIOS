//
//  SearchItem.swift
//  DAL
//
//  Created by SimpleTouch on 10/24/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation

class SearchItemDAL: NSObject {
    public  var id: Int?
    public  var name: String?
    init(id: Int?,name: String?){
        self.id = id
        self.name = name
    }
}
class City: SearchItemDAL {
    var areas : [SearchItemDAL]?
    init(id: Int?,name: String?,areas: [SearchItemDAL]?) {
        super.init(id: id, name: name)
        self.areas = areas
        
    }
}
import Foundation
import Bond
public class SearchItemDTODAL :BaseUserDTODAL, Codable, IRegisterDTODAL{
    public var countryId =  Observable<String?>(nil)
    
    public var dialCode = Observable<String?>(nil)
    
    public var confirmPassword = Observable<String?>(nil)
    
    public var membershipNumber = Observable<String?>(nil)
    
    
    
    
    public var id = Observable<Int?>(nil)
    public var name  = Observable<String?>(nil)
    public var code  = Observable<String?>(nil)
    
    public var firstName  = Observable<String?>(nil)
    
    public var lastName = Observable<String?>(nil)
    
    public var email = Observable<String?>(nil)
    
    public var password = Observable<String?>(nil)
    
    public var gender = Observable<String?>(nil)
    
    public var shareCode = Observable<String?>(nil)
    
    public var brandId = Observable<Int?>(nil)
    
    
    public override init(){}
    
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case code = "Code"
        case firstName = "FirstName"
        case lastName = "LastName"
        case mobile = "Mobile"
        case email = "Email"
        case password = "Password"
        case gender = "Gender"
        case shareCode = "ShareCode"
        case brandId = "BrandID"
        case name = "Name"
    }
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id.value, forKey: .id)
        try container.encode(code.value, forKey: .code)
        try container.encode(firstName.value, forKey: .firstName)
        try container.encode(lastName.value, forKey: .lastName)
        try container.encode(mobile.value, forKey: .mobile)
        try container.encode(password.value, forKey: .password)
        try container.encode(gender.value, forKey: .gender)
        try container.encode(shareCode.value, forKey: .shareCode)
        try container.encode(brandId.value, forKey: .brandId)
        try container.encode(name.value, forKey: .name)
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        //
        //        code = try container.decodeIfPresent(
        //            (Observable<String?>).self, forKey: .code)
        //
        //        firstName = try container.decodeIfPresent(String.self,forKey: .firstName)
        //        lastName = try container.decodeIfPresent(String.self,forKey: .lastName)
        //        email = try container.decodeIfPresent(String.self,forKey: .email)
        //        password = try container.decodeIfPresent(String.self,forKey: .password)
        //        gender = try container.decodeIfPresent(String.self,forKey: .gender)
        //        shareCode = try container.decodeIfPresent(String.self,forKey: .shareCode)
        //        brandId = try container.decodeIfPresent(Int.self,forKey: .brandId)
    }
}
