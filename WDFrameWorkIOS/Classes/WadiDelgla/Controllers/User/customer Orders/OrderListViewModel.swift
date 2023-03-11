//
//  OrderListViewModel.swift
//  STDobites
//
//  Created by Nermeen Mohamed on 10/31/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
import ReactiveKit
//import DAL
//import BLL
import SVProgressHUD
protocol IOrderListViewModel: IBaseViewModel {
    
    var apiClient: UserServiceBLL? { get set }
    var order :IOrderListDTODAL? {get set}
    func getOrders()
    var requestOrderDTO: IRequestDTODAL? {get set}
    var delegate: IOrderListViewController? {get set}
    func viewDidLoad()
}
class OrderListViewModel: IOrderListViewModel{
    
    weak var delegate: IOrderListViewController?
    var requestOrderDTO: IRequestDTODAL?
    
    var apiClient: UserServiceBLL?
    
    var order: IOrderListDTODAL?
    
    public  init (requestOrderDTO:IRequestDTODAL,apiClient: UserServiceBLL){
        self.apiClient = apiClient
        self.requestOrderDTO = requestOrderDTO
        
    }
    /// This Functin to set initial values for some variables
    func viewDidLoad(){
        self.requestOrderDTO?.pageNumber.value = 0
        self.requestOrderDTO?.pageSize.value = 10
         self.requestOrderDTO?.brandId.value = 0
        self.order?.items.value?.removeAll()
        self.getOrders()
    }
    /// This Function to get customer previous orders
    func getOrders() {
        self.showHud()
        self.requestOrderDTO?.pageNumber.value = (self.requestOrderDTO?.pageNumber.value)! + 1
        doInBackground {
            self.apiClient?.getCustomerPreviousOrders (self.requestOrderDTO!,completion: { (response) in
                doOnMain {
                    self.hideHUD()
                    guard let data = response?.data else {
                         self.requestOrderDTO?.pageNumber.value = (self.requestOrderDTO?.pageNumber.value)! - 1
                        if response?.error?.APIError != nil {
                            self.delegate?.onError(response?.error?.APIError?.description ?? "")
                        }
                        if response?.error?.networkError != nil {
                            self.delegate?.onError(response?.error?.networkError?.description ?? "")
                        }
                        return
                    }
                    if let orderDTO = data as? IOrderListDTODAL {
                        if self.order == nil {
                            self.order = orderDTO
                        }else{
                            self.order?.items.value?.append(contentsOf: orderDTO.items.value!)
                        }
                        self.delegate?.onReloadTableView()
                    }
                }
            })
            
        }
    }
   
    
}
