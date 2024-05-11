//
//  BrandHeaderInfoTableViewCell.swift
//  STDobites
//
//  Created by Nermeen Mohamed on 11/5/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import UIKit
//import DAL
import Cosmos
import Bond
import Kingfisher
class BrandHeaderInfoTableViewCell: UITableViewCell ,IBaseTableViewCell{
    typealias T = IBrandDTODAL
    var viewModel: IBrandHeaderInfoTableViewCellViewModel?
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var directionButton: UIButton!
//    @IBOutlet weak var brandDetailsLabel: UILabel!
//    @IBOutlet weak var rateView: CosmosView!
//    @IBOutlet weak var brandNameLabel: UILabel!
    @IBOutlet weak var brandBackgroundImageView: UIImageView!
    var onTappedShare : (()->Void)?
    var onTappedDirection : (()->Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(_ model: IBrandDTODAL) {
        self.viewModel = BrandHeaderInfoTableViewCellViewModel()
        self.viewModel?.viewDidLoad(model)
        self.selectionStyle = .none
        guard let viewModel = viewModel else { return }
        [directionButton,shareButton].forEach {
            $0?.layer.cornerRadius = 30
            $0?.layer.borderWidth = 3
            $0?.layer.borderColor = COLOR_ACCENT.cgColor
        }
        shareButton.setImage(viewModel.shareImage, for: .normal)
        directionButton.setImage(viewModel.directionImage, for: .normal)
        self.brandBackgroundImageView.image = viewModel.brandImageResource as? UIImage
        self.shareButton.isHidden = viewModel.isHiddedShareButton
    }
    
    @IBAction func onDirectionTapped(_ sender: Any) {
          self.onTappedDirection!()
    }
    @IBAction func onShareTapped(_ sender: Any) {
         self.onTappedShare!()
    }
}
/*
func old{
    let iconImage:UIImage? = UIImage.getFontAwaseomImage(fontName: "fas fa-share-alt",imageSize: CGSize(width: 30, height: 30))
    shareButton.setImage(iconImage, for: .normal)
    
    let dircection_iconImage:UIImage? = UIImage.getFontAwaseomImage(fontName: "fas fa-map-marker-alt",imageSize: CGSize(width: 25, height: 25))
    directionButton.setImage(dircection_iconImage, for: .normal)
    
    if let brandImageUrl = URL(string: model.backgroundAdsImage.value ?? "") {
        let resource = ImageResource(downloadURL: brandImageUrl, cacheKey: model.backgroundAdsImage.value ?? "")
        self.brandBackgroundImageView.kf.setImage(with: resource)
    } else {
        self.brandBackgroundImageView.image = R.image.ic_dobites()
    }
    
    if let brandImageUrl = URL(string: model.brandLogoPath.value ?? "") {
        let resource = ImageResource(downloadURL: brandImageUrl, cacheKey: model.brandLogoPath.value ?? "")
        self.brandImageView.kf.setImage(with: resource)
    } else {
        self.brandImageView.image = R.image.ic_dobites()
    }
    
    [brandNameLabel].forEach { (label) in
        label?.font = UIFont(resource: APP_FONT_BOLD, size: 16)
        label?.textColor = .white
    }
    [brandDetailsLabel].forEach { (label) in
        label?.font = UIFont(resource: APP_FONT_REGULAR, size: 12)
        label?.textColor = .white
    }
    [directionButton,shareButton].forEach {
        $0?.layer.cornerRadius = 30
        $0?.layer.borderWidth = 3
        $0?.layer.borderColor = COLOR_ACCENT.cgColor
    }
    var cuisine = ""
    model.cuisines.value?.forEach({ (item) in
        cuisine += item.name.value ?? ""
    })
    
    self.brandDetailsLabel.text = cuisine
    self.brandNameLabel.text = model.brandName.value
    self.rateView.rating = Double(model.ratingValue.value ?? 0)
    self.rateView.isUserInteractionEnabled = false
    self.rateView.text = "(\(model.numberOfUserRate.value))"
    
    
    if let token = UserDefaults.user?.token.value, let shareCode = model.shareCode.value, let isCanshare =  model.isCanShareToOthers.value {
        if token == "" || shareCode == "" || !isCanshare {
            self.shareButton.isHidden = true
        }
    }
    
}
*/
