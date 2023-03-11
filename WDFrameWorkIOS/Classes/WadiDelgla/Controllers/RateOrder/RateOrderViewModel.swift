//
//  RateOrderViewModel.swift
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
protocol IRateOrderViewModel: IBaseViewModel {
    var orderService: OrderServiceBLL? { get set }
    var order :IRateOrderDTODAL? {get set}
    var customerHistoryId :Int? {get set}
    func getRateOrder()
    var delegate: IRateOrderViewController? {get set}
    //table view
    var cellHeights: [IndexPath : CGFloat] {get set}
    func setCellHeight(atIndexPath indexPath:IndexPath,_ cellHeight:CGFloat)
    func getCellHeight(atIndexPath indexPath:IndexPath) -> CGFloat
    func getsectionCount() -> Int
    func getTitleForHeaderInSection(_ section: Int) -> String
    func getNumberOfRowsInSection(_ section: Int) -> Int
    func onChangeRateItem(atIndex indexPath : IndexPath,_ rating: Double)
    func onChangeComment(_ comment: String)
    func rateOrder()
}
class RateOrderViewModel: IRateOrderViewModel{
   
    
    var orderService: OrderServiceBLL?
    var order :IRateOrderDTODAL?
    var customerHistoryId :Int?
    weak var delegate: IRateOrderViewController?
    var cellHeights: [IndexPath : CGFloat] = [:]

    public  init (orderService: OrderServiceBLL){
        self.orderService = orderService
    }
    func getRateOrder(){
        self.showHud()
        doInBackground {
            self.orderService?.getRateOrder (self.customerHistoryId!,completion: { (response) in
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
                    self.order = data as? IRateOrderDTODAL
                    self.delegate?.onReloadTableView()
                }
            })
            
        }
    }
    func rateOrder() {
        guard let order = self.order else { return}
         self.showHud()
        doInBackground {
            self.orderService?.rateOrder (order,completion: { (response) in
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
                     self.delegate?.onDismissViewController()
                }
            })
            
        }
    }
   
}
extension RateOrderViewModel{
    func setCellHeight(atIndexPath indexPath:IndexPath,_ cellHeight:CGFloat){
        cellHeights[indexPath] = cellHeight < 60.0 ? 60.0 : cellHeight
    }
    func getCellHeight(atIndexPath indexPath:IndexPath) -> CGFloat {
        return cellHeights[indexPath] ?? 60.0
    }
    func getsectionCount() -> Int{
        guard let categories = self.order?.brandCategories.value,categories.count > 0 else { return 0 }
        return categories.count + 1
    }
    func getTitleForHeaderInSection(_ section: Int) -> String {
        guard section != self.getsectionCount() - 1 ,let categories = self.order?.brandCategories.value,categories.count > 0 else { return "" }
        return categories[section].brandRateCategoryName.value ?? ""
    }
    func getNumberOfRowsInSection(_ section: Int) -> Int{
        guard  section != self.getsectionCount() - 1 else { return 1}
        guard let categories = self.order?.brandCategories.value else { return 0 }
        guard let items = categories[section].brandRatingItems.value else {return 0}
        return items.count
    }
    func onChangeRateItem(atIndex indexPath : IndexPath,_ rating: Double){
         self.order?.brandCategories.value?[indexPath.section].brandRatingItems.value?[indexPath.row].value.value = Float(rating)
    }
    func onChangeComment(_ comment: String) {
        self.order?.comment.value = comment
    }
}
