//
//  Checkout+test.swift
//  STDobites
//
//  Created by SimpleTouch on 9/10/20.
//  Copyright © 2020 SimpleTouch. All rights reserved.
//

import Foundation
import Foundation
import UIKit
extension CheckOutViewController : UITableViewDelegate,UITableViewDataSource {
    
    func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
//        tableView.rowHeight = UITableViewAutomaticDimension
#if swift(>=5.0)
print("Running Swift 5.0 or later")
        tableView.rowHeight = tableView.estimatedRowHeight
#else
print("Running old Swift")
        tableView.rowHeight = UITableViewAutomaticDimension
#endif
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let _ = self.viewModel?.calcResponse else { return 0 }
        guard let items = self.viewModel?.cart?.cartItems,items.count > 0 else { return 0 }
        return self.viewModel?.sections?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let titles = self.viewModel?.sections else { return 0}
        if titles[section] == "my_items".localized() {
            guard let items = self.viewModel?.cart?.cartItems else { return 0 }
            return items.count
        }else if titles[section] == "payment_methods".localized() {
            return self.viewModel?.paymentMethods?.count ?? 0
        }else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 2 {
            //            guard let order =  self.viewModel?.calcResponse,order.isCurrentRewardIdValid.value ?? false && order.currentCustomerIsRegistered.value ?? false else { return 0 }
        }
//        return UITableViewAutomaticDimension
#if swift(>=5.0)
print("Running Swift 5.0 or later")
        return tableView.estimatedRowHeight
#else
print("Running old Swift")
        return UITableViewAutomaticDimension
#endif
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let titles = self.viewModel?.sections
        if titles?[indexPath.section] == "address".localized(){
            let cell = tableView.dequeueReusableCell(withIdentifier: "CheckoutAddressTableViewCell", for: indexPath) as! CheckoutAddressTableViewCell
            if let address = self.viewModel?.cart?.userAddressDetails {
                cell.configureCell(address)
                cell.onChangeAddressTapped = { [weak self] in
                    let vc = StoryboardScene.User.userAddressListViewController.instantiate()
                    vc.viewModel?.sourceDelegate = self
                    self?.navigationController?.pushViewController(vc)
                    
                }
            }
            return cell
        }else if titles?[indexPath.section] == "my_items".localized() {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CheckoutItemTableViewCell", for: indexPath) as! CheckoutItemTableViewCell
            if let items = self.viewModel?.cart?.cartItems,indexPath.row <= items.count - 1 {
                cell.choiceCount = items[indexPath.row].amount
                cell.configureCell(items[indexPath.row])
            }
            return cell
        }else if titles?[indexPath.section] == "payment_methods".localized() {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CheckoutPaymentTableViewCell", for: indexPath) as! CheckoutPaymentTableViewCell
            
            cell.configureCell((self.viewModel?.paymentMethods?[indexPath.row])!,(self.viewModel?.getPaymentSubTitle())!)
            cell.onSelectedPaymentMethod = { [weak self] in
                self?.viewModel?.selectedPaymentMethodIndex = indexPath.row
            }
            cell.onSelectChangeCreditCard = {
                [weak self] in
                if self?.viewModel?.cart?.orderPaymentTypeId == PaymentType.creditCard.orderPaymentId {
                    self?.openCreditCardForm()
                }
            }
            return cell
        }else if titles?[indexPath.section] == "discount".localized(){
            let cell = tableView.dequeueReusableCell(withIdentifier: "CheckoutDiscountTableViewCell", for: indexPath) as! CheckoutDiscountTableViewCell
            if let order = self.viewModel?.calcResponse {
                cell.configureCell(order)
                cell.onApplyCouponCode = { coupon in
                    self.endEditing()
                    self.viewModel?.applyCouponCode(coupon)
                }
                cell.onChangeCouponCode = { coupon in
                    self.endEditing()
                    self.viewModel?.changeCouponCode(coupon)
                }
                cell.onApplyLoyalty = { redeemPoints in
                    self.openLoyaltyDiscountVC()
                }
            }
            return cell
        }else if titles?[indexPath.section] == "checkout_cash_details".localized() {
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
}
// MARK: - TableView Header
extension CheckOutViewController {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let titles = self.viewModel?.sections else { return ""}
        guard titles[section] != "checkout_cash_details".localized() else {
            return ""
        }
        return titles[section]
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let titles = self.viewModel?.sections
        if titles?[section] == "discount".localized() {
            guard let order =  self.viewModel?.calcResponse,order.isCurrentRewardIdValid.value ?? false && order.currentCustomerIsRegistered.value ?? false else { return 0 }
        }
        switch titles?[section] {
        case "address".localized() ,
             "my_items".localized(),
             "discount".localized(),
             "payment_methods".localized():
            return 30
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 30))
        
        let label = UILabel()
        if LocalizationSystem.sharedInstance.isCurrentLanguageArabic() {
            label.frame = CGRect.init(x: -30, y: 5, width: headerView.frame.width-10, height: headerView.frame.height-10)
        }else{
            label.frame = CGRect.init(x: 30, y: 5, width: headerView.frame.width-10, height: headerView.frame.height-10)
        }
        if let titles = self.viewModel?.sections,titles.count > 0 {
            if titles[section] == "checkout_cash_details".localized() {
                label.text = ""
            }else{
                label.text = titles[section]
            }
        }
        label.font = APP_FONT_BOLD14 //UIFont(resource: APP_FONT_BOLD, size: 14)
        label.textColor = COLOR_ACCENT_DARK
        headerView.addSubview(label)
        
        return headerView
        
    }
    
}
//MARK: - TableView Footer
extension CheckOutViewController {
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1.5
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard section != (self.viewModel?.sections?.count ?? 0) - 1 else {
            return nil
        }
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width - 20, height: 1.5))
        footerView.backgroundColor = UIColor.init(hexString: "D9DDDC")
        return footerView
        
    }
}
