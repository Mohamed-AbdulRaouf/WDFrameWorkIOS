//
//  ConfirmPaymentDTO.swift
//  DAL
//
//  Created by SimpleTouch on 8/11/20.
//  Copyright © 2020 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
//import SwiftyJSON
public  class ConfirmPaymentDTODAL : IConfirmPaymentDTODAL,Codable{
    public var transactionId: Observable<String?> = Observable<String?>(nil)
    
    public var merchanOrderId: Observable<String?> = Observable<String?>(nil)

    public var orderId: Observable<String?> = Observable<String?>(nil)
    
    public var status: Observable<Bool?> = Observable<Bool?>(nil)
     
    public var customerID: Observable<Int?> = Observable<Int?>(nil)
    
    public init(){}
    public init(transactionId: String,merchanOrderId: String,orderId:String,status:Bool){
        self.transactionId.value = transactionId
        self.merchanOrderId.value = merchanOrderId
        self.orderId.value = orderId
        self.status.value = status
        
    }
    
    enum CodingKeys: String, CodingKey {
        case TransactionId = "TransactionId"
        case MerchanOrderId = "MerchanOrderId"
        case OrderId = "OrderId"
        case Status = "Status"
        case CustomerID = "CustomerID"
     }
     public init(json: JSON)  {
        self.transactionId.value = json[CodingKeys.TransactionId.rawValue].stringValue
        self.merchanOrderId.value = json[CodingKeys.MerchanOrderId.rawValue].stringValue
        self.orderId.value = json[CodingKeys.OrderId.rawValue].stringValue
        self.status.value = json[CodingKeys.Status.rawValue].boolValue
        self.customerID.value = json[CodingKeys.CustomerID.rawValue].intValue

    }
     public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(transactionId.value, forKey: .TransactionId)
            try container.encode(merchanOrderId.value, forKey: .MerchanOrderId)
            try container.encode(orderId.value, forKey: .OrderId)
            try container.encode(status.value, forKey: .Status)
          try container.encode(customerID.value, forKey: .CustomerID)

        }
        required public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)

            self.transactionId.value =  try container.decodeIfPresent(String.self, forKey: .TransactionId)
            self.merchanOrderId.value = try container.decodeIfPresent(String.self,forKey: .MerchanOrderId)
            self.orderId.value = try container.decodeIfPresent(String.self,forKey: .OrderId)
            self.status.value = try container.decodeIfPresent(Bool.self,forKey: .Status)
            self.customerID.value = try container.decodeIfPresent(Int.self,forKey: .CustomerID)
        }
}
