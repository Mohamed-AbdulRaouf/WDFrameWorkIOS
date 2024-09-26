//
//  BrandFacilitiesTableViewCell.swift
//  STDobites
//
//  Created by Nermeen Mohamed on 11/5/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import UIKit
//import DAL
class BrandFacilitiesTableViewCell: UITableViewCell ,IBaseTableViewCell{
    
    typealias T = [IFacilityDTODAL]
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var headerTitleLabel: UILabel!
    
    var facilities : [IFacilityDTODAL]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionView.delegate = self
        collectionView.dataSource = self
        self.headerTitleLabel.font = APP_FONT_BOLD //UIFont(resource: APP_FONT_BOLD, size: 16)
        self.headerTitleLabel.text = R.string.localizable.facilities()
        self.headerTitleLabel.textColor = COLOR_PRIMARY_TEXT
        self.selectionStyle = .none
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func configureCell(_ model: [IFacilityDTODAL]) {
        self.facilities = model
        self.collectionView.reloadData()
    }
    
}
////MARK:- CitiesCollectionDataSource
extension BrandFacilitiesTableViewCell : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard facilities != nil else {return 0}
        return (facilities?.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BrandFacilityCollectionCell", for: indexPath) as! BrandFacilityCollectionCell
        
        cell.configureCell((facilities?[indexPath.row])!)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
