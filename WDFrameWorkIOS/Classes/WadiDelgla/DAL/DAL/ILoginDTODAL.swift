//
//  ILoginDTO.swift
//  DAL
//
//  Created by SimpleTouch on 10/9/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
public protocol  ILoginDTODAL :AnyObject {
    var mobile: Observable<String?> { get set }
    var password: Observable<String?> { get set }
    var brandId: Observable<Int?> { get set }
    var countryId: Observable<String?> { get set }
    var dialCode: Observable<String?> { get set }
    var hintNumber: Observable<String?> { get set }
}
