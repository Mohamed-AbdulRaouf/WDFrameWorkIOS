//
//  IArtWork.swift
//  DAL
//
//  Created by Nermeen Mohamed on 10/30/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
import CoreLocation
public protocol  IArtWorkDAL:AnyObject  {
    
    var locationName: Observable<String?> { get set }
    var discipline: Observable<String?> { get set }
}
