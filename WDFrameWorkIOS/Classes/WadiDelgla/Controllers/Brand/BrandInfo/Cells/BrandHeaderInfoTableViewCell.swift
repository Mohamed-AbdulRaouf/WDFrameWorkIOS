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
