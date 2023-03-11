//
//  ExploreViewController+TableViewDelegate.swift
//  STDobites
//
//  Created by SimpleTouch on 11/6/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import UIKit
//MARK: TableView Delegate and data source

extension ExploreViewController: UITableViewDelegate, UITableViewDataSource{
    func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        // tableView.tableFooterView = searchFooter
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130.0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.brand?.items.value?.count ?? 0
     }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BrandTableViewCell", for: indexPath) as! BrandTableViewCell
        if let items = self.viewModel?.brand?.items.value {
            cell.configureCell(items[indexPath.row])
            cell.onRegisterToBrand = { [weak self] in
                self?.viewModel?.registerUserInBrand(indexPath.row)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        let vc = StoryboardScene.Brand.brandInfoViewController.instantiate()
        vc.viewModel?.brandId = self.viewModel?.brand?.items.value?[indexPath.row].brandId.value
        self.navigationController?.pushViewController(vc)
    }
    
}
