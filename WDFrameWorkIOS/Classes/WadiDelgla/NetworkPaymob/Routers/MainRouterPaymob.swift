//
//  AuthNetworkRouter.swift
//  ProjectMVC
//
//  Created by Mohamed Abdul-Raouf on 05/01/2022.
//

//
//  AuthNetworkRouter.swift
//  Abilities
//
//  Created by Raouf on 11/10/2021.
//

import Alamofire

import Foundation
import Alamofire

struct Constants {
    static var PayMobBaseUrl: String {
        return "https://accept.paymob.com/api/"
    }
    
    static var PayMobIntegrationID: Int {
        return UserDefaults.standard.integer(forKey: "PayMobIntegrationID") ?? 0
    }
    
    static var PayMobApiKey: String {
        return UserDefaults.standard.string(forKey: "PayMobApiKey") ?? ""
    }
}

enum MainRouterPaymob: URLRequestConvertiblePaymob {
    
    case authenticationRequest
    case orderRegistration(amount: Double)
    case paymentKeyRequest(amount: Double)
    
    
    var method: HTTPMethod {
        return .post
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .authenticationRequest:
            return [
                "api_key": Constants.PayMobApiKey
            ]
        case .orderRegistration(let amount):
            return [
                "auth_token": UserDefaultsApp.shared.auth_token,
                "delivery_needed": "false",
                  "amount_cents": "\(Int(amount * 100))",
                  "currency": "EGP",
                "items": []
            ]
        case .paymentKeyRequest(let amount):
            return [
                "auth_token": UserDefaultsApp.shared.auth_token,
                "expiration": 3600,
                "order_id": UserDefaultsApp.shared.orderPayID,
                "merchant_order_id": UserDefaultsApp.shared.orderID,
                "delivery_needed": "false",
                "amount_cents": "\(Int(amount * 100))",
                "currency": "EGP",
                "integration_id": Constants.PayMobIntegrationID,
                "lock_order_when_paid": "false",
                "billing_data": [
                    "apartment": "1",
                    "email": GlobalConstants.shared.membershipNumber,
                    "floor": "1",
                    "first_name": GlobalConstants.shared.firstName,
                    "street": "Cairo",
                    "building": "1",
                    "phone_number": GlobalConstants.shared.mobile,
                    "shipping_method": "PKG",
                    "postal_code": "1",
                    "city": "Cairo",
                    "country": "EGY",
                    "last_name": GlobalConstants.shared.lastName,
                    "state": "none"
                ]
            ]
        }
    }
    
    var url: URL {
        return URLComponents(string: "\(Constants.PayMobBaseUrl)\(path)")!.url!
    }
    
    var path: String {
        switch self {
        case .authenticationRequest:
            return "auth/tokens"
        case .orderRegistration:
            return "ecommerce/orders"
        case .paymentKeyRequest:
            return "acceptance/payment_keys"
        }
    }
    
    var encoding: ParameterEncoding {
        return JSONEncoding.default
    }
    
    func asURLRequest() throws -> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        return try encoding.encode(urlRequest, with: parameters)
    }
}
