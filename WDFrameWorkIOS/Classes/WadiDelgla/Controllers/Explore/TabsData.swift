//
//  TabsData.swift
//  STDobites
//
//  Created by SimpleTouch on 11/7/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
class TabsData {
    static let sharedInstance = TabsData()
    private init() {}
    
    var searchTerm : String?
    var isLoyality : Bool?
}

