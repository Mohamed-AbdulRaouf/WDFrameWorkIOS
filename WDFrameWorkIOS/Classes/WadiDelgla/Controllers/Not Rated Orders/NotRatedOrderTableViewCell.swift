//
//  NotRatedOrderTableViewCell.swift
//  STDobites
//
//  Created by SimpleTouch on 11/27/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import UIKit
//import DAL
import Kingfisher
class NotRatedOrderTableViewCell: UITableViewCell,IBaseTableViewCell {
    typealias T = IOrderDTODAL
    @IBOutlet weak var orderNumberLabel: UILabel!
    @IBOutlet weak var orderTotalLabel: UILabel!
    @IBOutlet weak var brandNameLabel: UILabel!
    @IBOutlet weak var brandLogoImageView: UIImageView!
    
      var onRateTapped : (()->Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureCell(_ model: IOrderDTODAL){
        self.brandNameLabel.text = model.brandName.value ?? ""
        self.orderNumberLabel.text = "\(model.orderNumber.value ?? 0)"
        self.orderTotalLabel.text = "\(model.orderTotal.value ?? 0.0)"
        if let imageUrl = URL(string: model.brandLogoURL.value ?? ""){
            let resource = ImageResource(downloadURL: imageUrl, cacheKey: model.brandLogoURL.value)
            self.brandLogoImageView.kf.setImage(with: resource)
        } else {
            self.brandLogoImageView.image = UIImage(named: "dobites_splash")
        }
        self.brandLogoImageView.roundCorners([.bottomLeft, .topRight,.bottomRight,.topLeft], radius: self.brandLogoImageView.height / 2)
        self.brandLogoImageView.layer.borderColor = UIColor.lightGray.cgColor
        self.brandLogoImageView.layer.borderWidth = 1
    }
    @IBAction func onRateOrderTapped(_ sender: Any) {
        self.onRateTapped!()
    }
}
