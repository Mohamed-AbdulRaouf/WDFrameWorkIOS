//
//  OrderListDTO.swift
//  DAL
//
//  Created by Nermeen Mohamed on 10/31/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
//import SwiftyJSON
public class OrderListDTODAL :IOrderListDTODAL{
    public var totalCount: Observable<Int?> = Observable<Int?>(nil)
    
    public var items: Observable<[OrderDTODAL]?> = Observable<[OrderDTODAL]?>(nil)
    
    public init(){}
    enum CodingKeys: String, CodingKey {
        case items = "Items"
        case totalCount = "TotalCount"
     }
    public init(json:JSON)  {
        self.totalCount.value = json["TotalCount"].intValue
        self.items.value = json["Items"].arrayValue.map({try! OrderDTODAL.init(json: $0)})
    }
    
}
