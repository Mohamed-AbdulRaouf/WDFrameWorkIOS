//
//  IFacilityDTO.swift
//  DAL
//
//  Created by Nermeen Mohamed on 11/4/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
public protocol IFacilityDTODAL :IBaseFilterDTODAL {
    var facilityDescription: Observable<String?> { get set }
    var facilityIcon: Observable<String?> { get set }
    var brandId: Observable<Int?> { get set }
    
}

