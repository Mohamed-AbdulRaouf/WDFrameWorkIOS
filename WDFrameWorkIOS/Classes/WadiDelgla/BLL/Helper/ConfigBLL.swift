//
//  Config.swift
//  BLL
//
//  Created by SimpleTouch on 12/30/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Alamofire

public protocol BLLConfigBLL {
    static var language: String { get }
    static var customerSourceId: Int { get }
    static var fcmToken : String { get }
 }

final class ConfigTypeBLL {
    static fileprivate var shared: ConfigTypeBLL?
    
    var language: String
    var customerSourceId: Int
    var fcmToken: String
    fileprivate init(_ config: BLLConfigBLL.Type) {
        self.language = config.language
        self.customerSourceId = config.customerSourceId
        self.fcmToken = config.fcmToken
     }
}

var APIErrorsBLL: [CustomErrorDTODAL] = []
var ConfigBLL: ConfigTypeBLL { // swiftlint:disable:this variable_name
    if let config = ConfigTypeBLL.shared {
        return config
    } else {
        fatalError("Please set the Config for \(Bundle(for: ConfigTypeBLL.self))")
    }
}

/// Use this method to inject the configuration for this framework.
public func setup(with config: BLLConfigBLL.Type,completion: @escaping () -> ()) {
    ConfigTypeBLL.shared = ConfigTypeBLL(config)
    completion()
}
public func getErrorMessages(completion: @escaping () -> ()){
        ErrorMessageUseCaseBLL(network: NetworkBLL()).getErrorMessages { (response) in
            guard let data = response?.data else {
                completion()
                return
            }
            if let errorMessagesDTO = data as? [CustomErrorDTODAL] {
                APIErrorsBLL = errorMessagesDTO
                UserDefaults.apiErrors = APIErrorsBLL
            }else{
                if let errors = UserDefaults.apiErrors {
                     APIErrorsBLL = errors
                }
            }
            completion()
    }
}
