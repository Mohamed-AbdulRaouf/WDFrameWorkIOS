//
//  IBrandRatingItemDTO.swift
//  DAL
//
//  Created by SimpleTouch on 11/27/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
public protocol IBrandRatingItemDTODAL:AnyObject {
    var brandRatingItemId: Observable<Int?> {get set}
    var brandRatingItemName: Observable<String?> { get set }
    var value: Observable<Float?> { get set }
}
