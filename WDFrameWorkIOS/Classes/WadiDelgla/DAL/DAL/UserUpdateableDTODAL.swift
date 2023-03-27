//
//  UserUpdateableDTO.swift
//  DAL
//
//  Created by SimpleTouch on 10/21/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
//import SwiftyJSON
public class UserUpdateableDTODAL :Codable, IUserUpdateableDTODAL{
    
    
    public var firstName = Observable<String?>(nil)
    
    public var lastName = Observable<String?>(nil)
    
    public var email = Observable<String?>(nil)
    
    public var birthday = Observable<Int?>(nil)
    
    public var birthmonth = Observable<Int?>(nil)
    
    public var gender = Observable<String?>(nil)
    
    
    enum CodingKeys: String, CodingKey {
        case firstName = "FirstName"
        case lastName = "LastName"
        case email = "Email"
        case birthday = "Birthday"
        case birthmonth = "Birthmonth"
        case gender = "Gender"
    }
    public init(json: JSON)  {
        self.firstName.value = json[CodingKeys.firstName.rawValue].stringValue
        self.lastName.value = json[CodingKeys.lastName.rawValue].stringValue
        self.email.value = json[CodingKeys.email.rawValue].stringValue
        self.birthday.value = json[CodingKeys.birthday.rawValue].intValue
        self.birthmonth.value = json[CodingKeys.birthmonth.rawValue].intValue
        self.gender.value = json[CodingKeys.gender.rawValue].stringValue
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(firstName.value, forKey: .firstName)
        try container.encode(lastName.value, forKey: .lastName)
        try container.encode(email.value, forKey: .email)
        try container.encode(birthday.value, forKey: .birthday)
        try container.encode(birthmonth.value, forKey: .birthmonth)
        try container.encode(gender.value, forKey: .gender)
        
    }
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        //
        firstName.value = try container.decodeIfPresent(String.self,forKey: .firstName)
        lastName.value = try container.decodeIfPresent(String.self,forKey: .lastName)
        email.value = try container.decodeIfPresent(String.self,forKey: .email)
        birthday.value = try container.decodeIfPresent(Int.self,forKey: .birthday)
        birthmonth.value = try container.decodeIfPresent(Int.self,forKey: .birthmonth)
        gender.value = try container.decodeIfPresent(String.self,forKey: .gender)
    }
}
