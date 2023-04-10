//
//  CheckoutItemTableViewCell.swift
//  STDobites
//
//  Created by SimpleTouch on 11/25/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import UIKit
//import DAL
class CheckoutItemTableViewCell: UITableViewCell,IBaseTableViewCell {
    typealias T = ISTCartItemDTODAL
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var itemPriceLabel: UILabel!
    @IBOutlet weak var itemNameQLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
  
    var choices = [ISTItemAttributeDTODAL]() {
        didSet{
            self.collectionView.reloadData()
            let height = collectionView.collectionViewLayout.collectionViewContentSize.height
            collectionViewHeight.constant = height
            self.setNeedsLayout()
            self.layoutIfNeeded()
        }
    }
    var choiceCount : Int!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupCollectionView()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureCell(_ model: ISTCartItemDTODAL) {
        if LocalizationSystem.sharedInstance.isCurrentLanguageArabic() {
            self.itemNameQLabel.text =
           "\(String(describing: model.amount ).enToArDigits) * \(String(describing: model.itemName ))"

        }else{
            self.itemNameQLabel.text = "\(String(describing: model.amount ))x \(String(describing: model.itemName ))"

        }
        let price = model.itemPrice * Double(model.amount)
        self.itemPriceLabel.text = "\(String(format: "%.2f", price ) + "\(String(describing: model.itemCurrencyCode ))")"
        self.choices = model.choices
        [self.itemNameQLabel].forEach {
            $0?.textAlignment = LocalizationSystem.sharedInstance.isCurrentLanguageArabic() ? .right : .left
        }

    }
    override func layoutSubviews() {
        self.layoutIfNeeded()
    }
    
}
extension CheckoutItemTableViewCell : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func setupCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collectionView.collectionViewLayout = layout
        collectionView.isScrollEnabled = false
        
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: self.collectionView.frame.size.width , height: 20)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return choices.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CheckoutItemChoiceCollectionViewCell", for: indexPath) as! CheckoutItemChoiceCollectionViewCell
        if  self.choices.count > 0{
            cell.configureCell(self.choices[indexPath.row],quantity: choiceCount)
        }
        cell.layoutIfNeeded()
        return cell
    }
    //1
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: self.collectionView.width , height: 20)
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.layoutSubviews()
    }
}
