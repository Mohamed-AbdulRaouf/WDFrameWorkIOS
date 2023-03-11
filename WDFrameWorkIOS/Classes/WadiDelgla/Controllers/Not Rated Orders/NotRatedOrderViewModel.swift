//
//  NotRatedOrderViewModel.swift
//  STDobites
//
//  Created by SimpleTouch on 11/27/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
import ReactiveKit
//import DAL
//import BLL
import SVProgressHUD
import Kingfisher
import UIKit
protocol INotRatedOrderViewModel: IBaseViewModel {
    var orderService: OrderServiceBLL? { get set }
    var orderList :IOrderListDTODAL? {get set}
}
class NotRatedOrderViewModel: INotRatedOrderViewModel{
    
     var orderList :IOrderListDTODAL?
    var orderService: OrderServiceBLL?
 
    public  init (orderService: OrderServiceBLL){
        self.orderService = orderService
    }
  
    
}
