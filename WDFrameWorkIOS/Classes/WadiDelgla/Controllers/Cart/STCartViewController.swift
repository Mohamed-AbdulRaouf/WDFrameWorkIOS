//
//  STCartViewController.swift
//  STDobites
//
//  Created by SimpleTouch on 11/14/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import UIKit
import ReactiveKit

class STCartViewController: STUIViewController ,IBaseController{
    
    // MARK: - Properties
    typealias T = ISTCartViewModel
    var viewModel: ISTCartViewModel?
    
    // MARK: - IBOutlets
    @IBOutlet weak var addItemButton: UIButton!
    @IBOutlet weak var emptyCartView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyCartMessageLabel: UILabel!
    @IBOutlet weak var emptyCartLabel: UILabel!
    @IBOutlet weak var checkoutButton: UIButton!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        //bind UI
        self.setupUI()
        if #available(iOS 16.0, *) {
            addobserverToNotification(#selector(userNotAllowedAccessLocation), name: NotificationName.userNotAllowAccessLocation.rawValue)
        } else {
            // Fallback on earlier versions
        }

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel?.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.setupNavigationBar()
    }
    
    // MARK: - IBActions
    @IBAction func onShoppingTapped(_ sender: Any) {
        TabsData.sharedInstance.searchTerm = ""
        TabsData.sharedInstance.isLoyality = false
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func onCheckoutTapped(_ sender: Any) {
        self.view.endEditing(true)
        self.viewModel?.validateUserLocationWithSelectedCountry()
//        self.viewModel?.validateCheckout()
    }
    @available(iOS 16.0, *)
    @objc func userNotAllowedAccessLocation(_ notification: Notification) {
      print("Location services are not enabled")
        createSettingsAlertController(title: K.shared.SELECTED_BRAND?.brandName.value ?? "", message: R.string.localizable.location_permission_denied())
      }
    deinit {
           removeNotificationObserver(NotificationName.userNotAllowAccessLocation.rawValue)
       }
}

// MARK: - Internal
extension STCartViewController{
    func setupUI(){
        self.viewModel?.delegate = self
        self.setupTableView()
        
        self.checkoutButton.setTitle(R.string.localizable.checkout(), for: .normal)
        self.emptyCartLabel.text = R.string.localizable.empty_cart()
        self.emptyCartLabel.textColor = COLOR_ACCENT
        self.emptyCartLabel.font = APP_FONT_BOLD //UIFont(resource: APP_FONT_BOLD, size: 20)
        self.emptyCartMessageLabel.text = R.string.localizable.empty_cart_message()
        self.emptyCartMessageLabel.textColor = COLOR_PRIMARY_TEXT
        self.emptyCartMessageLabel.font = APP_FONT_REGULAR16 //UIFont(resource: APP_FONT_REGULAR, size: 16)
        self.addItemButton.setTitle(R.string.localizable.add_item(), for: .normal)
        self.addItemButton.titleLabel?.font = FONT_PRIMARY_BUTTON
        self.addItemButton.setTitleColor(COLOR_BUTTON_TEXT, for: .normal)
        
    }
    func setupNavigationBar(){
        self.navigationController?.navigationBar.topItem?.title = R.string.localizable.cart()
        let iconImage:UIImage? = UIImage.getFontAwaseomImage(fontName: "fas fa-trash",imageSize: CGSize(width: 30, height: 30),.darkGray)
        let clearCart =   UIBarButtonItem(image: iconImage, style: .plain, target: self, action: #selector(onClearCartTapped))
        self.navigationItem.rightBarButtonItems = [clearCart]
    }
    func bindingData() {}
    
}

//MARK: -TableView Delegate ,data source
extension STCartViewController: UITableViewDelegate, UITableViewDataSource {
    func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
//        tableView.estimatedRowHeight = 60.0
//        tableView.rowHeight = UITableViewAutomaticDimension
#if swift(>=5.0)
print("Running Swift 5.0 or later")
        tableView.rowHeight = tableView.estimatedRowHeight
#else
print("Running old Swift")
        tableView.rowHeight = UITableViewAutomaticDimension
#endif
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // comment - footer
        guard let cartItems = self.viewModel?.cart?.cartItems,cartItems.count > 0 else {return 0}
        guard section != 0 else { return cartItems.count }
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CartFooterTableViewCell", for: indexPath) as! CartFooterTableViewCell
            if let calOrder = self.viewModel?.calcResponse{
                cell.configureCell(calOrder)
            }
            return cell
        }else if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "OrderCommentTableViewCell", for: indexPath) as! OrderCommentTableViewCell
            cell.configureCell(self.viewModel?.cart?.orderComment ?? "")
            cell.onChangeComment = { [weak self ] comment in
                self?.viewModel?.updateOrderComment(comment)
            }
            return cell
        } else if indexPath.section == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "OrderPhoneTableViewCell", for: indexPath) as! OrderPhoneTableViewCell
                cell.configureCell(self.viewModel?.cart?.phone2 ?? "")
                cell.onChangePhone = { [weak self ] phone in
                    self?.viewModel?.cart?.phone2 = phone
                }
                return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "CartItemTableViewCell", for: indexPath) as! CartItemTableViewCell
            if let items = self.viewModel?.cart?.cartItems{
                cell.configureCell(items[indexPath.row])
                cell.delegate = self
            }
            return cell
        }
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.viewWillLayoutSubviews()
    }
    
}
