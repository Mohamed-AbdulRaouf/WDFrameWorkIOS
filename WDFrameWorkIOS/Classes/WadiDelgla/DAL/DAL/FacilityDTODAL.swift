//
//  FacilityDTO.swift
//  DAL
//
//  Created by Nermeen Mohamed on 11/4/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
import SwiftyJSON
public class FacilityDTODAL : BaseFilterDTODAL,Codable, IFacilityDTODAL{
    public var facilityDescription: Observable<String?> = Observable<String?>(nil)
    
    public var facilityIcon: Observable<String?> = Observable<String?>(nil)
    
    public var brandId: Observable<Int?> = Observable<Int?>(nil)
    
    
    public override init(){
        super.init()
    }
    
    enum FacilityCodingKeys: String, CodingKey {
        case facilityDescription = "Description"
        case facilityIcon = "FacilityIcon"
        case brandId = "BrandID"
    }
    public override init(json: JSON)  {
        super.init(json: json)
        self.facilityDescription.value = json[FacilityCodingKeys.facilityDescription.rawValue].stringValue
        self.facilityIcon.value =  json[FacilityCodingKeys.facilityIcon.rawValue].stringValue
        self.brandId.value =  json[FacilityCodingKeys.brandId.rawValue].intValue
    }
    
    public override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: FacilityCodingKeys.self)
        try container.encode(facilityDescription.value, forKey: .facilityDescription)
        try container.encode(facilityIcon.value, forKey: .facilityIcon)
        try container.encode(brandId.value, forKey: .brandId)
        let superencoder = container.superEncoder()
        try super.encode(to: superencoder)
        
        
    }
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: FacilityCodingKeys.self)
        facilityDescription.value = try container.decodeIfPresent(String.self,forKey: .facilityDescription)
        facilityIcon.value = try container.decodeIfPresent(String.self,forKey: .facilityIcon)
        brandId.value = try container.decodeIfPresent(Int.self,forKey: .brandId)
        let superdecoder = try container.superDecoder()
        try super.init(from: superdecoder)
    }
    
}
