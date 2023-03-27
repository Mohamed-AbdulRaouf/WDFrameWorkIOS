//
//  GenericSectionDTO.swift
//  DAL
//
//  Created by SimpleTouch on 11/11/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
//import SwiftyJSON
public  class FilterationSectionDTO : IGenericFilterSectionDTO{

    public var title: Observable<String?> = Observable<String?>(nil)
    
    public var items: Observable<[IBaseFilterDTODAL]?> = Observable<[IBaseFilterDTODAL]?>(nil)
    
    public init(){}
    public init(title: String, items: [IBaseFilterDTODAL]){
        self.title.value = title
        self.items.value = items
    }
 
}
