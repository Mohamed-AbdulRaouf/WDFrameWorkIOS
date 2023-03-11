//
//  IBaseDTO.swift
//  DAL
//
//  Created by SimpleTouch on 11/24/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
public protocol  IBaseDTODAL  {
    var lang: Observable<String?> { get set }
    var customerSourceID: Observable<Int?> { get set }
}
