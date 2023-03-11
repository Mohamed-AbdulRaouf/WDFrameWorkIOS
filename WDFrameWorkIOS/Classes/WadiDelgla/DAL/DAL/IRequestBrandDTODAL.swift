//
//  IRequestBrandDTO.swift
//  DAL
//
//  Created by SimpleTouch on 11/6/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
public protocol IRequestBrandDTODAL :AnyObject {
    var brandsMe: Observable<Int?> { get set }
    var areaID: Observable<Int?> { get set }
    var feedMe: Observable<String?> { get set }
    var cusineIDs: Observable<String?> { get set }
    var serviceIDs: Observable<String?> { get set }
    var facilityIDs: Observable<String?> { get set }
    var sortID: Observable<String?> { get set }
    var lang: Observable<String?> { get set }
    var pageIndex: Observable<String?> { get set }
    var pageSize: Observable<String?> { get set }
    var brandName: Observable<String?> { get set }
}

