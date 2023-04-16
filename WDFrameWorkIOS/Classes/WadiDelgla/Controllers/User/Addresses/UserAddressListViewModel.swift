//
//  UserAddressListViewModel.swift
//  STDobites
//
//  Created by Nermeen Mohamed on 11/3/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import ReactiveKit

import SVProgressHUD
protocol IUserAddressProtocol:class {
    func didSelectAddress(_ address: IUserAddressDTODAL)
}
protocol IUserAddressListViewModel: IBaseViewModel {
    
    var apiClient: UserServiceBLL? { get set }
    var addresses :[IUserAddressDTODAL]? {get set}
    func getCustomerAddresses()
    func getCustomerAddressesByAreaId(_ areaId: String)
    var delegate: IUserAddressListViewController? {get set}
    var sourceDelegate: IUserAddressProtocol? {get set}
    func viewDidLoad()
}
class UserAddressListViewModel: IUserAddressListViewModel{
    
    weak var delegate: IUserAddressListViewController?
    
    weak var sourceDelegate: IUserAddressProtocol?
    
    var apiClient: UserServiceBLL?
    
    var addresses: [IUserAddressDTODAL]?
    
    public  init (apiClient: UserServiceBLL){
        self.apiClient = apiClient
        
    }
    /*
      This Function to refresh address list
      First remove address array then call get user  address list
      if source delegate not nil that means it comes from cart to select address in specific area
      if source delegate = nil this means it comes from profile so get all user address list
    */
    func viewDidLoad(){
        self.addresses?.removeAll()
        if let _ = self.sourceDelegate {
            self.getCustomerAddressesByAreaId(UserDefaults.currentArea?.id.value?.description ?? "0")
            return
        }
        self.getCustomerAddresses()
    }
    /// This Function to get user address list
    func getCustomerAddresses() {
        self.showHud()
        doInBackground {
            self.apiClient?.getCustomerAddresses (0,completion: { (response) in
                doOnMain {
                    self.hideHUD()
                    guard let data = response?.data else {
                        if response?.error?.ErrorCode == ErrorsCodeBLL.noDataFound.rawValue{
                            self.delegate?.addNewAddress()
                           return
                        }else if response?.error?.APIError != nil {
                            self.delegate?.onError(response?.error?.APIError?.description ?? "")
                        }
                        if response?.error?.networkError != nil {
                            self.delegate?.onError(response?.error?.networkError?.description ?? "")
                        }
                        return
                    }
                   
                    if let addresses = data as? [IUserAddressDTODAL] {
                        self.addresses = addresses
                        self.delegate?.onReloadTableView()
                    }
                }
            })
            
        }
    }
    /// This Function to get user address list in specific area
    ///
    /// - Parameter areaId: area Id
    func getCustomerAddressesByAreaId(_ areaId: String){
        self.showHud()
        doInBackground {
            self.apiClient?.getCustomerAddressesByAreaId (areaId,0,completion: { (response) in
                doOnMain {
                    self.hideHUD()
                    guard let data = response?.data else {
                        if response?.error?.ErrorCode == ErrorsCodeBLL.noDataFound.rawValue{
                            self.delegate?.addNewAddress()
                            return
                        }else if response?.error?.APIError != nil {
                            self.delegate?.onError(response?.error?.APIError?.description ?? "")
                        }
                        if response?.error?.networkError != nil {
                            self.delegate?.onError(response?.error?.networkError?.description ?? "")
                        }
                        return
                    }
                    
                    if let addresses = data as? [IUserAddressDTODAL] {
                        self.addresses = addresses
                        self.delegate?.onReloadTableView()
                    }
                }
            })
            
        }
    }

}

