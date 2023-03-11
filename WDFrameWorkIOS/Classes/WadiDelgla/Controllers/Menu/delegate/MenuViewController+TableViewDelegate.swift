//
//  MenuViewController+TableViewDelegate.swift
//  STDobites
//
//  Created by SimpleTouch on 11/13/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import UIKit
//MARK: -TableView Delegate ,data source
extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    func animateImageView(_ itemImage : UIImage){
            let vc = StoryboardScene.Features.imageZoomingViewController.instantiate()
            vc.image = itemImage
            self.present(vc, animated: true, completion: nil)
        }
    func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel?.categoryList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel?.categoryList?[section].menuItems.value?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell", for: indexPath) as! MenuTableViewCell
        if let viewModel = self.viewModel?.categoryList,let items = viewModel[indexPath.section].menuItems.value {
            cell.configureCell(items[indexPath.row])
            cell.addItem = { [weak self] in
                self?.viewModel?.addItemTapped(items[indexPath.row])
            }
            cell.animateItemImage = { [weak self] itemImage in
                                   self?.animateImageView(itemImage)
                               }
        }
        return cell
     }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    //Header
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
        headerView.backgroundColor = .white
        let label = STUnderlinedLabel()
        if K.shared.APP_LANGUAGE == "ar"{
            label.frame = CGRect.init(x: -20, y: 5, width: headerView.frame.width-10, height: headerView.frame.height-10)
        }else{
            label.frame = CGRect.init(x: 20, y: 5, width: headerView.frame.width-10, height: headerView.frame.height-10)
        }
        label.text = self.viewModel?.categoryList?[section].categoryName.value ?? ""
        label.font = UIFont(resource: APP_FONT_BOLD, size: 14)
        label.textColor = COLOR_PRIMARY_TEXT
        headerView.addSubview(label)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if let visibleRows = tableView.indexPathsForVisibleRows {
            let visibleSections = visibleRows.map({$0.section})
            
            self.collectionView.scrollToItem(at: IndexPath(row: visibleSections.first ?? 0, section: 0), at: [.centeredVertically, .centeredHorizontally], animated: true)
            
            self.collectionView.selectItem(at:  IndexPath(row:visibleSections.first ?? 0, section: 0), animated: false, scrollPosition: [.centeredVertically, .centeredHorizontally])
        }
    }
}

