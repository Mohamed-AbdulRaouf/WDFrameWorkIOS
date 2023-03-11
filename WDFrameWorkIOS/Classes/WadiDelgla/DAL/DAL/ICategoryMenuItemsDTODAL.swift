//
//  ICategoryMenuItemsDTO.swift
//  DAL
//
//  Created by SimpleTouch on 11/13/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
public protocol  ICategoryMenuItemsDTODAL :AnyObject {
    var categoryID: Observable<Int?> { get set }
    var categoryName: Observable<String?> { get set }
    var imageURL: Observable<String?> { get set }
    var menuItems: Observable<[IMenuItemsDTODAL]?> { get set }
 }
