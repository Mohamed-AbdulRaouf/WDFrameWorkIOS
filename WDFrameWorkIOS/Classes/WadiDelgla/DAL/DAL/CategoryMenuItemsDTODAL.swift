//
//  CategoryMenuItemsDTO.swift
//  DAL
//
//  Created by SimpleTouch on 11/13/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
//import SwiftyJSON
public  class CategoryMenuItemsDTODAL : ICategoryMenuItemsDTODAL{
    public var categoryID: Observable<Int?> = Observable<Int?>(nil)
    
    public var categoryName: Observable<String?> = Observable<String?>(nil)
    
    public var imageURL: Observable<String?> = Observable<String?>(nil)
    
    public var menuItems: Observable<[IMenuItemsDTODAL]?> = Observable<[IMenuItemsDTODAL]?>(nil)
    
 
    public init(){}
    enum CodingKeys: String, CodingKey {
        case CategoryID = "CategoryID"
        case Name = "Name"
        case ImageURL = "ImageURL"
        case MenuItems = "MenuItems"
    }
    public init(json: JSON)  {
        self.categoryID.value = json[CodingKeys.CategoryID.rawValue].intValue
        self.categoryName.value =  json[CodingKeys.Name.rawValue].stringValue
        self.imageURL.value =  json[CodingKeys.ImageURL.rawValue].stringValue
        self.menuItems.value = json[CodingKeys.MenuItems.rawValue].arrayValue.map({try! MenuItemsDTODAL.init(json: $0)})
    }
    
}
