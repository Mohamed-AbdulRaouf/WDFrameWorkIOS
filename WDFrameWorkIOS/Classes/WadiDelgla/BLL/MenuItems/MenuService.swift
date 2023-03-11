//
//  MenuService.swift
//  BLL
//
//  Created by SimpleTouch on 11/13/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Alamofire
////import DAL
//MARK:- Brand
public protocol MenuServiceBLL :AnyObject {
    func getMenuItems(_ requestcategoryListDTO: IRequestCategoryListDTODAL, completion: @escaping onSuccessBLL)
    func getMenuCategoryList(_ requestcategoryListDTO: IRequestCategoryListDTODAL, completion: @escaping onSuccessBLL)
 }
