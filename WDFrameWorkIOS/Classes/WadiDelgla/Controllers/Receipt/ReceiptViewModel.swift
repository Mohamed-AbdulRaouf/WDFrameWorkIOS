//
//  ReceiptViewModel.swift
//  STDobites
//
//  Created by SimpleTouch on 11/14/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
import ReactiveKit
import SVProgressHUD
import Kingfisher
import UIKit
protocol IReceiptViewModel: IBaseViewModel {
    
    var apiClient: UserServiceBLL? { get set }
    var order :IReceiptDTODAL? {get set}
    var customerHistoryId :Int? {get set}
    var isFromCart: Bool? {get set}
    func getOrderDetails()
    var delegate: IReceiptViewController? {get set}
 
 }
class ReceiptViewModel: IReceiptViewModel{
    var isFromCart: Bool?
 
    weak var delegate: IReceiptViewController?
 
    var apiClient: UserServiceBLL?
    
    var order: IReceiptDTODAL?
    
    var customerHistoryId: Int?
    public  init (apiClient: UserServiceBLL){
        self.apiClient = apiClient
     }
    func getOrderDetails() {
        self.showHud()
         doInBackground {
            self.apiClient?.getCustomerOrderDetails (self.customerHistoryId!,completion: { (response) in
                doOnMain {
                    self.hideHUD()
                    guard let data = response?.data else {
                        if response?.error?.APIError != nil {
                            self.delegate?.onError(response?.error?.APIError?.description ?? "")
                        }
                        if response?.error?.networkError != nil {
                            self.delegate?.onError(response?.error?.networkError?.description ?? "")
                        }
                        return
                    }
                    self.order = data as? IReceiptDTODAL
                    self.delegate?.onReloadView()
                }
            })
            
        }
    }
}
