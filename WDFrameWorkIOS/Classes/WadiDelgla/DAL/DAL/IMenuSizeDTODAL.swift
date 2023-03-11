//
//  IMenuSizeDTO.swift
//  DAL
//
//  Created by SimpleTouch on 11/13/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
public protocol IMenuSizeDTODAL :AnyObject {
    var sizeId: Observable<Int?> { get set }
    var itemId: Observable<Int?> { get set }
    var sizeCode: Observable<String?> { get set }
    var sizeName: Observable<String?> { get set }
    var sizePrice: Observable<Float?> { get set }
    var currencyCode: Observable<String?> { get set }
    var isSelected: Observable<Bool?> { get set }
    var choiceGroups: Observable<[IChoiceGroupsDTODAL]?> { get set }
     func copy() -> Any
}
