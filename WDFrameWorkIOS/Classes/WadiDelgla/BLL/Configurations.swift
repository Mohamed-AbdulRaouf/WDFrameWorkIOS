//
//  Configurations.swift
//  BLL
//
//  Created by SimpleTouch on 12/22/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
class ConfigurationsBLL {
    var serverURL = ""
    static let shared = ConfigurationsBLL()
    private init() {
        serverURL =  Bundle.main.object(forInfoDictionaryKey: "ServerURL") as! String
        
//        if let dictionary = Bundle.main.infoDictionary, let configuration = dictionary["Configuration"] as? String {
//            let path = Bundle.main.path(forResource: "Configurations", ofType:"plist")
//            let config = NSDictionary(contentsOfFile: path!)
//            for (key, value) in config! {
//                if let key = key as? String, let value = value as? [String:String] {
//                    if key == configuration {
//                        serverURL = value["serverURL"] ?? ""
//                    }
//                }
//            }
//
//        }
        
    }
}
