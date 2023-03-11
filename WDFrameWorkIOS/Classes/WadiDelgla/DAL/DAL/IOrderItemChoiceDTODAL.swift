//
//  IOrderItemChoiceDTO.swift
//  DAL
//
//  Created by SimpleTouch on 11/14/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
public protocol  IOrderItemChoiceDTODAL:AnyObject {
    var orderDetailID: Observable<Int?> { get set }
    var choiceId: Observable<Int?> {get set}
    var choiceName: Observable<String?> {get set}
    var choiceTotal: Observable<Float?> {get set}
    var choicePrice: Observable<Float?> {get set}
    var choiceQTY: Observable<Int?> {get set}
    var specialTax: Observable<Float?> {get set}
    var currencyCode: Observable<String?> { get set }
 }
