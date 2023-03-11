//
//  CategoryCollectionViewCell.swift
//  DoBites
//
//  Created by SimpleTouch on 8/29/19.
//  Copyright © 2019 Nermeen Mohdamed. All rights reserved.
//

import UIKit
//import DAL
class CategoryCollectionViewCell: UICollectionViewCell ,IBaseCollectionCell{
    typealias T = ICategoryMenuItemsDTODAL

    
    @IBOutlet weak var indicatorView: UIView!
    @IBOutlet weak var categoryNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        categoryNameLabel.alpha = 0.6
        self.indicatorView.alpha = 0.0
    }
    func configureCell(_ model: ICategoryMenuItemsDTODAL) {
        self.categoryNameLabel.text = model.categoryName.value ?? ""

    }
   
    override var isSelected: Bool {
        didSet{
            categoryNameLabel.alpha = isSelected ? 1.0 : 0.6
            self.indicatorView.alpha = isSelected ? 1.0 : 0.0
        }
    }
    
    
}
