//
//  IRequestOrderListDTO.swift
//  DAL
//
//  Created by Nermeen Mohamed on 10/31/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
public protocol IRequestDTODAL :IPagingDTODAL{
     var brandId: Observable<Int?> {get set}
    
}
