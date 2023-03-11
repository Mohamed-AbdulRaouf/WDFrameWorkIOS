//
//  CustomErrorDTO.swift
//  DAL
//
//  Created by SimpleTouch on 3/16/20.
//  Copyright © 2020 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
import SwiftyJSON
public class CustomErrorDTODAL :Codable,ICustomErrorDTODAL{
    public var code: Observable<Int?>  = Observable<Int?>(nil)
    
    public var error_ar: Observable<String?> = Observable<String?>(nil)
    
    public var error_en: Observable<String?> = Observable<String?>(nil)
        
    public init(){}
    
    enum CodingKeys: String, CodingKey {
        case code = "code"
        case error_ar = "error_ar"
        case error_en = "error_en"
    }
   public init(json:JSON)   {
        code.value = json[CodingKeys.code.rawValue].intValue
        error_ar.value = json[CodingKeys.error_ar.rawValue].stringValue
        error_en.value = json[CodingKeys.error_en.rawValue].stringValue
    }
    public func encode(to encoder: Encoder) throws {
           var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(code.value, forKey: .code)
        try container.encode(error_ar.value, forKey: .error_ar)
        try container.encode(error_en.value, forKey: .error_en)
       }
       required public init(from decoder: Decoder) throws {
           let container = try decoder.container(keyedBy: CodingKeys.self)
        code.value = try container.decode(Int.self, forKey: .code)
        error_en.value = try container.decode(String.self, forKey: .error_en)
        error_ar.value = try container.decode(String.self, forKey: .error_ar)

       }
}
