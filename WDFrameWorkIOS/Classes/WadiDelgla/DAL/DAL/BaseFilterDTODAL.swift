//
//  BaseBrandDTO.swift
//  DAL
//
//  Created by Nermeen Mohamed on 11/4/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
//import SwiftyJSON
public  class BaseFilterDTODAL : IBaseFilterDTODAL{
    public var id: Observable<Int?> = Observable<Int?>(nil)
    
    public var code: Observable<String?> = Observable<String?>(nil)
    
    public var name: Observable<String?> = Observable<String?>(nil)
    
    public var isSelected: Observable<Bool?> = Observable<Bool?>(nil)
    
    public init(){}
    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case name = "Name"
        case code = "Code"
        case isSelected = "isSelected"
    }
    public init(json: JSON)  {
        self.id.value = json[CodingKeys.id.rawValue].intValue
        self.name.value =  json[CodingKeys.name.rawValue].stringValue
        self.code.value =  json[CodingKeys.code.rawValue].stringValue
        self.isSelected.value = false
    }
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id.value, forKey: .id)
        try container.encode(code.value, forKey: .code)
        try container.encode(name.value, forKey: .name)
        try container.encode(isSelected.value, forKey: .isSelected)
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id.value =  try container.decodeIfPresent(Int.self, forKey: .id)
        self.name.value =  try container.decodeIfPresent(String.self, forKey: .name)
        self.code.value =  try container.decodeIfPresent(String.self, forKey: .code)
        self.isSelected.value =  try container.decodeIfPresent(Bool.self, forKey: .isSelected)
        
        
    }
    
}
