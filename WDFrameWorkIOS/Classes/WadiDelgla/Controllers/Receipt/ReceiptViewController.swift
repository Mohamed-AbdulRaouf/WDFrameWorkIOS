//
//  ReceiptViewController.swift
//  STDobites
//
//  Created by SimpleTouch on 11/14/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import UIKit
import Kingfisher
class ReceiptViewController: STUIViewController,IBaseController {
    
    // MARK: - Properties
    typealias T = IReceiptViewModel
    var viewModel: IReceiptViewModel?
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableHeight: NSLayoutConstraint!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var brandNameLabel: UILabel!
    @IBOutlet weak var brandLogoImageView: UIImageView!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        //bind UI
        self.setupUI()
        self.bindingData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel?.getOrderDetails()
        if let _ = self.viewModel?.isFromCart{
            self.navigationItem.setHidesBackButton(true, animated:true);
        }else{
            self.doneButton.isHidden = true
        }
    }
    override func viewWillLayoutSubviews() {
        super.updateViewConstraints()
        self.tableHeight?.constant = self.tableView.contentSize.height
    }
    
    // MARK: - IBActions
    @IBAction func onDoneTapped(_ sender: Any) {
        let vc = StoryboardScene.Main.tabBarViewController.instantiate()
        UIApplication.shared.keyWindow?.rootViewController = vc
    }
}

// MARK: - Internal
extension ReceiptViewController{
    func setupUI(){
        self.viewModel?.delegate = self
        self.setupTableView()
        self.doneButton.layer.cornerRadius = 16
        self.navigationItem.title = R.string.localizable.order_details()
        self.doneButton.setTitle(R.string.localizable.done(), for: .normal)
    }
    func bindingData() {}
}

// MARK: -Table Data Source
extension ReceiptViewController: UITableViewDelegate,UITableViewDataSource,IBaseTableView{
    func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 60.0
//        tableView.rowHeight = UITableView.automaticDimension
//        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.estimatedSectionHeaderHeight = 60.0
        self.tableView.isScrollEnabled = false
        let nib = UINib(nibName: "ReceiptMainHeaderView", bundle: Bundle.main)
        tableView.register(nib, forHeaderFooterViewReuseIdentifier: "ReceiptMainHeaderView")
        let nibFooter = UINib(nibName: "ReceiptCashDetailsFooter", bundle: Bundle.main)
        tableView.register(nibFooter, forHeaderFooterViewReuseIdentifier: "ReceiptCashDetailsFooter")
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60 //UITableView.automaticDimension
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        guard  (self.viewModel?.order != nil) else { return 0 }
        guard let items = self.viewModel?.order?.orderItems , items.value?.count ?? 0 > 0 else {return 0}
        return items.value!.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard (self.viewModel?.order != nil) else { return 0 }
        guard let items = self.viewModel?.order?.orderItems , items.value?.count ?? 0 > 0 else {return 0}
        return items.value?[section].itemChoices.value?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemChoiceTableViewCell", for: indexPath) as! ItemChoiceTableViewCell
        if let model = self.viewModel?.order?.orderItems.value, let choice = model[indexPath.section].itemChoices.value{
            cell.configureCell(choice[indexPath.row])
        }
        return cell
    }
}

// MARK: - Table Header & Foooter
extension ReceiptViewController {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60 //UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "ReceiptMainHeaderView") as! ReceiptMainHeaderView
        guard let order = self.viewModel?.order?.orderItems.value else { return UIView()}
        header.configureCell(order[section])
        return header
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        guard section == (self.viewModel?.order?.orderItems.value?.count ?? 0) - 1 else { return 0}
        return 150
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard section == (self.viewModel?.order?.orderItems.value?.count ?? 0) - 1 else { return UIView()}
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "ReceiptCashDetailsFooter") as! ReceiptCashDetailsFooter
        guard let order = self.viewModel?.order?.orderDetails.value else { return UIView()}
        header.configureCell(order)
        return header
    }
}

// MARK: - IReceiptViewController Protocol
extension ReceiptViewController : IReceiptViewController{
    func onReloadTableView() {
        self.tableView.reloadData()
    }
    func onReloadView(){
        if let imageUrl = URL(string: self.viewModel?.order?.orderDetails.value?.brandLogo.value ?? ""){
            let resource = ImageResource(downloadURL: imageUrl, cacheKey: self.viewModel?.order?.orderDetails.value?.brandLogo.value)
            self.brandLogoImageView.kf.setImage(with: resource)
        } else {
            self.brandLogoImageView.image = UIImage(named: "dobites_splash")
        }
        self.brandNameLabel.text = self.viewModel?.order?.orderDetails.value?.brandName.value ?? ""
        self.headerLabel.text = R.string.localizable.my_items()
        self.onReloadTableView()
    }
}
