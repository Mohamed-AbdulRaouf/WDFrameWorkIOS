//
//  CartItemTableViewCell.swift
//  STDobites
//
//  Created by SimpleTouch on 11/14/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import UIKit
//import DAL
import Kingfisher
class CartItemTableViewCell: UITableViewCell ,IBaseTableViewCell{
    typealias T = ISTCartItemDTODAL
    @IBOutlet weak var quantityTitleLabel: UILabel!
    @IBOutlet weak var itemPriceLabel: UILabel!
    @IBOutlet weak var itemSubTotalLabel: UILabel!
    
    @IBOutlet weak var itemCommentLabel: UILabel!
    @IBOutlet weak var itemQuantityLabel: UILabel!
    @IBOutlet weak var itemSizeLabel: UILabel!
    @IBOutlet weak var itemChoicesLabel: UILabel!
    @IBOutlet weak var deleteItemButton: UIButton!
    @IBOutlet weak var itemTitleLabel: UILabel!
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemCommentButton: UIButton!

    weak var delegate: ICartOperation?
    var item : ISTCartItemDTODAL?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureCell(_ model: ISTCartItemDTODAL) {
        item = model
        self.quantityTitleLabel.text = "quantity".localized()
        
        let iconImage:UIImage? = UIImage.getFontAwaseomImage(fontName: "fas fa-trash",imageSize: CGSize(width: 20, height: 20))
        deleteItemButton.setImage(iconImage, for: .normal)
        
        itemTitleLabel.text = model.itemName
        
        if let imageUrl = URL(string: model.itemImage){
            let resource = ImageResource(downloadURL: imageUrl, cacheKey: model.itemImage)
            self.itemImageView.kf.setImage(with: resource)
        } else {
            self.itemImageView.image = UIImage(named: "dobites_splash")
        }
        self.itemPriceLabel.attributedText = setupLabels("item_price".localized(), "  \(String(format: "%.2f", model.itemPrice) + (model.itemCurrencyCode))")
        
        self.itemSubTotalLabel.attributedText = setupLabels("total".localized(), "  \(String(format: "%.2f", Float(model.subTotal)) + (model.itemCurrencyCode)) ")
        
        
        itemQuantityLabel.text = "\(model.amount)"
        self.itemChoicesLabel.text = ""
        if model.choices.count > 0{
            var choiceArr = [String]()
            choiceArr.removeAll()
            for choice in model.choices {
                choiceArr.append(choice.itemChoiceName )
                self.itemChoicesLabel.text = choiceArr.joined(separator: ",")
            }
        }
       
        [itemCommentLabel,itemSizeLabel].forEach { (label) in
            label?.textColor = COLOR_ACCENT
            label?.font = APP_FONT_BOLD10 //UIFont(resource: , size: 10)
            
        }
        self.itemCommentLabel.text = "\(model.itemComment)"
        self.itemSizeLabel.text = "\(model.sizeName)"
        
        let iconImageComment:UIImage? = UIImage.getFontAwaseomImage(fontName: "far fa-comment-alt",imageSize: CGSize(width: 30, height: 30),.white).withRenderingMode(.alwaysTemplate)
        self.itemCommentButton.setImage(iconImageComment, for: .normal)
        self.itemCommentButton.tintColor = .lightGray

    }
    @IBAction func onCommentItemTapped(_ sender: Any) {
             print("open Add Comment")
             guard let item = item else { return }
             self.delegate?.updateComment(item.visualCode, withComment: item.itemComment)
         }
    @IBAction func onDeleteItemTapped(_ sender: Any) {
        guard let item = item else { return }
        self.delegate?.deleteItem(item)

    }
    @IBAction func onDecreaseItemTapped(_ sender: Any) {
        guard let item = item else { return }
        self.delegate?.decreamentItem(item)

    }
    @IBAction func onIncreaseItemTapped(_ sender: Any) {
        guard let item = item else { return }
        self.delegate?.increamentItem(item)
    }
    func setupLabels(_ str1:String,_ str2:String) -> NSMutableAttributedString {
        let attrs1 = [NSAttributedString.Key.font : APP_FONT_REGULAR12, NSAttributedString.Key.foregroundColor :COLOR_PRIMARY_TEXT]
        
        let attrs2 = [NSAttributedString.Key.font : APP_FONT_BOLD12, NSAttributedString.Key.foregroundColor : COLOR_PRIMARY_TEXT]
        
        
        let attributedString1 = NSMutableAttributedString(string:str1, attributes:attrs1)
        
        let attributedString2 = NSMutableAttributedString(string: str2, attributes:attrs2)
        
        attributedString1.append(attributedString2)
        return attributedString1
    }
}
