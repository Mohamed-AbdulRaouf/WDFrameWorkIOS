//
//  ICustomErrorDTO.swift
//  DAL
//
//  Created by SimpleTouch on 3/16/20.
//  Copyright © 2020 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
public protocol  ICustomErrorDTODAL:AnyObject {
    var code: Observable<Int?> {get set}
    var error_en: Observable<String?> { get set }
    var error_ar: Observable<String?> { get set }
 }
