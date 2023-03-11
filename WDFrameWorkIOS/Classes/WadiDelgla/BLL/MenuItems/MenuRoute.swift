//
//  MenuRoute.swift
//  BLL
//
//  Created by SimpleTouch on 11/13/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Alamofire
////import DAL
enum MenuRouteBLL: URLRequestBuilderBLL {
    // home
    case getMenuItems(requestCategoryListDTO: IRequestCategoryListDTODAL)
    case getMenuCategoryList(requestCategoryListDTO: IRequestCategoryListDTODAL)
    // MARK: - Path
    internal var path: ServerPathsBLL {
        switch self {
        case .getMenuItems:
            return .GET_MENU_ITEMS
        case.getMenuCategoryList:
            return .GET_MENU_CATEGORIES
        }
    }
    
    // MARK: - Parameters
    internal var parameters: Parameters? {
        var params = defaultParams
        switch self {
        case  .getMenuItems,.getMenuCategoryList:
            break
        default:
            break
        }
        return params
    }
    internal var headers: HTTPHeaders {
            let default_headers = defaultHeaders
               return default_headers
           }
    internal var urlParameters: [String]? {
        var params = [String]()
        switch self {
        case let .getMenuItems(requestCategoryListDTO):
            params.append(String(requestCategoryListDTO.brandId.value ?? 0))
            params.append(String(requestCategoryListDTO.areaId.value ?? 0))
            params.append(Config.language)
            params.append(String(requestCategoryListDTO.pageIndex.value!))
            params.append(String(requestCategoryListDTO.pageSize.value!))
        case let .getMenuCategoryList(requestCategoryListDTO):
            params.append(String(requestCategoryListDTO.brandId.value ?? 0))
            params.append(Config.language)
            params.append(String(requestCategoryListDTO.pageIndex.value!))
            params.append(String(requestCategoryListDTO.pageSize.value!))
            params.append(String(requestCategoryListDTO.areaId.value ?? 0))

        }
        return params
    }
    internal var urlQueryParameters: [[String : String]]?{
        var params = [[String : String]]()
        switch self {
            
        default:break
        }
        return params
    }
    // MARK: - Methods
    internal var method: HTTPMethod {
        switch self {
        case .getMenuCategoryList,.getMenuItems:
            return .get
        default :
            return .post
        }
    }
}
