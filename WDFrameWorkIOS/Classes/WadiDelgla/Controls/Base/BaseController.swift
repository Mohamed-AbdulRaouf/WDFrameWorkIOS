//
//  BaseController.swift
//  STMVVM
//
//  Created by SimpleTouch on 9/29/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//
import Foundation
import UIKit
//import BLL
public protocol IBaseController : class {
    associatedtype T
    var viewModel : T? { get set }
    func bindingData()    
}

