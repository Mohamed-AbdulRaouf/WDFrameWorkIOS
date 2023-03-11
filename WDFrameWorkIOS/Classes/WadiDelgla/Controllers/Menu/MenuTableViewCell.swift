//
//  MenuTableViewCell.swift
//  STDobites
//
//  Created by SimpleTouch on 11/13/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import UIKit
//import DAL
import Kingfisher
class MenuTableViewCell: UITableViewCell,IBaseTableViewCell {
    typealias T = IMenuItemsDTODAL
    
    
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemDescriptionLabel: UILabel!
    @IBOutlet weak var itemCaloriesLabel: UILabel!
    @IBOutlet weak var itemIngredientsLabel: UILabel!
    @IBOutlet weak var addItemButton: ResizableButton!
    var addItem : (() -> Void)?
    var animateItemImage : ((UIImage) -> Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func configureCell(_ model: IMenuItemsDTODAL) {
        self.itemNameLabel.font = UIFont(resource: APP_FONT_BOLD, size: 12)
        self.itemNameLabel.textColor = COLOR_PRIMARY_TEXT
        [self.itemDescriptionLabel,self.itemCaloriesLabel,self.itemIngredientsLabel].forEach {
            $0?.font = UIFont(resource: APP_FONT_REGULAR, size: 10)
            $0?.textColor = .lightGray
        }
        if let imageUrl = URL(string: model.imagePath.value ?? ""){
            let resource = ImageResource(downloadURL: imageUrl, cacheKey: model.imagePath.value)
            self.itemImageView.kf.setImage(with: resource)
        } else {
            self.itemImageView.image = UIImage(named: "dobites_splash")
        }
        self.itemImageView.isUserInteractionEnabled = true
        self.itemImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(animate)))

        self.itemNameLabel.text = model.itemName.value ?? ""
        
        
        if let isHasMultipleSizes = model.isItemHasMultipleSize.value,let sizes = model.sizes.value{
            let addBtnTitle = isHasMultipleSizes ? R.string.localizable.price_on_selection() : "\(sizes[0].sizePrice.value ?? 0) \(model.currencyCode.value ?? "")"
            self.addItemButton.setTitle(addBtnTitle, for: .normal)
        }
        
        
        self.itemDescriptionLabel.text = model.categoryDescription.value ?? ""
        self.itemIngredientsLabel.text = model.ingredients.value ?? ""
        self.itemCaloriesLabel.text = "\(model.itemCalories.value ?? 0) \(R.string.localizable.calories())"
    }
    
    @objc func animate(){
            self.animateItemImage!(self.itemImageView.image ?? R.image.defaultimg()!)
    }
      
    @IBAction func onAddItemTapped(_ sender: Any) {
        self.addItem!()
    }
}
