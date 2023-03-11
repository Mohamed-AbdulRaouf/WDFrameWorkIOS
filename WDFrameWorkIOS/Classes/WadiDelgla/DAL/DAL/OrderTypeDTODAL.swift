//
//  OrderTypeDTO.swift
//  DAL
//
//  Created by SimpleTouch on 9/28/20.
//  Copyright © 2020 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
import SwiftyJSON
public class OrderTypeDTODAL : IOrderTypeDTODAL{
    
    public var itemId: Observable<Int?> = Observable<Int?>(nil)
    
    public var itemTitle: Observable<String?> = Observable<String?>(nil)
    
    public var itemImage: Observable<String?> = Observable<String?>(nil)
    
    public init(){}
    
    enum CodingKeys: String, CodingKey {
        case ItemID = "ItemID"
        case ItemTitle = "ItemTitle"
        case ItemImage = "ItemImage"
    }
    public init(id: Int,name:String,image:String){
        self.itemId.value = id
        self.itemTitle.value = name
        self.itemImage.value = image
    }
    public init(json:JSON)   {
        self.itemId.value = json[CodingKeys.ItemID.rawValue].intValue
        self.itemTitle.value = json[CodingKeys.ItemTitle.rawValue].stringValue
        self.itemImage.value = json[CodingKeys.ItemImage.rawValue].stringValue
    }
}
