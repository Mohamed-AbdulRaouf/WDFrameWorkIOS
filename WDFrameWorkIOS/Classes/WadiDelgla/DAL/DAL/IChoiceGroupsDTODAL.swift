//
//  IChoiceGroupsDTO.swift
//  DAL
//
//  Created by SimpleTouch on 11/13/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
public protocol IChoiceGroupsDTODAL :AnyObject {
    var choiceGroupId: Observable<Int?> { get set }
    var choiceGroupTitle: Observable<String?> { get set }
    var minChoiceSelected: Observable<Int?> { get set }
    var maxChoiceSelected: Observable<Int?> { get set }
    var itemSizeID: Observable<Int?> { get set }
    var isSelectedMinMax: Observable<Bool?> { get set }
    var choices: Observable<[IChoiceDTODAL]?> { get set }
    var collapsed: Observable<Bool?> { get set }
      func copy() -> Any
}
