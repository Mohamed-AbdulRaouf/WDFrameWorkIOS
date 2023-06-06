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
    @IBOutlet weak var backgroundAdsImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    var cartCountLbl: UILabel = {
        let label = UILabel(frame: CGRect(x: 3, y: -5, width: 25, height: 20))
        label.text = "\(UserDefaults.order?.cartItems.count ?? 0)"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .center
        label.textColor = .black
        label.backgroundColor =  .STYellow
        label.layer.cornerRadius = 8
        label.layer.masksToBounds = true
        return label
    }()
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBarItems()
        //bind UI
        self.setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if LocalizationSystem().isCurrentLanguageArabic() {
            self.title = "القائمه"
        } else {
            self.title = "Menu"
        }
        self.setCountOfCartToLbl()
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
        let button =  UIButton(type: .custom)
        button.setImage(R.image.ic_cart(), for: .normal)
        button.addTarget(self, action: #selector(openCartVC), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 53, height: 31)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)//move image to the right
        button.addSubview(self.cartCountLbl)
        let barButton = UIBarButtonItem(customView: button)
        let backToMainApp = UIBarButtonItem(image: UIImage(named: "exit-to-app"), style: .plain, target: self, action: #selector(backToMainApp))
        self.navigationItem.rightBarButtonItems = [barButton, backToMainApp]
        self.navigationItem.backBarButtonItem?.tintColor = .black
    }
    
    @objc func backToMainApp() {
        doPostNotification("exit_wdframework")
    }
    
    @objc func openCartVC() {
        let vc = StoryboardScene.Order.STCartViewController.instantiate()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func bindingData() {}

}
