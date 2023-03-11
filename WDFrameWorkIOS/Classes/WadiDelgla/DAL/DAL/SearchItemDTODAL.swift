//
//  SearchItemDTO.swift
//  DAL
//
//  Created by SimpleTouch on 10/24/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
import SwiftyJSON
public class SearchItemDTOModelDAL : Codable, ISearchItemDTODAL{
    public var id: Observable<String?> = Observable<String?>(nil)
    
    public var name: Observable<String?> = Observable<String?>(nil)
    
    public var nameAr: Observable<String?> = Observable<String?>(nil)
    
    public  init(){}
    
    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case name = "Name"
        case nameAr = "NameAr"
    }
    public init(json: JSON) {
        self.id.value = json[CodingKeys.id.rawValue].stringValue
        self.name.value =  json[CodingKeys.name.rawValue].stringValue
        self.nameAr.value = json[CodingKeys.nameAr.rawValue].stringValue
    }
    public init(id: String,name: String){
        self.id.value =  id
        self.name.value = name
    }
    
     public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id.value, forKey: .id)
        try container.encode(name.value, forKey: .name)
        try container.encode(nameAr.value, forKey: .nameAr)
    }
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id.value =  try container.decodeIfPresent(String.self, forKey: .id)
        self.name.value = try container.decodeIfPresent(String.self,forKey: .name)
        self.nameAr.value = try container.decodeIfPresent(String.self,forKey: .nameAr)
        
     }
}
