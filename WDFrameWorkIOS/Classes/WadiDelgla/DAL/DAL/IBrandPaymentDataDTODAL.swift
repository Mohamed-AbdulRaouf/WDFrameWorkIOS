//
//  IPaymentDTO.swift
//  DAL
//
//  Created by SimpleTouch on 8/9/20.
//  Copyright © 2020 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
public protocol  IBrandPaymentDataDTODAL:AnyObject {
    var brandId: Observable<Int?> { get set }
    var merchantId: Observable<String?> { get set }
    var apiKey: Observable<String?> { get set }
}
