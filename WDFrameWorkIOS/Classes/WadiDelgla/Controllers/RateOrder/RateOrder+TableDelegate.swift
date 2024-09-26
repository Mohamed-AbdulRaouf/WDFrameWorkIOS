//
//  RateOrder+TableDelegate.swift
//  STDobites
//
//  Created by SimpleTouch on 11/27/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Table Data Source
extension RateOrderViewController : UITableViewDelegate,UITableViewDataSource {
   
    func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 60.0
        tableView.estimatedSectionHeaderHeight = 44
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return (self.viewModel?.getsectionCount())!
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  (self.viewModel?.getNumberOfRowsInSection(section))!
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == (self.viewModel?.getsectionCount() ?? 0) - 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "RateOrderCommentTableViewCell", for: indexPath) as! RateOrderCommentTableViewCell
            if let order = self.viewModel?.order {
                 cell.configureCell(order.comment.value ?? "",order.isOrderRatedBefore.value ?? false)
                cell.onChangeComment = { [weak self] comment in
                    self?.viewModel?.onChangeComment(comment)
                }
                cell.onSubmitTapped = { [weak self] in
                    self?.viewModel?.rateOrder()
                }
                
            }
           
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "BrandItemTableViewCell", for: indexPath) as! BrandItemTableViewCell
        
            if let item = self.viewModel?.order?.brandCategories.value?[indexPath.section].brandRatingItems.value?[indexPath.row] {
                cell.configureCell(item,self.viewModel?.order?.isOrderRatedBefore.value ?? false)
                cell.onChangeRateValue = { [weak self] rating in
                  self?.viewModel?.onChangeRateItem(atIndex: indexPath, rating)
                }
            }
            return cell
        }
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.viewModel?.setCellHeight(atIndexPath: indexPath, cell.frame.size.height)
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.viewModel?.getCellHeight(atIndexPath: indexPath) ?? 0.0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90 //UITableView.automaticDimension
    }
}

// MARK: - Table Header & Footer sections
extension RateOrderViewController{
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.viewModel?.getTitleForHeaderInSection(section)
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = .white
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = COLOR_PRIMARY_TEXT
        header.textLabel?.font = APP_FONT_BOLD14 //UIFont(resource: APP_FONT_BOLD, size: 14)
    }
    /* Footer */
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        guard section != (self.viewModel?.getsectionCount() ?? 0) - 1 else { return 60 }
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard section != (self.viewModel?.getsectionCount() ?? 0) - 1 else { return UIView()}
        
        let shadowView = UIView()
        let gradient = CAGradientLayer()
        gradient.frame.size = CGSize(width: tableView.bounds.width, height: 15)
        
        let stopColor = UIColor.lightGray.cgColor
        let startColor = UIColor.white.cgColor
        
        gradient.colors = [stopColor, startColor]
        gradient.locations = [0.0,0.8]
        shadowView.layer.addSublayer(gradient)
        return shadowView
    }
}
