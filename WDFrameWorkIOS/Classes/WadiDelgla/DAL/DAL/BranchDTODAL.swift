//
//  BranchDTO.swift
//  DAL
//
//  Created by SimpleTouch on 4/15/20.
//  Copyright © 2020 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
//import SwiftyJSON
public class BranchDTODAL :IBranchDTODAL{

    public var branchId: Observable<Int?> = Observable<Int?>(nil)
    
    public var brandId: Observable<Int?> = Observable<Int?>(nil)
    
    public var code: Observable<String?> = Observable<String?>(nil)
    
    public var name: Observable<String?> = Observable<String?>(nil)
    
    public var latitude: Observable<Double?> = Observable<Double?>(nil)
    
    public var longitude: Observable<Double?> = Observable<Double?>(nil)
    
    public var deliveryTime: Observable<String?> = Observable<String?>(nil)
    
    public var openTime: Observable<String?> = Observable<String?>(nil)
    
    public var closeTime: Observable<String?> = Observable<String?>(nil)
    
    public var imagePath: Observable<String?> = Observable<String?>(nil)
    
    public var is24Hour: Observable<Bool?> = Observable<Bool?>(nil)
    
    public var inactive: Observable<Bool?> = Observable<Bool?>(nil)
    
    public var brandName: Observable<String?> = Observable<String?>(nil)
 
    public var rating: Observable<Float?> = Observable<Float?>(nil)
    
    public var reviewersNumber: Observable<Int?> = Observable<Int?>(nil)
    
    public var facilities: Observable<[IFacilityDTODAL]?> = Observable<[IFacilityDTODAL]?>(nil)

    public init(){}
    
    enum CodingKeys: String, CodingKey {
        case ID = "ID"
        case BrandID = "BrandID"
        case Code = "Code"
        case Name = "Name"
        case Latitude = "Latitude"
        case Longitude = "Longitude"
        case DeliveryTime = "DeliveryTime"
        case OpenTime = "OpenTime"
        case CloseTime = "CloseTime"
        case ImagePath = "ImagePath"
        case Is24Hour = "Is24Hour"
        case Inactive = "Inactive"
        case brandname = "brandname"
        case Rating = "Rating"
        case ReviewersNumber = "ReviewersNumber"
        case Facilities = "Facilities"
    }
    public init(json:JSON)   {
        self.branchId.value = json[CodingKeys.ID.rawValue].intValue
        self.brandId.value = json[CodingKeys.BrandID.rawValue].intValue
        self.code.value = json[CodingKeys.Code.rawValue].stringValue
        self.name.value = json[CodingKeys.Name.rawValue].stringValue
        self.latitude.value = json[CodingKeys.Latitude.rawValue].doubleValue
        self.longitude.value = json[CodingKeys.Longitude.rawValue].doubleValue
        self.deliveryTime.value = json[CodingKeys.DeliveryTime.rawValue].stringValue
        self.openTime.value = json[CodingKeys.OpenTime.rawValue].stringValue
        self.closeTime.value = json[CodingKeys.CloseTime.rawValue].stringValue
        self.imagePath.value = json[CodingKeys.ImagePath.rawValue].stringValue
        self.is24Hour.value = json[CodingKeys.Is24Hour.rawValue].boolValue
        self.inactive.value = json[CodingKeys.Inactive.rawValue].boolValue
        self.brandName.value = json[CodingKeys.brandname.rawValue].stringValue
        self.rating.value = json[CodingKeys.Rating.rawValue].floatValue
        self.reviewersNumber.value = json[CodingKeys.ReviewersNumber.rawValue].intValue
        self.facilities.value = json[CodingKeys.Facilities.rawValue].arrayValue.map({try! FacilityDTODAL.init(json: $0)})

    }    
}
