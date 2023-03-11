//
//  BrandLocationDTO.swift
//  DAL
//
//  Created by Nermeen Mohamed on 10/30/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
import SwiftyJSON
public  class BrandLocationDTODAL : IBrandLocationDTODAL{
    public var brandId: Observable<Int?> = Observable<Int?>(nil)
    
    public var name: Observable<String?> = Observable<String?>(nil)
    
    public var latitude: Observable<Double?> = Observable<Double?>(nil)
    
    public var longitude: Observable<Double?> = Observable<Double?>(nil)
    
    public var brandName: Observable<String?> = Observable<String?>(nil)
    
    public var openTime: Observable<String?> = Observable<String?>(nil)
    
    public var closeTime: Observable<String?> = Observable<String?>(nil)
    
    public var imagePath: Observable<String?> = Observable<String?>(nil)
    
    public var is24Hour: Observable<Bool?> = Observable<Bool?>(nil)
    
    public var inactive: Observable<Bool?> = Observable<Bool?>(nil)
        
    public var rating: Observable<Float?> = Observable<Float?>(nil)
    
    public var reviewersNumber: Observable<Int?> = Observable<Int?>(nil)
    
    public var facilities: Observable<[IFacilityDTODAL]?> = Observable<[IFacilityDTODAL]?>(nil)
    
    
    public init(){}
    enum CodingKeys: String, CodingKey {
        case brandId = "BrandID"
        case name = "Name"
        case latitude = "Latitude"
        case longitude = "Longitude"
        case brandName = "brandname"
        case OpenTime = "OpenTime"
        case CloseTime = "CloseTime"
        case ImagePath = "ImagePath"
        case Is24Hour = "Is24Hour"
        case Inactive = "Inactive"
        case Rating = "Rating"
        case ReviewersNumber = "ReviewersNumber"
        case Facilities = "Facilities"

    }
    public init(json: JSON)  {
        self.brandId.value = json[CodingKeys.brandId.rawValue].intValue
        self.name.value =  json[CodingKeys.name.rawValue].stringValue
        self.latitude.value = json[CodingKeys.latitude.rawValue].doubleValue
        self.longitude.value = json[CodingKeys.longitude.rawValue].doubleValue
        self.brandName.value =  json[CodingKeys.brandName.rawValue].stringValue
        self.openTime.value = json[CodingKeys.OpenTime.rawValue].stringValue
        self.closeTime.value = json[CodingKeys.CloseTime.rawValue].stringValue
        self.imagePath.value = json[CodingKeys.ImagePath.rawValue].stringValue
        self.is24Hour.value = json[CodingKeys.Is24Hour.rawValue].boolValue
        self.inactive.value = json[CodingKeys.Inactive.rawValue].boolValue
        self.rating.value = json[CodingKeys.Rating.rawValue].floatValue
        self.reviewersNumber.value = json[CodingKeys.ReviewersNumber.rawValue].intValue
        self.facilities.value = json[CodingKeys.Facilities.rawValue].arrayValue.map({try! FacilityDTODAL.init(json: $0)})
    }
}
