//
//  CreditCard+ICreditCardDelegate.swift
//  STDobites
//
//  Created by SimpleTouch on 9/15/20.
//  Copyright © 2020 SimpleTouch. All rights reserved.
//

import Foundation
import Foundation
extension CreditCardViewController: ICreditCardViewController{
    func onError(_ error: String) {
        self.showMessage(andMessage: error)
        self.bindingData()
    }
    func onUpdateLayout() {
        self.bindingData()
    }
    func onSuccessSaveShopperCard(){
        self.bindingData()
        self.showToast(R.string.localizable.success_add_card())
               doOnMain(deadline: 2.0, {
                   self.navigationController?.popViewController()
               })
    }
    
}

