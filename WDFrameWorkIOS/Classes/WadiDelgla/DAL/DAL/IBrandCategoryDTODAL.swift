//
//  IBrandCategoryDTO.swift
//  DAL
//
//  Created by SimpleTouch on 11/27/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
public protocol IBrandCategoryDTODAL:AnyObject {
    var brandRateCategoryId: Observable<Int?> {get set}
    var brandRateCategoryName: Observable<String?> { get set }
    var brandRatingItems: Observable<[BrandRatingItemDTODAL]?> { get set }
}
