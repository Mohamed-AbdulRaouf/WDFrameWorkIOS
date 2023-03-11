//
//  IPagingDTO.swift
//  DAL
//
//  Created by Nermeen Mohamed on 10/28/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
public protocol  IPagingDTODAL :AnyObject {
    var pageNumber: Observable<Int?> { get set }
    var pageSize: Observable<Int?> { get set }
}
