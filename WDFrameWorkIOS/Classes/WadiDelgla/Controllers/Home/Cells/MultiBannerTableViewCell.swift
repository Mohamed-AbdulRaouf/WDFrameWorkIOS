//
//  MultiBannerTableViewCell.swift
//  STDobites
//
//  Created by Nermeen Mohamed on 10/28/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import UIKit
//import DAL
class MultiBannerTableViewCell: UITableViewCell,IBaseTableViewCell {
    
    typealias T = [IAdsDTODAL]
    
    @IBOutlet weak var bannersCollectionView: UICollectionView!
    var banners : [IAdsDTODAL]?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupCollectionView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureCell(_ model: [IAdsDTODAL]) {
        self.banners = model
        
    }
}
extension MultiBannerTableViewCell : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout ,IBaseCollectionView{
    func setupCollectionView() {
        self.bannersCollectionView.delegate = self
        self.bannersCollectionView.dataSource = self
        self.bannersCollectionView.isPagingEnabled = true
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return banners?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerCollectionViewCell", for: indexPath) as! BannerCollectionViewCell
        if let _ = self.banners {
            cell.configureCell(self.banners![indexPath.row])
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width  , height: collectionView.frame.height )
    }
}
