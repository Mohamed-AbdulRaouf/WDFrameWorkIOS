//
//  ErrorMessageRoute.swift
//  BLL
//
//  Created by SimpleTouch on 5/31/20.
//  Copyright © 2020 SimpleTouch. All rights reserved.
//

import Foundation
import Alamofire
////import DAL
enum ErrorMessageRouteBLL: URLRequestBuilderBLL {
    
    case getErrorMessage
    // MARK: - Path
    internal var path: ServerPathsBLL {
        switch self {
        case .getErrorMessage:
            return .GET_ERROR_MESSAGES
        }
    }
    
    // MARK: - Parameters
    internal var parameters: Parameters? {
        var params = defaultParams
        switch self {
        case  .getErrorMessage:
           return nil
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
        case .getErrorMessage: break
        default: break
        }
        return params
    }
    internal var urlQueryParameters: [[String : String]]?{
        var params = [[String : String]]()
        switch self {
        case .getErrorMessage: break
        default:break
        }
        return params
    }
    // MARK: - Methods
    internal var method: HTTPMethod {
        switch self {
        case .getErrorMessage:
            return .get
        default :
            return .post
        }
    }
}
