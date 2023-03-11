//
//  HomeViewModel.swift
//  STDobites
//
//  Created by Nermeen Mohamed on 10/28/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Bond
import ReactiveKit
//import DAL
//import BLL
import SVProgressHUD
import RxSwift
//import RxCocoa
//import KashierPaymentSDK
protocol IHomeViewModel: IBaseViewModel {
    
    var apiClient: BrandServiceBLL? { get set }
    var userService: UserServiceBLL? { get set }
    var pagingDTO: IPagingDTODAL? {get set}
    func getAds()
    var adsList :[IAdsDTODAL]? {get set}
    func getNumberOfRows()  -> Int
    func getRowHeight(_ row:Int) -> CGFloat
    
    func onRankingTapped()
    func onQRTapped()
    func onNearResturantsTapped()
    func onFavoriteResturantsTapped()
    func getCustomerNotRatedOrders()
    func onNotificationsTapped()
    func onExploreTapped()
    var orderList: IOrderListDTODAL? {get set}
    var delegate: IHomeViewController? {get set}
    var isFirstOpen: Bool? {get set}
    var requestOrderDTO: IRequestDTODAL? {get set}
    func viewDidLoad()
    func getBrandsNotificatiosCount()
    var notificationsCount: Int? {get set}

}

class HomeViewModel: IHomeViewModel{
    var orderList: IOrderListDTODAL?
    
    var requestOrderDTO: IRequestDTODAL?
    
    weak  var delegate: IHomeViewController?    
    
    var apiClient: BrandServiceBLL?
    var userService: UserServiceBLL?
    var pagingDTO: IPagingDTODAL?
    var onReloadTable: (() -> Void)?
    var onError: ((String) -> Void)?
    var adsList: [IAdsDTODAL]?
    var isFirstOpen: Bool? = true
    var openLogin: (() -> Void)?
    var openRanking: (() -> Void)?
    var openQR: (() -> Void)?
    var openBranchLocations: (() -> Void)?
    var openExplore: (() -> Void)?
    var notificationsCount: Int?
    public  init (pagingDTO:IPagingDTODAL,apiClient: BrandServiceBLL,userService: UserServiceBLL,requestOrderDTO: IRequestDTODAL){
        self.apiClient = apiClient
        self.userService = userService
        self.pagingDTO = pagingDTO
        self.requestOrderDTO = requestOrderDTO
    }
    func viewDidLoad(){
        TabsData.sharedInstance.searchTerm = ""
        TabsData.sharedInstance.isLoyality = false

        self.requestOrderDTO?.pageNumber.value = 1
        self.requestOrderDTO?.pageSize.value = 50
        self.requestOrderDTO?.brandId.value = 0
        self.orderList?.items.value?.removeAll()
        
        
        self.pagingDTO?.pageNumber.value = 1
        self.pagingDTO?.pageSize.value = 100
        self.getAds()
        
        if UserDefaults.user != nil {
            doInBackground {
                self.getBrandsNotificatiosCount()
            }

            if isFirstOpen!{
                doInBackground {
                     self.getCustomerNotRatedOrders()
                }
            }
            
        }else{
            //            self.notificationCountBtn.isHidden = true
        }
        

    }
    func getBrandsNotificatiosCount() {
        self.showHud()
        doInBackground {
            self.apiClient?.getBrandsNotificationsCount(0, completion: { (response) in
                doOnMain {
                    self.hideHUD()
                    guard let data = response?.data else {
                        self.delegate?.updateNotificationCount(0)
                        return
                    }
                    self.delegate?.updateNotificationCount((data as? Int) ?? 0)
                }
            })
        }
    }
   func getAds() {
        self.showHud()
        doInBackground {
            self.apiClient?.getAdsList(pagingDTO: self.pagingDTO!) { (response) in
                doOnMain {
                    self.hideHUD()
                    guard let data = response?.data else {
                        return
                    }
                    self.adsList = data as? [IAdsDTODAL]
                    self.delegate?.onReloadTable()
                }
            }
        }
    }
    func getNumberOfRows()->Int{
        guard let ads = adsList ,ads.count > 0 else{
            return 2
        }
        if ads.count > 2 {
            return 4
        }else{
            return ads.count + 1
        }
    }
    func getRowHeight(_ row:Int) -> CGFloat{
        switch row {
        case 1:
            return 200 //UITableView.automaticDimension
        case 2:
            return 200
        default:
             return 200
        }
    }
    func onRankingTapped() {
        if let token =  UserDefaults.user?.token.value ,token != "" {
            self.delegate?.openRanking()
        }else{
            self.delegate?.openLogin()
        }
    }
    func onQRTapped() {
        if let token =  UserDefaults.user?.token.value ,token != "" {
            self.delegate?.openQR()
        }else{
            self.delegate?.openLogin()
        }
    }
    func onNotificationsTapped() {
        if let token =  UserDefaults.user?.token.value ,token != "" {
            self.delegate?.openNotificationList()
        }else{
            self.delegate?.openLogin()
        }
    }
    func onNearResturantsTapped(){
        LocationManager.sharedInstance.runLocationBlock {
            doOnMain {
                 self.delegate?.openBranchLocations()
            }
        }
    }
    func onFavoriteResturantsTapped() {
        if let token =  UserDefaults.user?.token.value ,token != "" {
            TabsData.sharedInstance.searchTerm = ""
            TabsData.sharedInstance.isLoyality = true
            self.delegate?.openExplore()
        }else{
            self.delegate?.openLogin()
        }
    }
    func onExploreTapped() {
        TabsData.sharedInstance.searchTerm = ""
        TabsData.sharedInstance.isLoyality = false
        self.delegate?.openExplore()
    }
    func getCustomerNotRatedOrders() {
        self.showHud()
        doInBackground {
            self.userService?.getCustomerNotRatedOrders(self.requestOrderDTO!, completion: { (response) in
                doOnMain {
                    self.hideHUD()
                    guard let data = response?.data else {
                        return
                    }
                    self.orderList = data as? IOrderListDTODAL
                    if (self.orderList?.totalCount.value ?? 0) > 0 {
                        self.isFirstOpen = false
                        guard let items = self.orderList?.items.value,items.count >= 1 else {return}
                        if items.count > 1 {
                            self.delegate?.showNotRatedOrdersList(orderList: self.orderList!)
                        }else if items.count == 1 {
                            self.delegate?.showRateVC(order: (self.orderList?.items.value![0])!)
                        }
                    }
                }
            })
        }
    }
}
