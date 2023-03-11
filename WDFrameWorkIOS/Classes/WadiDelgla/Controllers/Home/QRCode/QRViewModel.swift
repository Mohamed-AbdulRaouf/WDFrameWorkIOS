//
//  QRViewModel.swift
//  STDobites
//
//  Created by Nermeen Mohamed on 10/29/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
import ReactiveKit
//import DAL
//import BLL
import SVProgressHUD
public protocol IQRViewModel: IBaseViewModel {
    
    var onSuccessReadQRCode: (() -> Void)? { get set }
    var onError: ((String) -> Void)? { get set }
    func saveAddressInfo(_ cipherCode: String)
}
class QRViewModel: IQRViewModel{
    
     var onError: ((String) -> Void)?
     var onSuccessReadQRCode: (() -> Void)?

    
    public  init (){}
    
    func saveAddressInfo(_ cipherCode: String) {
        doOnMain {
            self.showHud()
          
            let fullAddressArr = cipherCode.components(separatedBy: ",")
            if fullAddressArr.count > 0 {
                let areaId  = fullAddressArr[2]
                let cityId = fullAddressArr[1]
                let streetName = fullAddressArr[0]
#warning("check from code")
//                UserDefaults.currentArea = SearchItemDTODAL(id:areaId,name:areaId)
//                UserDefaults.currentCity = SearchItemDTOModelDAL(id:cityId,name:cityId)
                UserDefaults.streetName = streetName
                
            }
           
            self.hideHUD()
            self.onSuccessReadQRCode!()
        }
    }
}
