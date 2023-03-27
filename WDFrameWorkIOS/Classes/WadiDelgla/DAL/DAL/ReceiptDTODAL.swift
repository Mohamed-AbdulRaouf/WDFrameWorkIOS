//
//  ReceiptDTO.swift
//  DAL
//
//  Created by SimpleTouch on 11/14/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
//import SwiftyJSON
public class ReceiptDTODAL :IReceiptDTODAL{
    public var orderDetails: Observable<IOrderDetailsDTODAL?> = Observable<IOrderDetailsDTODAL?>(nil)

    public var orderItems: Observable<[IOrderItemDTODAL]?> = Observable<[IOrderItemDTODAL]?>(nil)
    
    public init(){}
    
    enum CodingKeys: String, CodingKey {
        case PreviousOrderDetailsApp = "PreviousOrderDetailsApp"
         case OrderItems = "OrderItems"
    }
    public init(json:JSON)   {
        self.orderDetails.value = OrderDetailsDTODAL.init(json: json[CodingKeys.PreviousOrderDetailsApp.rawValue])
        self.orderItems.value = json[CodingKeys.OrderItems.rawValue].arrayValue.map({try! OrderItemDTODAL.init(json: $0)})
    }
    
    
    
}
