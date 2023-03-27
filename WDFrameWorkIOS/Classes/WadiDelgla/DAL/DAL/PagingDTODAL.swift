//
//  PagingDTO.swift
//  DAL
//
//  Created by Nermeen Mohamed on 10/28/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
//import SwiftyJSON
public  class PagingDTODAL : IPagingDTODAL{
    public var pageNumber: Observable<Int?> = Observable<Int?>(nil)
    
    public var pageSize: Observable<Int?> = Observable<Int?>(nil)
    
    public init(){}
 
}
