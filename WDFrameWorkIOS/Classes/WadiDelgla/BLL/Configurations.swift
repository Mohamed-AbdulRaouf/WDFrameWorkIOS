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
    }
}
