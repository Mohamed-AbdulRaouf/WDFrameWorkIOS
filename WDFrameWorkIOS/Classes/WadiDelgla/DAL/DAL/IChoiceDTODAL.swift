//
//  IChoiceDTO.swift
//  DAL
//
//  Created by SimpleTouch on 11/13/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
public protocol IChoiceDTODAL :AnyObject {
    var choiceId: Observable<Int?> { get set }
    var choiceName: Observable<String?> { get set }
    var choicePrice: Observable<Float?> { get set }
    var isSelectedChoice: Observable<Bool?> { get set }
    var currencyCode: Observable<String?> { get set }
    var itemChoiceSizeID: Observable<Int?> { get set }
    func copy() -> Any
}
