//
//  IMap.swift
//  STDobites
//
//  Created by Nermeen Mohamed on 10/30/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
protocol IMap {
    associatedtype K
    func removeAllPins()
    func dropPins(_ locations: [K])
    func zoomtoLocation()
    func checkLocationAuthorizationStatus()
}
