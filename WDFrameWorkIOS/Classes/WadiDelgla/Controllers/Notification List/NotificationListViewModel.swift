//
//  NotificationListViewModel.swift
//  STDobites
//
//  Created by Nermeen Mohamed on 11/2/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
import ReactiveKit
//import DAL
//import BLL
import SVProgressHUD
protocol INotificationListViewModel: IBaseViewModel {
    
    var apiClient: BrandServiceBLL? { get set }
    var notifications :[INotificationDTODAL]? {get set}
    func getBrandsNotifications()
    func getBrandNotifications()
    var requestDTO: IRequestDTODAL? {get set}
    var delegate: INotificationListViewController? {get set}
    func viewDidLoad()
     func readNotification(_ notificationId: String,completion: @escaping ((Bool) -> Void))
    func removeNotification(_ notificationId: String)
}
class NotificationListViewModel: INotificationListViewModel{
    weak var delegate: INotificationListViewController?

    var apiClient: BrandServiceBLL?
    
    var notifications: [INotificationDTODAL]?
    
    var requestDTO: IRequestDTODAL?
    
    public  init (requestDTO:IRequestDTODAL,apiClient: BrandServiceBLL){
        self.apiClient = apiClient
        self.requestDTO = requestDTO
    }
    func viewDidLoad(){
        self.requestDTO?.pageNumber.value = 0
        self.requestDTO?.pageSize.value = 100
        self.notifications?.removeAll()
        if requestDTO?.brandId.value == nil {
            self.requestDTO?.brandId.value = 0
        }
         self.getBrandNotifications()
    }
  
    func getBrandsNotifications() {
        self.showHud()
        self.requestDTO?.pageNumber.value = (self.requestDTO?.pageNumber.value)! + 1
        doInBackground {
            self.apiClient?.getBrandsNotifications (self.requestDTO!,completion: { (response) in
                doOnMain {
                    self.hideHUD()
                    guard let data = response?.data else {
                        self.requestDTO?.pageNumber.value = (self.requestDTO?.pageNumber.value)! - 1
                        if response?.error?.APIError != nil {
                            self.delegate?.onError(response?.error?.APIError?.description ?? "")
                        }
                        if response?.error?.networkError != nil {
                            self.delegate?.onError(response?.error?.networkError?.description ?? "")
                        }
                        return
                    }
                    if let notificationsDTO = data as? [INotificationDTODAL] {
                        if let _ = self.notifications {
                            self.notifications?.append(contentsOf: notificationsDTO)
                        }else{
                            self.notifications = notificationsDTO
                        }
                        self.delegate?.onReloadTableView()
                    }
                }
            })
        }
    }
    
    func getBrandNotifications() {
        self.showHud()
        self.requestDTO?.pageNumber.value = (self.requestDTO?.pageNumber.value)! + 1
        doInBackground {
            self.apiClient?.getBrandNotifications (self.requestDTO!,completion: { (response) in
                doOnMain {
                    self.hideHUD()
                    guard let data = response?.data else {
                        self.requestDTO?.pageNumber.value = (self.requestDTO?.pageNumber.value)! - 1
                        if response?.error?.APIError != nil {
                            self.delegate?.onError(response?.error?.APIError?.description ?? "")
                        }
                        if response?.error?.networkError != nil {
                            self.delegate?.onError(response?.error?.networkError?.description ?? "")
                        }
                        return
                    }
                    if let notificationsDTO = data as? [INotificationDTODAL] {
                        if let _ = self.notifications {
                            self.notifications?.append(contentsOf: notificationsDTO)
                        }else{
                            self.notifications = notificationsDTO
                        }
                        self.delegate?.onReloadTableView()
                    }
                }
            })
        }
    }
    func removeNotification(_ notificationId: String) {
        self.showHud()
        doInBackground {
            self.apiClient?.removeNotification (notificationId,completion: { (response) in
                doOnMain {
                    self.hideHUD()
                    guard let _ = response?.data else {
                        if response?.error?.APIError != nil {
                            self.delegate?.onError(response?.error?.APIError?.description ?? "")
                        }
                        if response?.error?.networkError != nil {
                            self.delegate?.onError(response?.error?.networkError?.description ?? "")
                        }
                        return
                    }
                    self.notifications?.removeAll(where: { (notification) -> Bool in
                        return notification.id.value == notificationId
                    })
                     self.delegate?.onReloadTableView()
                }
            })
        }
    }
    func readNotification(_ notificationId: String,completion: @escaping ((Bool) -> Void)) {
        self.showHud()
        doInBackground {
            self.apiClient?.readNotification (notificationId,completion: { (response) in
                doOnMain {
                    self.hideHUD()
                    guard let _ = response?.data else {
                        if response?.error?.APIError != nil {
                            self.delegate?.onError(response?.error?.APIError?.description ?? "")
                        }
                        if response?.error?.networkError != nil {
                            self.delegate?.onError(response?.error?.networkError?.description ?? "")
                        }
                        return
                    }
                    
                    self.notifications?.removeAll(where: { (notification) -> Bool in
                        return notification.id.value == notificationId
                    })
                    self.delegate?.onReloadTableView()
                    if let brandId = self.requestDTO?.brandId.value,brandId == 0{
                        completion(true)
                    }
                }
            })
        }
    }
}
