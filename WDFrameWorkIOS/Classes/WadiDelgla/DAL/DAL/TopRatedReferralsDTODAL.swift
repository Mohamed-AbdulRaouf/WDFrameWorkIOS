//
//  TopRatedReferrals.swift
//  DAL
//
//  Created by Nermeen Mohamed on 10/29/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
//import SwiftyJSON
public  class TopRatedReferralsDTODAL : ITopRatedReferralsDTODAL{
    public var customerId: Observable<Int?> = Observable<Int?>(nil)
    
    public var customerName: Observable<String?> = Observable<String?>(nil)
    
    public var referralsCount: Observable<Int?> = Observable<Int?>(nil)
    
    public var index: Observable<Int?> = Observable<Int?>(nil)
    
 
    
    public init(){}
    enum CodingKeys: String, CodingKey {
        case customerId = "CustomerID"
        case customerName = "CustomerName"
        case referralsCount = "ReferralsCount"
    }
    public init(json: JSON)  {
        self.customerId.value = json[CodingKeys.customerId.rawValue].intValue
        self.customerName.value =  json[CodingKeys.customerName.rawValue].stringValue
        self.referralsCount.value = json[CodingKeys.referralsCount.rawValue].intValue
        self.index.value = 0
     }
}
