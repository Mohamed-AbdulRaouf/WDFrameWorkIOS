//
//  IConfirmPaymentDTO.swift
//  DAL
//
//  Created by SimpleTouch on 8/11/20.
//  Copyright © 2020 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
public protocol  IConfirmPaymentDTODAL:AnyObject {
    var transactionId: Observable<String?> { get set }
    var merchanOrderId: Observable<String?> { get set }
    var orderId: Observable<String?> { get set }
    var status: Observable<Bool?> { get set }
    var customerID: Observable<Int?> { get set }

}
