//
//  RateOrderViewController.swift
//  STDobites
//
//  Created by SimpleTouch on 11/27/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import UIKit

class RateOrderViewController: STUIViewController,IBaseController {
    
    // MARK: - Properties
    typealias T = IRateOrderViewModel
    var viewModel: IRateOrderViewModel?

    // MARK: - IBOutlets
    @IBOutlet weak var rateTitleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        //bind UI
        self.setupUI()
        self.viewModel?.getRateOrder()
    }
}

// MARK: - Internal
extension RateOrderViewController{
    func setupUI(){
        self.setupTableView()
        self.viewModel?.delegate = self
        self.rateTitleLabel.text = R.string.localizable.rate_desc()
        self.rateTitleLabel.font = UIFont(resource: APP_FONT_BOLD, size: 17)
        self.rateTitleLabel.textColor = COLOR_PRIMARY_TEXT
    }
    func bindingData() {}
}

// MARK: - IRateOrderViewController Protocol
extension RateOrderViewController : IRateOrderViewController{
    func onReloadTableView() {
        self.navigationController?.navigationBar.topItem?.title = self.viewModel?.order?.brandName.value ?? ""
        self.tableView.reloadData()
    }
    func onDismissViewController() {
        self.navigationController?.popViewController(animated: true)
    }
}
