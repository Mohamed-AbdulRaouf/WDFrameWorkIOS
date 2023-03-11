//
//  Customer+Configurations.swift
//  BLL
//
//  Created by SimpleTouch on 12/22/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
class CustomerConfigurationsBLL {
    
    var url: String!
    
    init(configurationName:ConfigurationsNamesBLL, urlKey : String) {
       
            if let patht = Bundle(for: type(of: self)).path(forResource: configurationName.rawValue, ofType: "plist"){
                let config = NSDictionary(contentsOfFile: patht)
                for (key, value) in config! {
                    if let key = key as? String, let value = value as? String {
                        if key == urlKey {
                            url = value
                        }
                    }
                }
            }
    }
}
enum ConfigurationsNamesBLL : String{
    case Customer = "Customer"
}
