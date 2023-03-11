//
//  ILoginValidationInputDTO.swift
//  DAL
//
//  Created by SimpleTouch on 11/22/20.
//  Copyright © 2020 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
public protocol  IBaseLoginDTODAL :AnyObject {
    var mobile: Observable<String?> { get set }
    var password: Observable<String?> { get set }
}
public class BaseLoginDTODAL :NSObject, IBaseLoginDTODAL {
    public var mobile = Observable<String?>(nil)
    public var password = Observable<String?>(nil)
    
    public  override init(){}
    public init(mobile: String?,password: String?) {
        self.mobile.value = mobile
        self.password.value = password
    }
    enum CodingKeys: String, CodingKey {
        case mobile = "Mobile"
        case password = "Password"
    }
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(mobile.value, forKey: .mobile)
        try container.encode(password.value, forKey: .password)
    }
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        mobile.value = try container.decodeIfPresent(String.self,forKey: .mobile)
        password.value = try container.decodeIfPresent(String.self,forKey: .password)
    }
}
// input
public protocol  ILoginValidationInputDTODAL :IBaseLoginDTODAL {
    var hintNumber: Observable<String?> { get set }
}
public class LoginValidationInputDTODAL : BaseLoginDTODAL,Codable,ILoginValidationInputDTODAL {
    public var hintNumber = Observable<String?>(nil)
    
    public override init() {
        super.init()
    }
    required public init(mobile: String?,password:String?,hintNumber: String?) {
        super.init(mobile: mobile, password: password)
        self.hintNumber.value = hintNumber
    }
    
    enum CodingKeys: String, CodingKey {
        case hintNumber = "HintNumber"
    }
    
    public override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(hintNumber.value, forKey: .hintNumber)
        let superencoder = container.superEncoder()
        try super.encode(to: superencoder)
        
        
    }
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        hintNumber.value = try container.decodeIfPresent(String.self,forKey: .hintNumber)
        let superdecoder = try container.superDecoder()
        try super.init(from: superdecoder)
    }
}
//logindto to send to backend
public protocol  ILoginBDTODAL :IBaseLoginDTODAL {
    var brandId: Observable<Int?> { get set }
    var countryId: Observable<String?> { get set }
}
public class LoginBDTODAL: BaseLoginDTODAL,Codable,ILoginBDTODAL  {
    public var brandId = Observable<Int?>(nil)
    
    public var countryId = Observable<String?>(nil)
    
    public override init(){
        super.init()
    }
    required public init(mobile: String?,password:String?,brandId: Int?,countryId:String?) {
        super.init(mobile: mobile, password: password)
        self.brandId.value = brandId
        self.countryId.value = countryId
    }
    enum CodingKeys: String, CodingKey {
        case brandId = "BrandID"
        case countryId = "countryId"
    }
    
    public override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(brandId.value, forKey: .brandId)
        try container.encode(countryId.value, forKey: .countryId)
        let superencoder = container.superEncoder()
        try super.encode(to: superencoder)
        
        
    }
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        brandId.value = try container.decodeIfPresent(Int.self,forKey: .brandId)
        countryId.value = try container.decodeIfPresent(String.self,forKey: .countryId)
        let superdecoder = try container.superDecoder()
        try super.init(from: superdecoder)
    }
    
}
public protocol ILoginDataModelDAL : ILoginBDTODAL,ILoginValidationInputDTODAL{
    
}
public class LoginDataModelDAL: ILoginDataModelDAL {
    public var brandId: Observable<Int?> = Observable<Int?>(nil)
    
    public var countryId: Observable<String?> = Observable<String?>(nil)
    
    public var hintNumber: Observable<String?> = Observable<String?>(nil)
    
    public var mobile: Observable<String?> = Observable<String?>(nil)
    
    public var password: Observable<String?> = Observable<String?>(nil)
    
    public  init(){}
    
}

public protocol ILoginModelDAL {}

public protocol IUserNameLoginModelDAL : ILoginModelDAL{
    var mobile: Observable<String?> { get set }
    var password: Observable<String?> { get set }
    var brandId: Observable<Int?> { get set }
}

public class userNameLoginModelDAL : IUserNameLoginModelDAL {
    
    public var mobile = Observable<String?>(nil)
    
    public var password = Observable<String?>(nil)
    
    public var brandId = Observable<Int?>(nil)
    
    public init(){}
    
}

public protocol IUserNameWithCountryLoginModelDAL : ILoginModelDAL{
    var mobile: Observable<String?> { get set }
    var password: Observable<String?> { get set }
    var brandId: Observable<Int?> { get set }
    var countryId: Observable<String?> { get set }
    var hintNumber: Observable<String?> { get set }
}
public class userNameWithCountryLoginModelDAL: IUserNameWithCountryLoginModelDAL {
    
    public var mobile = Observable<String?>(nil)
    
    public var password = Observable<String?>(nil)
    
    public var brandId = Observable<Int?>(nil)
    
    public var countryId = Observable<String?>(nil)
    
    public var hintNumber = Observable<String?>(nil)
    
    public init(){}
    
}
