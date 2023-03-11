//
//  Explore+CollectionViewDelegate.swift
//  STDobites
//
//  Created by SimpleTouch on 11/6/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import UIKit
extension ExploreViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func setupCollectionView(){
        self.serviceCollectionView.delegate = self
        self.serviceCollectionView.dataSource = self
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard self.viewModel?.filterAndSeviceList?.serviceList != nil else {return 0}
        return (self.viewModel?.filterAndSeviceList?.serviceList.value?.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExploreServicesCell", for: indexPath) as! ExploreServicesCell
        if let viewModel = viewModel?.filterAndSeviceList?.serviceList.value {
            cell.configureCell(viewModel[indexPath.row])
        }
        if indexPath.row == selectedServiceIndex {
            cell.serviceImageView.image = cell.serviceImageView.image?.withRenderingMode(.alwaysTemplate)
            cell.serviceImageView.tintColor = UIColor(white: 1, alpha: 1)
            cell.serviceNameLabel.textColor =  UIColor(white: 0, alpha: 1)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 100.0)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedServiceIndex = indexPath.row
        self.setServiceId(self.viewModel?.filterAndSeviceList?.serviceList.value?[indexPath.row].id.value ?? "")
    }
    
}
