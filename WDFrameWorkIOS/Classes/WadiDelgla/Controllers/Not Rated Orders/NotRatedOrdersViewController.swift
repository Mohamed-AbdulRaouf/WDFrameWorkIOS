//
//  NotRatedOrdersViewController.swift
//  STDobites
//
//  Created by SimpleTouch on 11/27/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import UIKit
//import DAL
class NotRatedOrdersViewController: STUIViewController,IBaseController {
    
    // MARK: - Properties
    typealias T = INotRatedOrderViewModel
    var viewModel: INotRatedOrderViewModel?
    var onRateOrderTapped: ((IOrderDTODAL) -> Void)?

    // MARK: - IBOutlets
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var notRatedOrderMessageLabel: UILabel!
    @IBOutlet weak var notRateOrderTitleLabel: UILabel!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        //bind UI
        self.setupUI()
    }
   
    // MARK: - IBActions
    @IBAction func onCancelTapped(_ sender: Any) {
         self.dismiss(animated: true, completion: nil)
    }
    func showRate(){}
    func showMessage(_ message: String) {
//        self.showMessage(withTitle:"", andMessage: message)
    }

}

// MARK: - Internal
extension NotRatedOrdersViewController{
    func setupUI(){
        setupTableView()
    }
    func bindingData() {}
}

// MARK: - Table Data Source
extension NotRatedOrdersViewController : UITableViewDelegate,UITableViewDataSource {
    func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.separatorStyle = .none
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotRatedOrderTableViewCell", for: indexPath) as! NotRatedOrderTableViewCell
        if let orders = self.viewModel?.orderList, let items = orders.items.value {
            cell.configureCell(items[indexPath.row])
            cell.onRateTapped = { [weak self] in
                self?.onRateOrderTapped!(items[indexPath.row])
                 self?.dismiss(animated: true, completion: nil)
            }
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel?.orderList?.items.value?.count ?? 0
    }
}
