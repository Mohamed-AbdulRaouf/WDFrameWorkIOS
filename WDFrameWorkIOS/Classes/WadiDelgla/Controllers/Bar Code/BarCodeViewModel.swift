//
//  BarCodeViewModel.swift
//  STDobites
//
//  Created by Nermeen Mohamed on 11/4/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//


import Foundation
//import DAL
import Bond
import UIKit
protocol IBarCodeViewModel:IBaseViewModel {    
    func viewDidload()
    var userInfo: Observable<String?> {get set}
    var userId: Observable<String?> {get set}
    var  barCodeImage : Observable<UIImage?>{get set}
}
class BarCodeViewModel: IBarCodeViewModel{
    
    var userInfo: Observable<String?> = Observable<String?>(nil)
    
    var userId: Observable<String?> = Observable<String?>(nil)

    var barCodeImage: Observable<UIImage?> = Observable<UIImage?>(nil)
    
     func viewDidload() {
        if let user = UserDefaults.user {
            self.userInfo.value =  "\(user.firstName.value ?? "") \(user.lastName.value ?? "")"
            self.userId.value = user.userId.value
            self.barCodeImage.value = UIImage(barcode: (userId.value ?? "").generateBarcodeNumber())
        }
    }
}


