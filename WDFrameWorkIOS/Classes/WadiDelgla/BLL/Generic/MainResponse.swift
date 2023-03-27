//
//  MainResponse.swift
//  Netwroking
//
//  Created by SimpleTouch on 9/22/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
//import SwiftyJSON
public typealias onResponse = ((MainResponseBLL?,NetworkErrorBLL?) -> ())
public class MainResponseBLL {
    var statusCode: Int?
    var messageCode: Int?
    var message: String?
    var data: JSON?
    
    
    init(statusCode: Int?,json: JSON){
        self.statusCode = statusCode
        self.messageCode = json["MessageCode"].intValue
        self.message = json["Message"].stringValue
        self.data = json["Data"].self
        
     }
    init(statusCode: Int?,messageCode : Int?,message: String?,data: JSON?) {
        self.statusCode = statusCode
        self.messageCode = messageCode
        self.message = message
        self.data = data
    }
    init(statusCode: Int?,messageCode : Int?,message: String?){
        self.statusCode = statusCode
        self.messageCode = messageCode
        self.message = message
    }
}
