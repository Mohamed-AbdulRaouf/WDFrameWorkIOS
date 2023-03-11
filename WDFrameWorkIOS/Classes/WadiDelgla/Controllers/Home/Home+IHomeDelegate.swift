//
//  HomeViewController+IHomeDelegate.swift
//  STDobites
//
//  Created by SimpleTouch on 11/7/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import UIKit
extension HomeViewController : IHomeViewController{
    
    
   
    
    func onReloadTable() {
         self.tableView.reloadData()
    }
    
    func openLogin() {
        let vc = StoryboardScene.User.loginViewController.instantiate()
        vc.delegate = self
        self.present(vc, animated: true, completion: nil)
    }
    
    func openRanking() {
        let vc = StoryboardScene.Features.rankingViewController.instantiate()
        self.navigationController?.pushViewController(vc)
    }
    
    func openQR() {
        let vc = StoryboardScene.Features.qRcodeViewController.instantiate()
        self.navigationController?.pushViewController(vc)
    }
    
    func openBranchLocations() {
        let vc = StoryboardScene.Location.nearResturantsLocationsViewController.instantiate()
        self.navigationController?.pushViewController(vc)
    }
    
    func openExplore() {
        self.tabBarController?.selectedIndex = 1
//        self.tabBarController?.delegate?.tabBarController!((self.tabBarController)!, didSelect: (self.tabBarController!.selectedViewController!))
    }
    func openNotificationList(){
        let vc = StoryboardScene.Features.notificationListViewController.instantiate()
        self.navigationController?.pushViewController(vc)
    }
    func updateNotificationCount(_ count: Int){
        self.notificationCountButton.setTitle("\(count)", for: .normal)
        self.notificationCountButton.isHidden = count == 0
    }
}
