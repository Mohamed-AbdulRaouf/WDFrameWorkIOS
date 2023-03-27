//
//  CuisinesDTO.swift
//  DAL
//
//  Created by Nermeen Mohamed on 11/4/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
//import SwiftyJSON
public class CuisinesDTODAL : BaseFilterDTODAL, ICuisinesDTODAL{
 
    public override init(){
        super.init()
    }
    public override init(json: JSON)  {
        super.init(json: json)
     }
    
    required public init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
}
