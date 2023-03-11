//
//  MoreItemDTO.swift
//  DAL
//
//  Created by Nermeen Mohamed on 10/31/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
public class MoreItemDTODAL : IMoreItemDTODAL{
    public var itemName: String
    public var itemImageName: String
 
    public init(_ itemName:String = "",_ itemImageName: String = "") {
        self.itemName = itemName
        self.itemImageName = itemImageName
     }
}
