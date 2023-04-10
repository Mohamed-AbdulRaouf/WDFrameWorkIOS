//
//  OrderTypeViewController.swift
//  SimpleTouch
//
//  Created by SimpleTouch on 9/28/20.
//  Copyright © 2020 SimpleTouch. All rights reserved.
//

import UIKit

class OrderTypeViewController: STUIViewController ,IBaseController{
    
    typealias T = IOrderTypeViewModel
    var viewModel: IOrderTypeViewModel?

    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupUI()
       
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         self.viewModel?.viewDidLoad()
    }

}
// MARK: - Internal
extension OrderTypeViewController {
    func setupUI(){
        self.viewModel?.delegate = self
        self.setupCollectionView()
        self.headerLabel.text = "order_type_choices".localized()
        self.headerLabel.textColor = COLOR_PRIMARY_TEXT

       
    }
    func bindingData() {}
      
}

extension OrderTypeViewController : IOrderTypeViewController{
    
    func onReloadCollectionView() {
        self.collectionView.reloadData()
    }
}
