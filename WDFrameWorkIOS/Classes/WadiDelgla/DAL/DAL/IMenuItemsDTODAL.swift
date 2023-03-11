//
//  IMenuItemsDTO.swift
//  DAL
//
//  Created by SimpleTouch on 11/13/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
public protocol IMenuItemsDTODAL :AnyObject {
    var itemID: Observable<Int?> { get set }
    var itemName: Observable<String?> { get set }
    var itemCalories: Observable<Float?> { get set }
    var itemPrice: Observable<Float?> { get set }
    var ingredients: Observable<String?> { get set }
    var imagePath: Observable<String?> { get set }
    var categoryID: Observable<Int?> { get set }
    var categoryName: Observable<String?> { get set }
    var categoryDescription: Observable<String?> { get set }
    var currencyCode: Observable<String?> { get set }
    var isItemHasMultipleSize: Observable<Bool?> { get set }
    var itemComment: Observable<String?> { get set }
    var sizes: Observable<[IMenuSizeDTODAL]?> { get set }
    var collapsed: Observable<Bool?> { get set }
    func copy() -> Any
}
