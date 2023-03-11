//
//  BannerCollectionViewCell.swift
//  STDobites
//
//  Created by Nermeen Mohamed on 10/28/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import UIKit
//import DAL
import Kingfisher
class BannerCollectionViewCell: UICollectionViewCell ,IBaseCollectionViewCell{
    
    
    typealias T = IAdsDTODAL
    
    @IBOutlet weak var bannerDescriptionLabel: UILabel!
    @IBOutlet weak var bannerTitleLabel: UILabel!
    @IBOutlet weak var bannerImageView: UIImageView!
    
    func configureCell(_ model: IAdsDTODAL) {
        if let url = URL(string: model.imagePath.value ?? "") {
            let adResource = ImageResource(downloadURL: url, cacheKey: model.imagePath.value)
            self.bannerImageView.kf.setImage(with: adResource)
        }
        self.bannerTitleLabel.text = model.adsTitle.value ?? ""
        self.bannerDescriptionLabel.text = model.adsDescription.value ?? ""
    }
    
}
