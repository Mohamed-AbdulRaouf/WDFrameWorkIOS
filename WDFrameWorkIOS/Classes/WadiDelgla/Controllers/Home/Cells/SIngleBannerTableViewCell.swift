//
//  SIngleBannerTableViewCell.swift
//  STDobites
//
//  Created by Nermeen Mohamed on 10/28/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import UIKit
//import DAL
import Kingfisher
class SIngleBannerTableViewCell: UITableViewCell ,IBaseTableViewCell{
    
    typealias T = IAdsDTODAL

    @IBOutlet weak var bannerImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configureCell(_ model: IAdsDTODAL) {
        if let url = URL(string: model.imagePath.value ?? "") {
            let adResource = ImageResource(downloadURL: url, cacheKey: model.imagePath.value)
            self.bannerImageView.kf.setImage(with: adResource)
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
