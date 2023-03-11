//
//  BaseDTO.swift
//  DAL
//
//  Created by SimpleTouch on 11/24/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
public class BaseDTODAL : IBaseDTODAL {
    public var lang: Observable<String?> = Observable<String?>(nil)
    public var customerSourceID: Observable<Int?> = Observable<Int?>(nil)
    public init(){}
    
    enum BaseCodingKeys: String, CodingKey {
        case lang = "lang"
        case customerSourceID = "customerSourceID"
     }
    
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: BaseCodingKeys.self)
        
        try container.encode(lang.value, forKey: .lang)
        try container.encode(customerSourceID.value, forKey: .customerSourceID)
    }
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: BaseCodingKeys.self)
        lang.value = try container.decode(String.self, forKey: .lang)
        customerSourceID.value = try container.decode(Int.self, forKey: .customerSourceID)
    }
     public  var JSONRepresentation: Dictionary<String, Any>  {
        var jsonedDict = [String:Any]()
        
        jsonedDict[BaseCodingKeys.lang.rawValue] = lang.value ?? ""
        jsonedDict[BaseCodingKeys.customerSourceID.rawValue] = customerSourceID.value ?? ""
 
        return jsonedDict
    }
}

