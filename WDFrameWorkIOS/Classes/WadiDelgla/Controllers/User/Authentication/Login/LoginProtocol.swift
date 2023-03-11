//
//  LoginProtocol.swift
//  STDobites
//
//  Created by SimpleTouch on 10/21/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
protocol LoginProtocol: class {
    func onUserLogedIn()
    func onDismissLogin()
}
extension LoginProtocol {
    func onDismissLogin(){}
}
