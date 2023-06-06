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
    @IBOutlet weak var checkoutIconImageView: UIImageView!
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
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        view.addGestureRecognizer(tap)
        view.isUserInteractionEnabled = true
//        self.view.addSubview(view)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel?.viewDidLoad()
        if LocalizationSystem().isCurrentLanguageArabic() {
            self.title = "السله"
        } else {
            self.title = "My Cart"
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.setupNavigationBar()
    }
    
    // MARK: - IBActions
    // function which is triggered when handleTap is called
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    @IBAction func onShoppingTapped(_ sender: Any) {
        TabsData.sharedInstance.searchTerm = ""
        TabsData.sharedInstance.isLoyality = false
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func onCheckoutTapped(_ sender: Any) {
        self.view.endEditing(true)
//        self.viewModel?.validateUserLocationWithSelectedCountry()
        self.viewModel?.validateCheckout()
    }
    @available(iOS 16.0, *)
    @objc func userNotAllowedAccessLocation(_ notification: Notification) {
      print("Location services are not enabled")
        createSettingsAlertController(title: K.shared.SELECTED_BRAND?.brandName.value ?? "", message: "location_permission_denied".localized())
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
        
        self.checkoutButton.setTitle("checkout".localized(), for: .normal)
        self.emptyCartLabel.text = "empty_cart".localized()
        self.emptyCartLabel.textColor = COLOR_ACCENT
        self.emptyCartLabel.font = APP_FONT_BOLD20 //UIFont(resource: APP_FONT_BOLD, size: 20)
        self.emptyCartMessageLabel.text = "empty_cart_message".localized()
        self.emptyCartMessageLabel.textColor = COLOR_PRIMARY_TEXT
        self.emptyCartMessageLabel.font = APP_FONT_REGULAR16 //UIFont(resource: APP_FONT_REGULAR, size: 16)
        self.addItemButton.setTitle("add_item".localized(), for: .normal)
        self.addItemButton.titleLabel?.font = FONT_PRIMARY_BUTTON
        self.addItemButton.setTitleColor(COLOR_BUTTON_TEXT, for: .normal)
        self.checkoutIconImageView.image = UIImage(named: "ic_check_out.png", in: .WDFrameworkBundle, with: nil)?.withRenderingMode(.alwaysTemplate)
        self.checkoutIconImageView.tintColor = .black
    }
    func setupNavigationBar(){
        let iconImage:UIImage? = UIImage.getFontAwaseomImage(fontName: "fas fa-trash",imageSize: CGSize(width: 30, height: 30),.darkGray)
        let clearCart =   UIBarButtonItem(image: iconImage, style: .plain, target: self, action: #selector(onClearCartTapped))
        let exitBtn = UIButton(type: .custom)
        exitBtn.setImage(UIImage(named: "exit-to-app"), for: .normal)
        exitBtn.addTarget(self, action: #selector(backToMainApp), for: .touchUpInside)
        exitBtn.frame = CGRect(x: 0, y: 0, width: 35, height: 31)
        exitBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        let exit = UIBarButtonItem(customView: exitBtn)
        self.navigationItem.rightBarButtonItems = [clearCart, exit]
    }
    
    @objc func backToMainApp() {
        doPostNotification("exit_wdframework")
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
                cell.configureCell(UserDefaults.orderPhone)
                cell.onChangePhone = { [weak self ] phone in
                    self?.viewModel?.cart?.phone2 = phone
                    UserDefaults.orderPhone = phone
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
