//
//  OrderByFrontRefernceDTO.swift
//  DAL
//
//  Created by SimpleTouch on 12/7/20.
//  Copyright © 2020 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
import SwiftyJSON
public class OrderByFrontRefernceDTODAL : IOrderByFrontRefernceDTODAL{
    
    public var status: Observable<Bool?> = Observable<Bool?>(nil)
    
    public var orderHeaderId: Observable<Int?> = Observable<Int?>(nil)
    
    public var customerHistoryId: Observable<Int?> = Observable<Int?>(nil)
    
    public init(){}
    
    enum CodingKeys: String, CodingKey {
        case Status = "Status"
        case OrderHeaderId = "OrderHeaderId"
        case CustomerHistoryId = "CustomerHistoryId"
    }
  
    public init(json:JSON)   {
        self.status.value = json[CodingKeys.Status.rawValue].boolValue
        self.orderHeaderId.value = json[CodingKeys.OrderHeaderId.rawValue].intValue
        self.customerHistoryId.value = json[CodingKeys.CustomerHistoryId.rawValue].intValue
    }
}
