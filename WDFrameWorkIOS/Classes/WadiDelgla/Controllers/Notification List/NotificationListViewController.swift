//
//  NotificationListViewController.swift
//  STDobites
//
//  Created by Nermeen Mohamed on 11/2/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import UIKit

class NotificationListViewController: STUIViewController,IBaseController {
    
    // MARK: - Properties
    typealias T = INotificationListViewModel
    var viewModel: INotificationListViewModel?
    
    // MARK: - IBOutlets
    @IBOutlet weak var notificationEmptyStackView: UIStackView!
    @IBOutlet weak var noNotificationLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        //bind UI
        self.setupUI()
        self.bindingData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //initialize data
        viewModel?.viewDidLoad()
    }
}

// MARK: - Internal
extension NotificationListViewController{
    func setupUI(){
        self.viewModel?.delegate = self
        self.noNotificationLabel.text = R.string.localizable.no_notification()
        self.setupTableView()
        self.navigationItem.title = R.string.localizable.notifications()
    }
    func bindingData() {}
}
// MARK: - Table Data Source
extension NotificationListViewController: UITableViewDelegate,UITableViewDataSource,IBaseTableView{
    func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.notifications?.count ?? 0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let brandId = self.viewModel?.requestDTO?.brandId.value,brandId == 0  {
            if let notification = self.viewModel?.notifications?[indexPath.row] {
                self.viewModel?.readNotification(notification.id.value ?? "", completion: { (success) in
                    if success {
                        self.openBrandInfo(notification.brandId.value ?? "0")
                    }
                })
            }
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationTableViewCell", for: indexPath) as! NotificationTableViewCell
        
        if let items = self.viewModel?.notifications {
            cell.configureCell(items[indexPath.row])
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
         guard let brandId = self.viewModel?.requestDTO?.brandId.value,brandId != 0 else {
            return self.handleSwip(title: R.string.localizable.read(), handler: {_,_,_ in
                self.viewModel?.readNotification(self.viewModel?.notifications?[indexPath.row].id.value ?? "", completion: { _ in })
           })
        }
        return self.handleSwip(title: R.string.localizable.delete(), handler: {_,_,_ in
            self.viewModel?.removeNotification(self.viewModel?.notifications?[indexPath.row].id.value ?? "")
        })
    }
    func handleSwip(title: String,handler: @escaping UIContextualAction.Handler) -> UISwipeActionsConfiguration?{
        let contextItem = UIContextualAction(style: .destructive, title: title, handler: handler)
        let swipeActions = UISwipeActionsConfiguration(actions: [contextItem])
        return swipeActions
    }
    
    
  
}

// MARK: - INotificationListViewController Protocol
extension NotificationListViewController: INotificationListViewController{
    
    func onReloadTableView() {
        self.notificationEmptyStackView.isHidden = self.viewModel?.notifications?.count != 0
        self.tableView.reloadData()
    }
    func openBrandInfo(_ brandId: String){
        let vc = StoryboardScene.Brand.brandInfoViewController.instantiate()
        vc.viewModel?.brandId = Int(brandId)
        self.navigationController?.pushViewController(vc)
    }
}
