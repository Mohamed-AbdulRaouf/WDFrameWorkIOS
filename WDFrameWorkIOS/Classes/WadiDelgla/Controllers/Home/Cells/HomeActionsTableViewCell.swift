//
//  HomeActionsTableViewCell.swift
//  STDobites
//
//  Created by Nermeen Mohamed on 10/28/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import UIKit

class HomeActionsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nearResturantsButton: UIButton!
    @IBOutlet weak var favoritesRestaurantButton: UIButton!
    @IBOutlet weak var rankingButton: UIButton!
    @IBOutlet weak var scanButton: UIButton!
    @IBOutlet weak var exploreButton: UIButton!
    
    var onExploreTapped : (() -> Void)?
    var onNearResturantsTapped: (() -> Void)?
    var onFavoritesResturantsTapped: (() -> Void)?
    var onRewardTapped: (() -> Void)?
    var onRankingTapped: (() -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureCell(){
        [self.exploreButton,self.scanButton,self.rankingButton].forEach {
            $0?.setTitleColor(COLOR_ACCENT, for: .normal)
        }
        self.exploreButton.titleLabel?.font = APP_FONT_BOLD //UIFont(resource: APP_FONT_BOLD, size: 16)
        self.scanButton.titleLabel?.font = APP_FONT_BOLD //UIFont(resource: APP_FONT_BOLD, size: 17)
        self.rankingButton.titleLabel?.font = APP_FONT_BOLD //UIFont(resource: APP_FONT_BOLD, size: 18)
       
        [self.favoritesRestaurantButton,self.nearResturantsButton].forEach {
            $0.layer.cornerRadius = 20
            $0.setTitleColor(COLOR_ACCENT, for: .normal)
            $0.titleLabel?.font = APP_FONT_BOLD //UIFont(resource: APP_FONT_BOLD, size: 17)
            $0.backgroundColor = .white
        }
        let iconImage:UIImage? = UIImage.getFontAwaseomImage(fontName: FontAwesome_ImageIcons_Names.heart_bold.rawValue,imageSize: CGSize(width: 30, height: 30))
        self.favoritesRestaurantButton.setImage(iconImage, for: .normal)
        
        let nearbyImage:UIImage? = UIImage.getFontAwaseomImage(fontName: FontAwesome_ImageIcons_Names.map_marker_bold.rawValue,imageSize: CGSize(width: 30, height: 30))
        self.nearResturantsButton.setImage(nearbyImage, for: .normal)

        
        self.exploreButton.setTitle(R.string.localizable.explore(), for: .normal)
        self.scanButton.setTitle(R.string.localizable.scan_earn(), for: .normal)
        self.rankingButton.setTitle(R.string.localizable.rankings(), for: .normal)
        self.favoritesRestaurantButton.setTitle(R.string.localizable.favorite_resturants(), for: .normal)
        self.nearResturantsButton.setTitle(R.string.localizable.near_resturants(), for: .normal)

    }
    
    @IBAction func onExploreTapped(_ sender: Any) {
        self.onExploreTapped!()
    }
    @IBAction func onRewardTapped(_ sender: Any) {
        self.onRewardTapped!()
    }
    @IBAction func onRankingTapped(_ sender: Any) {
        self.onRankingTapped!()
    }
    @IBAction func onFavoritesResturantsTapped(_ sender: Any) {
        self.onFavoritesResturantsTapped!()
    }
    @IBAction func onNearResturantsTapped(_ sender: Any) {
        self.onNearResturantsTapped!()
    }
}
