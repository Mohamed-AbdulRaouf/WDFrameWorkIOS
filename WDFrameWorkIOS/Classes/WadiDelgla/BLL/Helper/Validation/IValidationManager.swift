//
//  IValidationManager.swift
//  BLL
//
//  Created by SimpleTouch on 10/7/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
////import DAL
public protocol IValidationManagerBLL : AnyObject {
    associatedtype T
    associatedtype M
    func validate(model: T) -> Bool
    var errorViewModel : M? { get set }
    init(errorModel: M)
}
