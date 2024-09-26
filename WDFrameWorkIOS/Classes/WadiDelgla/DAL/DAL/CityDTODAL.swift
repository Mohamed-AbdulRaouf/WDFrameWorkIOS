//
//  CityDTO.swift
//  DAL
//
//  Created by SimpleTouch on 10/24/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Bond
//import SwiftyJSON
public class CityDTODAL :SearchItemDTOModelDAL,ICityDTODAL  {
    
    public  var areas: Observable<[SearchItemDTOModelDAL]?> = Observable<[SearchItemDTOModelDAL]?>(nil)
 
    public override init(){
        super.init()
    }
    
    enum CityCodingKeys: String, CodingKey {
         case area = "area"
     }
    public override init(json: JSON)  {
        super.init(json: json)
        self.areas.value =  json["Areas"].arrayValue.map({try! SearchItemDTOModelDAL(json: $0)})
      }
    
    public override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CityCodingKeys.self)
        try container.encode(areas.value, forKey: .area)
 
    }
    required public init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: CityCodingKeys.self)
        
        super.init()       
    }
}
