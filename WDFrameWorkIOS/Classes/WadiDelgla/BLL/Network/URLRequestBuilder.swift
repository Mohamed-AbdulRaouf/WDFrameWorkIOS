//
//  URLRequestBuilder.swift
//  Netwroking
//
//  Created by SimpleTouch on 9/22/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Alamofire


public protocol URLRequestBuilderBLL: URLRequestConvertible {
    
    var mainURL: URL { get }
    var requestURL: URL { get }
    // MARK: - Path
    var path: ServerPathsBLL { get }
    
    var headers: HTTPHeaders { get }
    // MARK: - Parameters
    var parameters: Parameters? { get }
    
    // MARK: - Methods
    var method: HTTPMethod { get }
    
    var encoding: ParameterEncoding { get }
    
    var urlRequest: URLRequest { get }
    
    var deviceId: String { get }
    
    var urlParameters : [String]? { get }
 
    var urlQueryParameters: [[String: String]]? {get}
}

extension URLRequestBuilderBLL {
    var mainURL: URL {
         return URL(string: ConfigurationsBLL.shared.serverURL)!
        
    }
   
    var requestURL: URL {
        get{
            guard let _ = self.urlParameters , let _ = self.urlQueryParameters else{
                return mainURL.appendingPathComponent(path.rawValue)
            }
            var url =  mainURL.appendingPathComponent(path.rawValue)
            if let params = self.urlParameters {
                for param in params {
                    url = url.appendingPathComponent(param)
                }
            }
            if let queryParams = self.urlQueryParameters {
                for param in queryParams{
                    url = url.appendingQueryParameters(param)
                }
            }
            return url
        }
    }
    
    var defaultHeaders: HTTPHeaders {
        var header = HTTPHeaders()
        
        header[HTTPHeaderField.contentType.rawValue] = ContentType.json.rawValue
        
        if let token = UserDefaults.user?.token.value {
            header["Authorization"] = "Bearer \(token)"
        }
        if let country = UserDefaults.currentAppCountry,let countryId = country.countryId.value {
             header["X-Dobites-Country-Id"] = countryId
        }
        return header
    }
    
    var defaultParams: Parameters {
        var param = Parameters()
        param[KBLL.APIParameterKey.language] = Config.language
        param[KBLL.APIParameterKey.CustomerSourceID] = Config.customerSourceId
        param[KBLL.APIParameterKey.customerSourceID] = Config.customerSourceId
        param[KBLL.APIParameterKey.mobileAppToken] =  Config.fcmToken == "" ? UserDefaults.fcmToken :  Config.fcmToken

        return param
    }

    var encoding: ParameterEncoding {
        switch method {
        case .get:
            return URLEncoding.default
        default:
            return JSONEncoding.default
        }
    }
    
    var urlRequest: URLRequest {
        var request = URLRequest(url: requestURL)
        request.httpMethod = method.rawValue
        return request
    }
    
    var deviceId: String {
        return UIDevice.current.identifierForVendor?.uuidString ?? ""
    }
    
    func asURLRequest() throws -> URLRequest {
        return try encoding.encode(urlRequest, with: parameters)
    }
    
}
