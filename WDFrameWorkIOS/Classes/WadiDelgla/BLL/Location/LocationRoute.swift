//
//  LocationRoute.swift
//  BLL
//
//  Created by SimpleTouch on 10/24/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Alamofire
////import DAL
enum LocationRoute: URLRequestBuilderBLL {
    
    
    //location
    case getCityAndAreas(language:String,brandId:Int)
    
    // MARK: - Path
    internal var path: ServerPathsBLL {
        switch self {
        case .getCityAndAreas:
            return .GET_CITIES_AREAS
        }
    }
    
    
    // MARK: - Parameters
    internal var parameters: Parameters? {
        let params = defaultParams
        switch self {
        case .getCityAndAreas:
            break;
        }
        return params
    }
    internal var urlParameters: [String]? {
        var params = [String]()
        switch self {
        case let .getCityAndAreas(language,brandId):
            params.append(String(brandId))
            params.append(language)
        }
        return params
    }
    internal var headers: HTTPHeaders {
            let default_headers = defaultHeaders
               return default_headers
           }
    internal var urlQueryParameters: [[String : String]]? {
        var params =  [[String : String]]()
        switch self {
        case  .getCityAndAreas:
            break
        }
        return params
    }
    // MARK: - Methods
    internal var method: HTTPMethod {
        switch self {
        case .getCityAndAreas:
            return .get
            
        }
    }
}
