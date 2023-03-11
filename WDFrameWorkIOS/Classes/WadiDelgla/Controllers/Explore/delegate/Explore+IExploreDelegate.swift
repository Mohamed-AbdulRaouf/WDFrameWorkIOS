//
//  Explore+IExploreDelegate.swift
//  STDobites
//
//  Created by SimpleTouch on 11/6/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import UIKit
extension ExploreViewController : IExploreViewController{
    
   
    
    func onReloadTableView() {
        self.tableView.reloadData()
    }
    func onReloadServiceCollectionView(){
        self.serviceCollectionView.reloadData()
    }
    func setFilter(_ filterText: String) {
        self.viewModel?.clearData()
        self.viewModel?.requestBrandDTO?.brandName.value = filterText
        self.viewModel?.getBrandList()
    }
    func setServiceId(_ serviceId: String) {
        self.viewModel?.brand = nil
        self.viewModel?.requestBrandDTO?.serviceIDs.value = serviceId
        self.viewModel?.getBrandList()
    }
    func openLogin() {
        let vc = StoryboardScene.User.loginViewController.instantiate()
        vc.delegate = self
        self.present(vc, animated: true, completion: nil)
    }
     
}
extension ExploreViewController : LoginProtocol{
    func onUserLogedIn() {
        if let _ = UserDefaults.user{
            self.viewModel?.refreshList()
            DispatchQueue.global(qos: .background).async {
                self.viewModel?.getServices()
            }
        }
    }
}
extension ExploreViewController: IFilterProtocol{
    func setSelectedFacilityAndCusinies(_ cusinies: [String], _ facilities: [String]) {
       self.viewModel?.setCusiniesAndFacilities(cusinies, facilities)
    }
}
extension ExploreViewController: ISortProtocol{
    func selectSortItem(_ index: Int) {
        self.viewModel?.selectSort(atIndex: index)
    }
}
protocol IFilterProtocol:AnyObject {
     func setSelectedFacilityAndCusinies(_ cusinies: [String], _ facilities: [String])
}

protocol ISortProtocol :AnyObject{
    func selectSortItem(_ index: Int)
}
