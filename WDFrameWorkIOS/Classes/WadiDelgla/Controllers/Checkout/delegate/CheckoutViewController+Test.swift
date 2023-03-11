//
//  CheckoutViewController+TableDelegate.swift
//  STDobites
//
//  Created by SimpleTouch on 11/25/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import UIKit
/*
// MARK: - Table Data Source
extension CheckOutViewController : UITableViewDelegate,UITableViewDataSource {
    func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 60.0
        tableView.rowHeight = UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 || section == 2 || section == 3{
            return 1
        }else{
            guard let items = self.viewModel?.cart?.cartItems else { return 0 }
            return items.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "CheckoutAddressTableViewCell", for: indexPath) as! CheckoutAddressTableViewCell
            if let address = self.viewModel?.cart?.userAddressDetails {
                cell.configureCell(address)
            }
            return cell
        }else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CheckoutItemTableViewCell", for: indexPath) as! CheckoutItemTableViewCell
            if let items = self.viewModel?.cart?.cartItems,indexPath.row <= items.count - 1 {
                cell.choiceCount = items[indexPath.row].amount
                cell.configureCell(items[indexPath.row])
            }
            return cell
        }else if indexPath.section == 2{
            let cell = tableView.dequeueReusableCell(withIdentifier: "CheckoutDiscountTableViewCell", for: indexPath) as! CheckoutDiscountTableViewCell
            if let order = self.viewModel?.calcResponse {
                cell.configureCell(order)
                cell.onApplyCouponCode = { coupon in
                    self.endEditing()
                    self.viewModel?.applyCouponCode(coupon)
                }
                cell.onApplyLoyalty = { redeemPoints in
                  
                    self.showRedeemVC()
                }

            }
            
            return cell
        }else if indexPath.section == 3{
            let cell = tableView.dequeueReusableCell(withIdentifier: "CheckoutDetailsTableViewCell", for: indexPath) as! CheckoutDetailsTableViewCell
            if let cart = self.viewModel?.calcResponse {
                cell.configureCell(cart)
            }
            return cell
        }else{
            return UITableViewCell()
        }
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.viewWillLayoutSubviews()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 2 {
//            guard let order =  self.viewModel?.calcResponse,order.isCurrentRewardIdValid.value ?? false && order.currentCustomerIsRegistered.value ?? false else { return 0 }
        }
        return UITableView.automaticDimension
    }
}

// MARK: - Table Header & Footers sections
extension CheckOutViewController{
   
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let items = self.viewModel?.cart?.cartItems,items.count > 0 else { return 0 }
        return 4
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1.0
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let titles = self.viewModel?.titles else { return ""}
        return titles[section]
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 30))
        
        let label = UILabel()
        if APP_LANGUAGE == "ar" {
            label.frame = CGRect.init(x: -20, y: 5, width: headerView.frame.width-10, height: headerView.frame.height-10)
        }else{
            label.frame = CGRect.init(x: 20, y: 5, width: headerView.frame.width-10, height: headerView.frame.height-10)
        }
        if let titles = self.viewModel?.titles,titles.count > 0 {
            label.text = titles[section]
        }
        label.font = UIFont(resource: APP_FONT_BOLD, size: 14)
        label.textColor = COLOR_PRIMARY_TEXT
        headerView.addSubview(label)
        
        return headerView
        
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 2 {
            guard let order =  self.viewModel?.calcResponse,order.isCurrentRewardIdValid.value ?? false && order.currentCustomerIsRegistered.value ?? false else { return 0 }
        }
        switch section {
        case 0 , 1,2:
            return 30
        default:
            return 0
        }
    }
}
*/
