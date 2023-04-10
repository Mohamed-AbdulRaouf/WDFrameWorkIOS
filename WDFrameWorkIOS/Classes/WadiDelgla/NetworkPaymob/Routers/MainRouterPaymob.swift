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
    
    static var PayMobApiKey: String {
        return "ZXlKaGJHY2lPaUpJVXpVeE1pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SmpiR0Z6Y3lJNklrMWxjbU5vWVc1MElpd2ljSEp2Wm1sc1pWOXdheUk2TVRJMU1UUXlMQ0p1WVcxbElqb2lhVzVwZEdsaGJDSjkuaGxYZmRRaWU4ZXNwWnJSa1ZnUXdWSnlLalJYQ2h0WEoyYmxQSlBHM3lxeEUySUxuWW5zeEVfZGpiOUZ0N0d4WkFXb0RKZVpOeGhrVmdNa1daOWtZUHc="
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
                "delivery_needed": "false",
                "amount_cents": "\(Int(amount * 100))",
                "currency": "EGP",
                "integration_id": 1025114,
                "lock_order_when_paid": "false",
                "billing_data": [
                    "apartment": "803",
                    "email": "mohamed.a.raouf@icloud.com",
                    "floor": "42",
                    "first_name": "Mohamed",
                    "street": "Ethan Land",
                    "building": "8028",
                    "phone_number": "+201002002829",
                    "shipping_method": "PKG",
                    "postal_code": "01898",
                    "city": "Cairo",
                    "country": "EGY",
                    "last_name": "Nicolas",
                    "state": "Utah"
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
