//
//  ITopRatedReferralsDTO.swift
//  DAL
//
//  Created by Nermeen Mohamed on 10/29/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
public protocol  ITopRatedReferralsDTODAL :AnyObject {
    var customerId: Observable<Int?> { get set }
    var customerName: Observable<String?> { get set }
    var referralsCount: Observable<Int?> { get set }
    var index: Observable<Int?> { get set }
 
}
