//
//  IConfirmMyFatoorahPAymentDTO.swift
//  DAL
//
//  Created by Nermeen Mohamed on 28/06/2021.
//  Copyright © 2021 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
public protocol  IConfirmMyFatoorahPaymentDTODAL:AnyObject {
    var referencePaymentId: Observable<String?> { get set }
    var referenceTransactionId: Observable<String?> { get set }
    var referenceInvoiceId: Observable<String?> { get set }
    var frontOrderReferenceId: Observable<String?> { get set }
    var customerHistoryId: Observable<Int?> { get set }
    var orderId: Observable<String?> { get set }
    var status: Observable<Bool?> { get set }

}
