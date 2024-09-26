//
//  UserAddressListViewController.swift
//  STDobites
//
//  Created by Nermeen Mohamed on 11/3/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import UIKit

class UserAddressListViewController: STUIViewController,IBaseController {

    @IBOutlet weak var addNewAddressButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    typealias T = IUserAddressListViewModel
    var viewModel: IUserAddressListViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupUI()
        self.bindingData()
        self.navigationItem.title = R.string.localizable.my_addresses()

    }
    func setupUI(){
        self.viewModel?.delegate = self
        self.setupTableView()
        self.navigationItem.title = R.string.localizable.my_orders()
        self.addNewAddressButton.setTitle(R.string.localizable.add_new_Address(), for: .normal)
        [addNewAddressButton].forEach { (button) in
            button?.layer.cornerRadius = 18.2
            button?.layer.borderWidth = 1
            button?.layer.borderColor = UIColor.lightGray.cgColor
            button?.layer.shadowColor = UIColor.lightGray.cgColor
            button?.layer.shadowOffset = CGSize(width: 0, height: 1.0)
            button?.layer.shadowRadius = 2
            button?.layer.masksToBounds = false
            button?.layer.shadowOpacity = 1.0
            // set backgroundColor in order to cover the shadow inside the bounds
            button?.layer.backgroundColor = UIColor.white.cgColor
         }
    }
    func bindingData() {
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.viewDidLoad()
    }
    @IBAction func onNewAddressTapped(_ sender: Any) {
         self.openAddressOptionsVC()
    }
   
 
}
//MARK: - Functions
extension UserAddressListViewController {
    func openNewAddressVC(){
        let vc = StoryboardScene.User.addNewUserAddressViewController.instantiate()
        vc.viewModel?.isFromCart = self.viewModel?.sourceDelegate != nil
        vc.viewModel?.address_data?.cityId.value = Int(UserDefaults.currentCity?.id.value?.description ?? "0")
        vc.viewModel?.address_data?.areaId.value = Int(UserDefaults.currentArea?.id.value?.description ?? "0")
        vc.viewModel?.address_data?.brandId.value = Config.BRAND_ID
        self.navigationController?.pushViewController(vc)
        
        
    }
    func openAddressOptionsVC(){
        let vc = StoryboardScene.User.addNewAddressOptionsViewController.instantiate()
        vc.openAddNewAddress = { [weak self] in
            self?.openNewAddressVC()
        }
        vc.openMap = { [weak self] in
            self?.openLocationPickerVC()
        }
        
        self.navigationController?.pushViewController(vc)
    }
    
    func openLocationPickerVC() {
        let vc = StoryboardScene.User.locationPickerViewController.instantiate()
        vc.mapAddress = { [weak self]  address in
            print(address)
            
            let vc = StoryboardScene.User.addNewUserAddressViewController.instantiate()
            vc.viewModel?.isFromCart = self?.viewModel?.sourceDelegate != nil
            vc.viewModel?.address_data = address
            self?.navigationController?.pushViewController(vc)
        }
        vc.selectAddressManually = { [weak self] in
            self?.openNewAddressVC()
        }
        self.navigationController?.pushViewController(vc)
        
    }
}

extension UserAddressListViewController: UITableViewDelegate,UITableViewDataSource,IBaseTableView{
    func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 60.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.addresses?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserAddressTableViewCell", for: indexPath) as! UserAddressTableViewCell
        if let addresses = viewModel?.addresses,indexPath.row < addresses.count {
            addresses[indexPath.row].addressIndex.value = indexPath.row + 1
            cell.configureCell(addresses[indexPath.row])
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let addressList = self.viewModel?.addresses, addressList.count > 0 else {return}
        guard let _ = self.viewModel?.sourceDelegate else {
            let vc = StoryboardScene.User.addNewUserAddressViewController.instantiate()
            vc.viewModel?.address_data = self.viewModel?.addresses?[indexPath.row]
            self.navigationController?.pushViewController(vc)
            return
        }
        if indexPath.row <= addressList.count - 1{
            self.navigationController?.popViewController(animated: true, {
                self.viewModel?.sourceDelegate?.didSelectAddress((addressList[indexPath.row]))
            })
        }
       
    }
}
extension UserAddressListViewController: IUserAddressListViewController{
   
    func onReloadTableView() {
        if self.viewModel?.addresses?.count ?? 0 > 0 {
            if let address = self.viewModel?.addresses?.first {
            self.navigationController?.popViewController(animated: false, {
                    self.viewModel?.sourceDelegate?.didSelectAddress(address)
                })
            }
        } else {
            self.tableView.reloadData()
        }
    }
    
    func addNewAddress() {
        let vc = StoryboardScene.User.addNewUserAddressViewController.instantiate()
        self.navigationController?.pushViewController(vc)
    }
}
