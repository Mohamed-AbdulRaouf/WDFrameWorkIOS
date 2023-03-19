//
//  MenuViewController.swift
//  STDobites
//
//  Created by SimpleTouch on 11/13/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import UIKit
class MenuViewController: STUIViewController,IBaseController {

    // MARK: - Properties
    typealias T = IMenuViewModel
    var viewModel: IMenuViewModel?

    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Menu"
        setupNavigationBarItems()
        //bind UI
        self.setupUI()
//        self.setupNavigationBarItems()
    }
}

// MARK: - Internal
extension MenuViewController{
    func setupUI(){
        self.viewModel?.delegate = self
        self.viewModel?.viewDidLoad()
        self.setupTableView()
        self.setupCollectionView()
        self.viewModel?.getCategoryList()
    }
    
    func setupNavigationBarItems() {
//        self.navigationController?.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "cart.png"), style: .plain, target: self, action: #selector(openCartVC))
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(openCartVC))
        
        let cartBtn =   UIBarButtonItem(image: R.image.ic_cart(), style: .plain, target: self, action: #selector(openCartVC))
        cartBtn.tintColor = .black
        self.navigationItem.rightBarButtonItems = [cartBtn]
        self.navigationItem.backBarButtonItem?.tintColor = .black
    }
    
    @objc func openCartVC() {
        let vc = StoryboardScene.Order.STCartViewController.instantiate()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func bindingData() {}

}
