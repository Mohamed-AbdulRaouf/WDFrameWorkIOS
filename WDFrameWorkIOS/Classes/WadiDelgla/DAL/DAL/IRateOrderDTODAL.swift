//
//  IRateOrderDTO.swift
//  DAL
//
//  Created by SimpleTouch on 11/27/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
public protocol IRateOrderDTODAL:AnyObject {
    var brandId: Observable<Int?> {get set}
    var brandName: Observable<String?> { get set }
    var customerId: Observable<Int?> {get set}
    var customerHistoryId: Observable<Int?> {get set}
    var isOrderRatedBefore: Observable<Bool?> {get set}
    var isBrandHasRatingItems: Observable<Bool?> {get set}
    var brandCategories: Observable<[BrandCategoryDTODAL]?> {get set}
    var comment: Observable<String?> { get set }
    var JSONRepresentation: Dictionary<String, Any> {get}

 }
