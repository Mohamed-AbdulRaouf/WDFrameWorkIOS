//
//  CountryRoute.swift
//  BLL
//
//  Created by SimpleTouch on 11/15/20.
//  Copyright © 2020 SimpleTouch. All rights reserved.
//

import Foundation
import Alamofire
////import DAL
enum CountryRouteBLL: URLRequestBuilderBLL {
    case getAllAvailableCountries
    case getBrandAvailableCountries(brandId: Int)
    // MARK: - Path
    internal var path: ServerPathsBLL {
        switch self {
        case .getAllAvailableCountries:
            return .GET_ALL_AVAILABLE_COUNTRIES
        case .getBrandAvailableCountries:
            return .GET_BRAND_AVAILABLE_COUNTRIES
        }
    }
    
    // MARK: - Parameters
    internal var parameters: Parameters? {
        var params = defaultParams
        switch self {
        case  .getAllAvailableCountries,.getBrandAvailableCountries:
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
        case .getAllAvailableCountries:
            params.append(Config.language)
        case let .getBrandAvailableCountries(brandId):
           params.append(String(brandId))
           params.append(Config.language)
        default: break
        }
        return params
    }
    internal var urlQueryParameters: [[String : String]]?{
        let params = [[String : String]]()
        switch self {

        default:break
        }
        return params
    }
    // MARK: - Methods
    internal var method: HTTPMethod {
        switch self {
        case .getAllAvailableCountries,.getBrandAvailableCountries:
            return .get
        default :
            return .post
        }
    }
}
