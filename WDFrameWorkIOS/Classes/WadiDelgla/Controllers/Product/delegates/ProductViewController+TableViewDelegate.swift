//
//  ProductViewController+TableViewDelegate.swift
//  STDobites
//
//  Created by SimpleTouch on 11/17/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import UIKit

//MARK: TableView Delegate and data source
extension ProductViewController: UITableViewDelegate, UITableViewDataSource,UITextViewDelegate{
    func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 60.0
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 { return ""}
        if section == 1 { return "select_size".localized()}
        else if section == ((self.viewModel?.getNumberOfSections() ?? 0) - 1){ return "special_instructions".localized()}
        else {
            guard let choicesGroup = self.viewModel?.product?.sizes.value?[(self.viewModel?.selectedSizeIndex!)!].choiceGroups.value ,choicesGroup.count > 0 else { return ""}
            return choicesGroup[section - 2].choiceGroupTitle.value ?? ""
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 { return 0}
        else { return 60 }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel?.getNumberOfSections() ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 { return 60} // UITableView.automaticDimension
        else if indexPath.section == ((self.viewModel?.getNumberOfSections() ?? 0) - 1){ return 250}
        else { return 40}
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 { return 1}
        else if section == ((self.viewModel?.getNumberOfSections() ?? 0) - 1){ return 1}
        else if section == 1{ return self.viewModel?.product?.sizes.value?.count ?? 0}
        else {
            
            guard let choiceGroups = self.viewModel?.product?.sizes.value?[(self.viewModel?.selectedSizeIndex!)!].choiceGroups.value, let choices = choiceGroups[section - 2].choices.value, choices.count > 0 else { return 0}
            return choices.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailsTableViewCell", for: indexPath) as! ProductDetailsTableViewCell
            cell.selectionStyle = .none
            if let product = self.viewModel?.product {
                cell.configureCell(product)
            }
            return cell
        }else if indexPath.section == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProductSizeTableViewCell", for: indexPath) as! ProductSizeTableViewCell
            cell.selectionStyle = .none
            if let sizes = self.viewModel?.product?.sizes.value {
                if sizes.count == 1 {
                    self.viewModel?.product?.sizes.value?[indexPath.row].isSelected.value = true
                }
                cell.configureCell(sizes[indexPath.row])
                cell.onSelectedSize = { [weak self] in
                    self?.viewModel?.selectedSizeIndex = indexPath.row
                }
            }
            return cell
        }else if indexPath.section == ((self.viewModel?.getNumberOfSections() ?? 0) - 1){
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCommentTableViewCell", for: indexPath) as! ProductCommentTableViewCell
            cell.selectionStyle = .none
            
            cell.configureCell(self.viewModel?.product?.itemComment.value ?? "")
            cell.onChangeComment = { [weak self] comment in
                self?.viewModel?.product?.itemComment.value = comment
               
            }
            
            
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProductChoiceTableViewCell", for: indexPath) as! ProductChoiceTableViewCell
            cell.selectionStyle = .none
            if let choice = self.viewModel?.product?.sizes.value?[(self.viewModel?.selectedSizeIndex!)!].choiceGroups.value?[indexPath.section - 2].choices.value?[indexPath.row]{
                cell.configureCell(choice)
            }
            cell.checkTapAction = { [weak self]
                (isOn) in
                self?.viewModel?.onChoiceTappedAtIndex(indexPath,isOn)
            }
            return cell
            
        }
        
    }

}
