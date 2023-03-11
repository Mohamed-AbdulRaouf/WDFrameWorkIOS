//
//  RequestOrderListDTO.swift
//  DAL
//
//  Created by Nermeen Mohamed on 10/31/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
public class RequestDTODAL:PagingDTODAL, IRequestDTODAL {
   public var brandId: Observable<Int?> = Observable<Int?>(nil)
    public override init(){}
}
