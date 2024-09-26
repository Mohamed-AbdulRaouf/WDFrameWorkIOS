//
//  BrandInfoViewController.swift
//  STDobites
//
//  Created by Nermeen Mohamed on 11/4/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import UIKit
import Bond
class BrandInfoViewController: STUIViewController ,IBaseController{
    
    // MARK: - Properties
    typealias T = IBrandInfoViewModel
    var viewModel: IBrandInfoViewModel?
    var numberOfRows = 0
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var menuButton: UIButton!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        //bind UI
        self.setupUI()
        self.bindingData()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.setupNavigationBar()
        //initialize data
        self.viewModel?.viewDidLoad()
    }
    @IBAction func onViewMenuTapped(_ sender: Any) {
        let vc = StoryboardScene.Menu.menuViewController.instantiate()
        K.shared.SELECTED_BRAND = self.viewModel?.brand
        self.navigationController?.pushViewController(vc)
    }
    
    // MARK: - Functions
    @objc func onNotificationTapped(){
        let vc = StoryboardScene.Features.notificationListViewController.instantiate()
        vc.viewModel?.requestDTO?.brandId.value = self.viewModel?.brandId
        self.navigationController?.pushViewController(vc)
    }
}

// MARK: - Internal
extension BrandInfoViewController{
    func setupUI(){
        self.viewModel?.delegate = self
        self.navigationItem.title = self.viewModel?.brand?.brandName.value ?? ""
        self.menuButton.setTitle(R.string.localizable.view_our_menu(), for: .normal)
        setupTableView()
    }
    func bindingData() {}
    func setupNavigationBar(){
        let notificationButton = UIBarButtonItem(image: R.image.notification(), style: .plain, target: self, action: #selector(onNotificationTapped))
        self.navigationItem.rightBarButtonItem = notificationButton
    }
}

// MARK: - Table Data Source
extension BrandInfoViewController: UITableViewDelegate,UITableViewDataSource,IBaseTableView{
    func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 60.0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 200
        }else if indexPath.row == 1{
            return self.viewModel?.brand?.contractTypeId.value == ContractType.loyality.contractTypeId ? 145 : 0
        }
        else {
            return 200
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "BrandHeaderInfoTableViewCell", for: indexPath) as! BrandHeaderInfoTableViewCell
            
            guard let brand = self.viewModel?.brand else {return cell}
            cell.configureCell(brand)
            cell.onTappedShare = {
                self.onShareButtonTapped()
            }
            cell.onTappedDirection = {
                self.onDirectionTapped()
            }
            return cell
        }else if indexPath.row == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "BrandRewardInfoTableViewCell", for: indexPath) as! BrandRewardInfoTableViewCell
            cell.onLoginTap = {
                self.openLogin()
            }
            guard let brand = self.viewModel?.brand else {return cell}
            cell.configureCell(brand)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "BrandDeliveryInfoTableViewCell", for: indexPath) as! BrandDeliveryInfoTableViewCell
            
            guard let brand = self.viewModel?.brand else {return cell}
            cell.configureCell(brand)
            
            cell.call = {
                guard let number = URL(string: "tel://" + (brand.callCenterNumber.value ?? "")) else { return }
                UIApplication.shared.open(number)
            }
            return cell
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel?.brand?.brandId.value == nil ? 0 : 3
    }
    
}

// MARK: - IBrandInfoViewController Protocol
extension BrandInfoViewController : IBrandInfoViewController{
    
    func onReloadTableView() {
        self.tableView.reloadData()
    }
    func onSuccessLoadBrandInfo() {
        self.tableView.reloadData()
    }
    func onShareButtonTapped() {
        let items = [viewModel?.shareUrlMessage ?? "", URL(string: viewModel?.brand?.shareUrl.value ?? "")!] as [Any]
        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
        ac.excludedActivityTypes = [.markupAsPDF, .openInIBooks, .saveToCameraRoll, .airDrop,
                                    .addToReadingList, .assignToContact , .print,
                                    UIActivity.ActivityType(rawValue: "com.apple.reminders.RemindersEditorExtension"),
                                    UIActivity.ActivityType(rawValue: "com.apple.mobilenotes.SharingExtension")]
        present(ac, animated: true)
    }
    func onDirectionTapped() {
        let vc = StoryboardScene.Location.nearResturantsLocationsViewController.instantiate()
        vc.viewModel?.brandId = self.viewModel?.brand?.brandId.value ?? 0
        self.navigationController?.pushViewController(vc)
        
    }
    func openLogin(){
        let vc = StoryboardScene.User.loginViewController.instantiate()
        vc.delegate = self
        self.present(vc, animated: true, completion: nil)
        
    }
    func openNotificationList() {
        let vc = StoryboardScene.Features.notificationListViewController.instantiate()
        vc.viewModel?.requestDTO?.brandId.value = self.viewModel?.brand?.brandId.value
        self.navigationController?.pushViewController(vc)
        
    }
}

// MARK: - LoginProtocol
extension BrandInfoViewController : LoginProtocol{
    func onUserLogedIn() {
        if let _ = UserDefaults.user{
            self.bindingData()
        }
    }
}
