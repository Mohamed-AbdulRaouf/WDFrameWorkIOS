//
//  OrderTypeViewController+CollectionViewDelegate.swift
//  SimpleTouch
//
//  Created by SimpleTouch on 9/28/20.
//  Copyright © 2020 SimpleTouch. All rights reserved.
//

import UIKit
extension OrderTypeViewController : UICollectionViewDelegate,UICollectionViewDataSource,IBaseCollectionView{
    
    func setupCollectionView() {
        self.collectionView.delegate = self
          self.collectionView.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        //For Adjusting the cells spacing
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectionView.collectionViewLayout = layout
      }
      
      func numberOfSections(in collectionView: UICollectionView) -> Int {
          return 1
      }
      
      func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel?.orderTypeModel?.count ?? 0
      }
      
      func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
          let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OrderTypeCollectionViewCell", for: indexPath) as! OrderTypeCollectionViewCell
        if let model = self.viewModel?.orderTypeModel {
            cell.configureCell(model[indexPath.row])
        }
        return cell
      }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.navigationController?.popViewController(animated: true, {
             if let itemId = self.viewModel?.orderTypeModel?[indexPath.row].itemId.value {
                       self.viewModel?.orderTypeDelegate?.didSelectOrderType(itemId)
                   }
        })
    }
}
extension OrderTypeViewController :UICollectionViewDelegateFlowLayout{

       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           return CGSize(width: 100.0, height: 100.0)
        }
       
       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
           return 0
       }
       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
           return 0
       }
}
