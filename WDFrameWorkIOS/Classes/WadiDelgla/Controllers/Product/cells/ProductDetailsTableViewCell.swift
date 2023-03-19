//
//  ProductDetailsTableViewCell.swift
//  STDobites
//
//  Created by SimpleTouch on 11/17/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import UIKit
//import DAL
import Kingfisher
class ProductDetailsTableViewCell: UITableViewCell,IBaseTableViewCell {

    typealias T = IMenuItemsDTODAL
    @IBOutlet weak var productDescriptionLabel: UILabel!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureCell(_ model: IMenuItemsDTODAL){
         self.productImageView.backgroundColor = .lightGray
        if let imageUrl = URL(string: model.imagePath.value ?? ""){
            let resource = ImageResource(downloadURL: imageUrl, cacheKey: model.imagePath.value ?? "")
            self.productImageView.kf.setImage(with: resource)
        } else {
            self.productImageView.image = R.image.defaultimg()
        }
        self.productImageView.backgroundColor = .white
        self.productNameLabel.text = model.itemName.value ?? ""
        self.productNameLabel.font = APP_FONT_BOLD //APP_FONT_BOLD //UIFont(resource: APP_FONT_BOLD, size: 20)
        self.productNameLabel.textColor = COLOR_PRIMARY_TEXT
        self.productDescriptionLabel.text = model.categoryDescription.value ?? ""
        self.productDescriptionLabel.textColor = .lightGray
        self.productDescriptionLabel.font = APP_FONT_REGULAR12 //UIFont(resource: APP_FONT_REGULAR, size: 13)
    }

}
