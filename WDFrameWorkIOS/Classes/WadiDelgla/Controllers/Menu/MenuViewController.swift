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

        //bind UI
        self.setupUI()
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
    func bindingData() {}

}
