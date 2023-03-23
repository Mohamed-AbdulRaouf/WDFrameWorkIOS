//
//  ICommonFunc.swift
//  STDobites
//
//  Created by SimpleTouch on 12/31/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
protocol ICommonFunc:class {
    func onError(_ error: String)
    func onShowToast(_ message: String)
}
extension ICommonFunc  where Self: STUIViewController{
    func onError(_ error: String){
        self.showMessage(andMessage: error)
    }
    func onShowToast(_ message: String){
        self.view.makeToast(message, duration: 2.0)
    }
}
