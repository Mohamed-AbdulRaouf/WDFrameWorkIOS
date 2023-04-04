//
//  MoreViewController.swift
//  STDobites
//
//  Created by Nermeen Mohamed on 10/28/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import UIKit
//import DAL

class MoreViewController: STUIViewController,IBaseController {
    
    // MARK: - Properties
    typealias T = IMoreViewModel
    var viewModel: IMoreViewModel?
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //bind UI
        self.view.backgroundColor = .red
        self.setupUI()
        self.bindingData()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel?.viewDidload()
        self.navigationController?.navigationBar.topItem?.title = R.string.localizable.more()
    }
    
    // MARK: - Functions
    func showReferralCode(){
        let dialog = UIAlertController(title: R.string.localizable.referral_code_title(), message:  R.string.localizable.referral_code_message(), preferredStyle: .alert)
        
        //adding textfields to our dialog box
        dialog.addTextField { (textField) in
            textField.placeholder = R.string.localizable.referral_code()
            textField.textAlignment = .center
        }
        
        //the confirm action taking the inputs
        let confirmAction = UIAlertAction(title: R.string.localizable.apply(), style: .default) { (alert)  in
            //getting the input values from user
            let code = dialog.textFields?[0].text ?? ""
            //viewModel?.referralCode(code)
            self.viewModel?.registerToBrand(code)
            
        }
        let cancelAction = UIAlertAction(title: R.string.localizable.cancel(), style: .cancel) { (_) in }
        dialog.addAction(confirmAction)
        dialog.addAction(cancelAction)
        //finally presenting the dialog box
        self.present(dialog, animated: true, completion: nil)
    }
    
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        return self//or use return self.navigationController for fetching app navigation bar colour
    }
}
// MARK: - Internal
extension MoreViewController{
    func setupUI(){
        self.setViewModelDelegates()
        self.setupTableView()
    }
    func bindingData() {}
}

// MARK: - Table Data Source
extension MoreViewController: UITableViewDelegate,UITableViewDataSource,IBaseTableView{
    func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.moreItems?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MoreTableViewCell", for: indexPath) as! MoreTableViewCell
        
        if let moreItems = viewModel?.moreItems {
            cell.configureCell(moreItems[indexPath.row])
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.didSelectItem(indexPath.row)
    }
}

// MARK: - LoginProtocol
extension MoreViewController : LoginProtocol{
    func onUserLogedIn() {
        if let _ = UserDefaults.user{
            self.bindingData()
            tabBarController?.selectedIndex = 0
        }
    }
}

// MARK: - IMoreProtocol,UIDocumentInteractionControllerDelegate
extension MoreViewController: IMoreProtocol,UIDocumentInteractionControllerDelegate{
    func openLogin() {
        let vc = StoryboardScene.User.loginViewController.instantiate()
        vc.delegate = self
        self.present(vc, animated: true, completion: nil)
    }
    func openReferralCode() {
        self.showReferralCode()
    }
    func openLocation() {
        let vc = StoryboardScene.Location.locationViewController.instantiate()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func onReloadTable() {
        self.tableView.reloadData()
    }
    func onSuccessRegisterToBrand() {
        self.showToast(R.string.localizable.success_register_to_brand())
        doOnMain(deadline: 1.0, {
            self.dismiss(animated: true, completion: nil)
        })
    }
    func setViewModelDelegates() {
        self.viewModel?.delegate = self
    }
    func openOrderList() {
        let vc = StoryboardScene.User.orderListViewController.instantiate()
        self.navigationController?.pushViewController(vc)
    }
    func openAboutDoBites() {
        let path =  Bundle.main.path(forResource: R.string.localizable.dobites_pdf(), ofType: ".pdf")!
        let dc = UIDocumentInteractionController(url: URL(fileURLWithPath: path))
        dc.delegate = self
        dc.presentPreview(animated: true)
    }
    func openBarCode() {
        let vc = StoryboardScene.Features.barCodeViewController.instantiate()
        self.navigationController?.pushViewController(vc)
        
    }
    func openBrand(){
        let vc = StoryboardScene.Brand.brandInfoViewController.instantiate()
        self.navigationController?.pushViewController(vc)
    }
    func onShowClearCartByChangingLanguage() {
        let alertVC = UIAlertController(title: "", message: R.string.localizable.clear_cart_due_to_change_language(), preferredStyle: .actionSheet)
        let clearAction = UIAlertAction(title: R.string.localizable.clear_cart(), style: .destructive) { (pressed) in
            self.viewModel?.cartService?.deleteCart(completion: { (success) in
                if success{
                    changeLanguage()
                }
            })
        }
        let cancelAction = UIAlertAction(title: R.string.localizable.cancel(), style: .cancel, handler: nil)
        alertVC.addAction(clearAction)
        alertVC.addAction(cancelAction)
        present(alertVC, animated: true, completion: nil)
    }
    func openExplore() {
        self.tabBarController?.selectedIndex = 1
    }
    func openCountryList() {
        let vc = StoryboardScene.Features.countryListViewController.instantiate()
        vc.viewModel?.sourceDelegate = self
        vc.viewModel?.brandId = Config.BRAND_ID
       present(vc, animated: true, completion: nil)

    }
    func onShowClearCartAlert(messageText: String, actionButtonText : String, actionButtonClosure: @escaping () -> Void) {
        let alertVC = UIAlertController(title: "", message: messageText, preferredStyle: .actionSheet)
               let clearAction = UIAlertAction(title: actionButtonText, style: .destructive) { (pressed) in
                  actionButtonClosure()
               }
               let cancelAction = UIAlertAction(title: R.string.localizable.cancel(), style: .cancel, handler: nil)
               alertVC.addAction(clearAction)
               alertVC.addAction(cancelAction)
               present(alertVC, animated: true, completion: nil)
    }
}
extension MoreViewController : CountrySelectorDelegate {
    func selectCountry(country: ICountryDTODAL) {
        print("OLd Country = \(String(describing: UserDefaults.currentAppCountry?.countryCode.value ?? ""))")
        self.viewModel?.validateOnCartHasItemsForCountry(country: country)
    }
}
