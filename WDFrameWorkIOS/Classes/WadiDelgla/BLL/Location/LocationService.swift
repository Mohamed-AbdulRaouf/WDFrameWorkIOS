//
//  LocationService.swift
//  BLL
//
//  Created by SimpleTouch on 10/24/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Alamofire
////import DAL
//MARK:- User
public protocol LocationServiceBLL :AnyObject {
    func getCitiesAndAreas(withBrandId brandId: Int,forLang lang: String,completion: @escaping onSuccessBLL)
}

