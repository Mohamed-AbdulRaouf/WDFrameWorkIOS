//
//  MenuViewController+CollectionView.swift
//  STDobites
//
//  Created by SimpleTouch on 11/13/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import UIKit

// MARK: - Collection Data Source
extension MenuViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func setupCollectionView(){
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  self.viewModel?.categoryList?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as! CategoryCollectionViewCell
        if let viewModel = self.viewModel?.categoryList {
            cell.configureCell(viewModel[indexPath.row])
        }

        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let text = self.viewModel?.categoryList?[indexPath.row].categoryName.value ?? ""
        let width = UILabel.textWidth(font: UIFont(resource: APP_FONT_REGULAR, size: 14)!, text: text)
        return CGSize(width: width + 10 + 10, height: 50)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.3) {
            DispatchQueue.main.async {
                let indexPath = IndexPath(row: 0, section: indexPath.row)
                self.tableView.selectRow(at: indexPath, animated: true, scrollPosition: .top)
                self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
            }
        }
    }
}
