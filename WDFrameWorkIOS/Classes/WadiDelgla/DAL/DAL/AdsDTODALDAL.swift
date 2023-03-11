//
//  AdsDTO.swift
//  DAL
//
//  Created by Nermeen Mohamed on 10/28/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
import SwiftyJSON
public  class AdsDTODAL : IAdsDTODAL{
    public var id: Observable<Int?> = Observable<Int?>(nil)
    
    public var adsTitle: Observable<String?> = Observable<String?>(nil)
    
    public var adsDescription: Observable<String?> = Observable<String?>(nil)
    
    public var imagePath: Observable<String?> = Observable<String?>(nil)
    
    
     public init(){}
    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case imagePath = "ImagePath"
        case title = "TextH"
        case description = "Description"
    }
    public init(json: JSON)  {
        self.id.value = json[CodingKeys.id.rawValue].intValue
        self.imagePath.value =  json[CodingKeys.imagePath.rawValue].stringValue
        self.adsTitle.value = json[CodingKeys.title.rawValue].stringValue
        self.adsDescription.value = json[CodingKeys.description.rawValue].stringValue
    }
    
}
