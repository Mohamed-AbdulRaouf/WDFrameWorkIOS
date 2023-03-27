//
//  ConfirmMyFatoorahPaymentDTO.swift
//  DAL
//
//  Created by Nermeen Mohamed on 28/06/2021.
//  Copyright © 2021 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
//import SwiftyJSON
public  class ConfirmMyFatoorahPaymentDTODAL : IConfirmMyFatoorahPaymentDTODAL,Codable{
    
    public var referencePaymentId: Observable<String?> = Observable<String?>(nil)
    
    public var referenceTransactionId: Observable<String?> = Observable<String?>(nil)

    public var referenceInvoiceId: Observable<String?> = Observable<String?>(nil)
    
    public var frontOrderReferenceId: Observable<String?> = Observable<String?>(nil)
    
    public var customerHistoryId: Observable<Int?> = Observable<Int?>(nil)
    
    public var orderId: Observable<String?> = Observable<String?>(nil)
    
    public var status: Observable<Bool?> = Observable<Bool?>(nil)
     
    
    public init(){}
    public init(referencePaymentId: String,referenceTransactionId: String,referenceInvoiceId:String,frontOrderReferenceId:String,customerHistoryId:Int,orderId:String,status:Bool){
        self.referencePaymentId.value = referencePaymentId
        self.referenceTransactionId.value = referenceTransactionId
        self.referenceInvoiceId.value = referenceInvoiceId
        self.frontOrderReferenceId.value = frontOrderReferenceId
        self.customerHistoryId.value = customerHistoryId
        self.orderId.value = orderId
        self.status.value = status
        
    }
    
    enum CodingKeys: String, CodingKey {
       
        case ReferencePaymentId = "ReferencePaymentId"
        case ReferenceTransactionId = "ReferenceTransactionId"
        case ReferenceInvoiceId = "ReferenceInvoiceId"
        case FrontOrderReferenceId = "FrontOrderReferenceId"
        case CustomerHistoryId = "CustomerHistoryId"
        case OrderId = "OrderId"
        case Status = "Status"
     }
     public init(json: JSON)  {
        self.referencePaymentId.value = json[CodingKeys.ReferencePaymentId.rawValue].stringValue
        self.referenceTransactionId.value = json[CodingKeys.ReferenceTransactionId.rawValue].stringValue
        self.referenceInvoiceId.value = json[CodingKeys.ReferenceInvoiceId.rawValue].stringValue
        self.frontOrderReferenceId.value = json[CodingKeys.FrontOrderReferenceId.rawValue].stringValue
        self.customerHistoryId.value = json[CodingKeys.CustomerHistoryId.rawValue].intValue
        self.orderId.value = json[CodingKeys.OrderId.rawValue].stringValue
        self.status.value = json[CodingKeys.Status.rawValue].boolValue
       
    }
     public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(referencePaymentId.value, forKey: .ReferencePaymentId)
            try container.encode(referenceTransactionId.value, forKey: .ReferenceTransactionId)
        try container.encode(referenceInvoiceId.value, forKey: .ReferenceInvoiceId)
        try container.encode(frontOrderReferenceId.value, forKey: .FrontOrderReferenceId)
        try container.encode(customerHistoryId.value, forKey: .CustomerHistoryId)
            try container.encode(orderId.value, forKey: .OrderId)
            try container.encode(status.value, forKey: .Status)
        
       

        }
        required public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)

            self.referencePaymentId.value =  try container.decodeIfPresent(String.self, forKey: .ReferencePaymentId)
            self.referenceTransactionId.value = try container.decodeIfPresent(String.self,forKey: .ReferenceTransactionId)
            self.referenceInvoiceId.value = try container.decodeIfPresent(String.self,forKey: .ReferenceInvoiceId)
            self.frontOrderReferenceId.value = try container.decodeIfPresent(String.self,forKey: .FrontOrderReferenceId)
            self.customerHistoryId.value = try container.decodeIfPresent(Int.self,forKey: .CustomerHistoryId)
            self.orderId.value = try container.decodeIfPresent(String.self,forKey: .OrderId)
            self.status.value = try container.decodeIfPresent(Bool.self,forKey: .Status)
        }
}
