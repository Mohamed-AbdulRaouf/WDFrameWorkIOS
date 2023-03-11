//
//  ServiceDTO.swift
//  DAL
//
//  Created by SimpleTouch on 11/6/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
import SwiftyJSON
public class ServiceDTODAL : IServiceDTODAL{
    public var id: Observable<String?> = Observable<String?>(nil)
    
    public var serviceName: Observable<String?> = Observable<String?>(nil)
    
    public var serviceIcon: Observable<String?> = Observable<String?>(nil)
    
    public init(){
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case name = "Name"
        case icon = "Icon"
     }
    public init(id: String,name: String,icon: String){
        self.id.value = id
        self.serviceName.value = name
        self.serviceIcon.value = icon
    }
    public  init(json: JSON)  {
        
        self.id.value = json[CodingKeys.id.rawValue].stringValue
        self.serviceName.value = json[CodingKeys.name.rawValue].stringValue
        self.serviceIcon.value = json[CodingKeys.icon.rawValue].stringValue
     }
    
    
    
}
