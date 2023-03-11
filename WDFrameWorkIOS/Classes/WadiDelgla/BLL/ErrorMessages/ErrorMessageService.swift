//
//  ErrorMessageService.swift
//  BLL
//
//  Created by SimpleTouch on 5/31/20.
//  Copyright © 2020 SimpleTouch. All rights reserved.
//

import Foundation
import Alamofire
////import DAL
//MARK:- Brand
public protocol ErrorMessageServiceBLL :AnyObject {
    func getErrorMessages(completion: @escaping onSuccessBLL)
}

