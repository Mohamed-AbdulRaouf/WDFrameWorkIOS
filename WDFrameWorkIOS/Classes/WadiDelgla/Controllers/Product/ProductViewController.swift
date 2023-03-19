//
//  ProductViewController.swift
//  STDobites
//
//  Created by SimpleTouch on 11/17/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import UIKit
class ProductViewController: STUIViewController,IBaseController{
    
    // MARK: - Properties
    typealias T = IProductViewModel
    var viewModel: IProductViewModel?
    
    // MARK: - IBOutlets
    @IBOutlet weak var addToCartButton: UIButton!
    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        //bind UI
        self.setupUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        self.viewModel?.viewDidLoad()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
   
    // MARK: - IBActions
    @IBAction func onAddToCartTapped(_ sender: Any) {
        self.viewModel?.addItemToCart()
    }
    @IBAction func onDismissTapped(_ sender: Any) {
        self.onDismissViewController()
    }
}

// MARK: - Internal
extension ProductViewController{
    func setupUI(){
        self.viewModel?.delegate = self
        self.setupTableView()
        self.addToCartButton.setTitleColor(COLOR_BUTTON_TEXT, for: .normal)
        self.addToCartButton.backgroundColor = COLOR_ACCENT
        self.addToCartButton.titleLabel?.font = APP_FONT_BOLD //UIFont(resource: APP_FONT_BOLD, size: 13)
        self.addToCartButton.setTitle(R.string.localizable.add_to_cart(), for: .normal)
        self.dismissButton.layer.cornerRadius = self.dismissButton.frame.height / 2
        self.dismissButton.setTitle("X", for: .normal)
        self.dismissButton.setTitleColor(.white, for: .normal)
        self.dismissButton.layer.borderWidth = 2
        self.dismissButton.layer.borderColor = COLOR_ACCENT.cgColor
        self.dismissButton.backgroundColor = COLOR_ACCENT
    }
    func bindingData() {}
}
