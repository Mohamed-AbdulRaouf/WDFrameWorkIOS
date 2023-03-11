//
//  IMyFatoorahBrandPAymentDataDTO.swift
//  DAL
//
//  Created by Nermeen Mohamed on 28/06/2021.
//  Copyright © 2021 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
public protocol  IMyFatoorahBrandPaymentDataDTODAL:AnyObject {
    var brandId: Observable<Int?> { get set }
    var paymentBaseUrl: Observable<String?> { get set }
    var paymentToken: Observable<String?> { get set }
    var paymentMethod: Observable<Int?> { get set }
}
