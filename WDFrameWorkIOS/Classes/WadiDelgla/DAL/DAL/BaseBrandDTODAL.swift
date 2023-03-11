//
//  BaseBrandDTO.swift
//  DAL
//
//  Created by Nermeen Mohamed on 11/4/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
import SwiftyJSON
public  class BaseFilterDTO : IBaseFilterDTO{
    public var id: Observable<Int?> = Observable<Int?>(nil)
    
    public var code: Observable<String?> = Observable<String?>(nil)
    
    public var name: Observable<String?> = Observable<String?>(nil)

 
    public init(){}
    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case name = "Name"
        case code = "Code"
     }
    public init(json: JSON)  {
        self.id.value = json[CodingKeys.id.rawValue].intValue
        self.name.value =  json[CodingKeys.name.rawValue].stringValue
        self.code.value =  json[CodingKeys.code.rawValue].stringValue
    }
}
