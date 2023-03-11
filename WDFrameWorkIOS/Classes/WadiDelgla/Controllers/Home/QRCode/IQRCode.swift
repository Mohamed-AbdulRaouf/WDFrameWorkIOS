//
//  IQRCode.swift
//  STDobites
//
//  Created by Nermeen Mohamed on 10/29/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
public protocol IQRCode {
    func presentCamera()
    func requestCameraPermission()
    func alertCameraAccessNeeded()
}
