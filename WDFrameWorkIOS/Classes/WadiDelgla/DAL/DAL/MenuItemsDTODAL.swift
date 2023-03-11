//
//  MenuItemsDTO.swift
//  DAL
//
//  Created by SimpleTouch on 11/13/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
import SwiftyJSON
public  class MenuItemsDTODAL : IMenuItemsDTODAL{
 
    public var itemID: Observable<Int?> = Observable<Int?>(nil)
    
    public var itemName: Observable<String?> = Observable<String?>(nil)
    
    public var itemCalories: Observable<Float?> = Observable<Float?>(nil)
    
    public var itemPrice: Observable<Float?> = Observable<Float?>(nil)
    
    public var ingredients: Observable<String?> = Observable<String?>(nil)
    
    public var imagePath: Observable<String?> = Observable<String?>(nil)
    
    public var categoryID: Observable<Int?> = Observable<Int?>(nil)
    
    public var categoryName: Observable<String?> = Observable<String?>(nil)
    
    public var categoryDescription: Observable<String?> = Observable<String?>(nil)
    
    public var currencyCode: Observable<String?> = Observable<String?>(nil)
    
    public var isItemHasMultipleSize: Observable<Bool?> = Observable<Bool?>(nil)

    public var itemComment: Observable<String?> = Observable<String?>(nil)
    
    public var sizes: Observable<[IMenuSizeDTODAL]?> = Observable<[IMenuSizeDTODAL]?>(nil)
    
    public var collapsed: Observable<Bool?> = Observable<Bool?>(nil)

    public init(){}
    enum CodingKeys: String, CodingKey {
        case ItemID = "ItemID"
        case Name = "Name"
        case Calories = "Calories"
        case Price = "Price"
        case Ingredients = "Ingredients"
        case ImagePath = "ImagePath"
        case CategoryID = "CategoryID"
        case CategoryName = "CategoryName"
        case Description = "Description"
        case CurrencyCode = "CurrencyCode"
        case IsItemHasMultipleSize = "IsItemHasMultipleSize"
        case Sizes = "Sizes"
    }
    public init(json: JSON)  {
        self.itemID.value = json[CodingKeys.ItemID.rawValue].intValue
        self.itemName.value =  json[CodingKeys.Name.rawValue].stringValue
        self.itemCalories.value = json[CodingKeys.Calories.rawValue].floatValue
        self.itemPrice.value = json[CodingKeys.Price.rawValue].floatValue
        self.ingredients.value = json[CodingKeys.Ingredients.rawValue].stringValue
        self.imagePath.value = json[CodingKeys.ImagePath.rawValue].stringValue
        self.categoryID.value = json[CodingKeys.CategoryID.rawValue].intValue
        self.categoryName.value = json[CodingKeys.CategoryName.rawValue].stringValue
        self.categoryDescription.value = json[CodingKeys.Description.rawValue].stringValue
        self.currencyCode.value = json[CodingKeys.CurrencyCode.rawValue].stringValue
        self.isItemHasMultipleSize.value = json[CodingKeys.IsItemHasMultipleSize.rawValue].boolValue
        self.itemComment.value = ""
        self.sizes.value = json[CodingKeys.Sizes.rawValue].arrayValue.map({try! MenuSizeDTODAL.init(json: $0)})
        self.collapsed.value = false
    }
    public init(itemID: Int?,itemName: String?, itemCalories: Float?,itemPrice: Float?,ingredients: String?,imagePath: String?,categoryID: Int?,categoryName: String?,categoryDescription: String?,currencyCode: String?,isItemHasMultipleSize: Bool?,itemComment: String?,sizes: [IMenuSizeDTODAL]?,collapsed: Bool?){
        self.itemID.value = itemID
        self.itemName.value =  itemName
        self.itemCalories.value = itemCalories
        self.itemPrice.value = itemPrice
        self.ingredients.value = ingredients
        self.imagePath.value = imagePath
        self.categoryID.value = categoryID
        self.categoryName.value = categoryName
        self.categoryDescription.value = categoryDescription
        self.currencyCode.value =  currencyCode
        self.isItemHasMultipleSize.value = isItemHasMultipleSize
        self.itemComment.value = itemComment
        self.sizes.value =  sizes
        self.collapsed.value = collapsed
    }
    public init(item: IMenuItemsDTODAL){
        self.itemID.value = item.itemID.value
        self.itemName.value =  item.itemName.value
        self.itemCalories.value =  item.itemCalories.value
        self.itemPrice.value = item.itemPrice.value
        self.ingredients.value = item.ingredients.value
        self.imagePath.value = item.imagePath.value
        self.categoryID.value = item.categoryID.value
        self.categoryName.value = item.categoryName.value
        self.categoryDescription.value = item.categoryDescription.value
        self.currencyCode.value =  item.currencyCode.value
        self.isItemHasMultipleSize.value = item.isItemHasMultipleSize.value
        self.itemComment.value = item.itemComment.value
        self.sizes.value =  item.sizes.value
        self.collapsed.value = item.collapsed.value
    }
    
    
   public  func copy() -> Any {
    let copy = MenuItemsDTODAL(itemID: itemID.value, itemName: itemName.value, itemCalories: itemCalories.value, itemPrice: itemPrice.value, ingredients: ingredients.value, imagePath: imagePath.value, categoryID: categoryID.value, categoryName: categoryName.value, categoryDescription: categoryDescription.value, currencyCode: currencyCode.value, isItemHasMultipleSize: isItemHasMultipleSize.value,itemComment: itemComment.value, sizes: sizes.value?.map({$0.copy() as! IMenuSizeDTODAL}),collapsed: collapsed.value)
        return copy
    }
}
