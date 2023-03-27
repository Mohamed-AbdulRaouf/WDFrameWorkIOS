//
//  NotificationDTO.swift
//  DAL
//
//  Created by Nermeen Mohamed on 11/2/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
//import SwiftyJSON
public class NotificationDTODAL : INotificationDTODAL{
    
    public var id: Observable<String?>  = Observable<String?>(nil)
    
    public var notificationDate: Observable<String?> = Observable<String?>(nil)
    
    public var brandLogoPath: Observable<String?> = Observable<String?>(nil)
    
    public var notificationDescription: Observable<String?> = Observable<String?>(nil)
    
    public var isReaded: Observable<Bool?> = Observable<Bool?>(nil)
    
    public var brandName: Observable<String?> = Observable<String?>(nil)

    public var brandId: Observable<String?> = Observable<String?>(nil)
    
    
    public init(){}
    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case brandName = "Brandname"
        case brandLogoPath = "BrandLogoPath"
        case notificationDescription = "NotificationText"
        case notificationDate = "NotificationDate"
        case brandId = "BrandID"
        case isReaded = "Readed"
    }
    public init(json: JSON)  {
        self.id.value =  json[CodingKeys.id.rawValue].stringValue
        self.brandName.value =  json[CodingKeys.brandName.rawValue].stringValue
        self.brandLogoPath.value =  json[CodingKeys.brandLogoPath.rawValue].stringValue
        self.notificationDate.value =  json[CodingKeys.notificationDate.rawValue].stringValue
        self.brandId.value =  json[CodingKeys.brandId.rawValue].stringValue
        self.isReaded.value =  json[CodingKeys.isReaded.rawValue].boolValue
        self.notificationDescription.value =  json[CodingKeys.notificationDescription.rawValue].stringValue
    }
 }
