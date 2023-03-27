//
//  UserDTO.swift
//  DAL
//
//  Created by SimpleTouch on 10/9/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
//import SwiftyJSON
public class UserDTODAL :BaseUserDTODAL, Codable, IUserDTODAL{
    
    public var userId = Observable<String?>(nil)
    
    public var code = Observable<String?>(nil)
    
    public var firstName = Observable<String?>(nil)
    
    public var lastName = Observable<String?>(nil)
    
    public var email = Observable<String?>(nil)
    
    public var password = Observable<String?>(nil)

    public var birthday = Observable<Int?>(nil)
    
    public var birthmonth = Observable<Int?>(nil)
    
    public var birthyear = Observable<Int?>(nil)

    public var gender = Observable<String?>(nil)

    public var mobileValidated = Observable<Bool?>(nil)
    
    public var profileImageName = Observable<String?>(nil)
    
    public var token = Observable<String?>(nil)
    
    public var userName = Observable<String?>(nil)
    
    public var balance: Observable<Double?> = Observable<Double?>(nil)
    
    
    var name :String?
    
    public override init(){}
    
    enum CodingKeys: String, CodingKey {
        case userId = "Id"
        case code = "Code"
        case firstName = "FirstName"
        case lastName = "LastName"
        case mobile = "Mobile"
        case email = "Email"
        case password = "Password"
        case birthday = "Birthday"
        case birthmonth = "Birthmonth"
        case birthyear = "Birthyear"
        case gender = "Gender"
        case mobileValidated = "MobileValidated"
        case profileImageName = "ProfileImageName"
        case token = "Token"
        case userName = "UserName"
        case balance = "Balance"
        
    }
    public init(json: JSON)  {
        super.init()
        self.userId.value = json[CodingKeys.userId.rawValue].stringValue
        self.code.value =  json[CodingKeys.code.rawValue].stringValue
        self.firstName.value = json[CodingKeys.firstName.rawValue].stringValue
        self.lastName.value = json[CodingKeys.lastName.rawValue].stringValue
        self.mobile.value = json[CodingKeys.mobile.rawValue].stringValue
        self.email.value = json[CodingKeys.email.rawValue].stringValue
        self.password.value = json[CodingKeys.password.rawValue].stringValue
        self.birthday.value = json[CodingKeys.birthday.rawValue].intValue
        self.birthmonth.value = json[CodingKeys.birthmonth.rawValue].intValue
        self.birthyear.value = json[CodingKeys.birthyear.rawValue].intValue
        self.gender.value = json[CodingKeys.gender.rawValue].stringValue
        self.mobileValidated.value = json[CodingKeys.mobileValidated.rawValue].boolValue
        self.profileImageName.value = json[CodingKeys.profileImageName.rawValue].stringValue
        self.token.value = json[CodingKeys.token.rawValue].stringValue
        self.userName.value = json[CodingKeys.userName.rawValue].stringValue
        self.balance.value = json[CodingKeys.balance.rawValue].doubleValue
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(userId.value, forKey: .userId)
        try container.encode(code.value, forKey: .code)
        try container.encode(firstName.value, forKey: .firstName)
        try container.encode(lastName.value, forKey: .lastName)
        try container.encode(mobile.value, forKey: .mobile)
        try container.encode(email.value, forKey: .email)
        try container.encode(password.value, forKey: .password)
        try container.encode(birthday.value, forKey: .birthday)
        try container.encode(birthmonth.value, forKey: .birthmonth)
        try container.encode(birthyear.value, forKey: .birthyear)
        try container.encode(gender.value, forKey: .gender)
        try container.encode(mobileValidated.value, forKey: .mobileValidated)
        try container.encode(profileImageName.value, forKey: .profileImageName)
        try container.encode(token.value, forKey: .token)
        try container.encode(userName.value, forKey: .userName)
        try container.encode(balance.value, forKey: .balance)
    }
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
//
        super.init()
        self.userId.value =  try container.decodeIfPresent(String.self, forKey: .userId)
        self.code.value = try container.decodeIfPresent(String.self,forKey: .code)
        firstName.value = try container.decodeIfPresent(String.self,forKey: .firstName)
        lastName.value = try container.decodeIfPresent(String.self,forKey: .lastName)
        mobile.value = try container.decodeIfPresent(String.self,forKey: .mobile)
        email.value = try container.decodeIfPresent(String.self,forKey: .email)
        password.value = try container.decodeIfPresent(String.self,forKey: .password)
        birthday.value = try container.decodeIfPresent(Int.self,forKey: .birthday)
        birthmonth.value = try container.decodeIfPresent(Int.self,forKey: .birthmonth)
        birthyear.value = try container.decodeIfPresent(Int.self,forKey: .birthyear)
        gender.value = try container.decodeIfPresent(String.self,forKey: .gender)
        mobileValidated.value = try container.decodeIfPresent(Bool.self,forKey: .mobileValidated)
        profileImageName.value = try container.decodeIfPresent(String.self,forKey: .profileImageName)
        token.value = try container.decodeIfPresent(String.self,forKey: .token)
        userName.value = try container.decodeIfPresent(String.self,forKey: .userName)
        balance.value = try container.decodeIfPresent(Double.self,forKey: .balance)
    }
}
