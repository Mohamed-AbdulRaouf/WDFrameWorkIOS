//
//  OrderListViewController.swift
//  STDobites
//
//  Created by Nermeen Mohamed on 10/31/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import UIKit

 
class OrderListViewController: STUIViewController,IBaseController {
    
    var viewModel: IOrderListViewModel?
    typealias T = IOrderListViewModel
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupUI()
        self.bindingData()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    func setupUI(){
        self.viewModel?.delegate = self
        self.setupTableView()
        self.navigationItem.title = R.string.localizable.my_orders()
    }
    func bindingData() {
         
    }
 
}

extension OrderListViewController: UITableViewDelegate,UITableViewDataSource,IBaseTableView{
    func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 60.0
//        tableView.rowHeight = UITableView.automaticDimension
    }
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel?.order?.items.value?.count ?? 0 == 0 {
                   self.tableView.setEmptyMessage( R.string.localizable.no_orders())
           
               } else {
                   self.tableView.restore()
               }
        return viewModel?.order?.items.value?.count ?? 0
    }
    
   

    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderTableViewCell", for: indexPath) as! OrderTableViewCell
       
        
        if indexPath.row == (self.viewModel?.order?.items.value?.count ?? 0)! - 1 {
            if (self.viewModel?.order?.totalCount.value ?? 0)! > (self.viewModel?.order?.items.value?.count ?? 0)! {
                self.viewModel?.getOrders()
            }
        }
        if let items = self.viewModel?.order?.items.value {
            cell.configureCell(items[indexPath.row])
            cell.onRateTapped = { [weak self] in
                let vc = StoryboardScene.Order.rateOrderViewController.instantiate()
                vc.viewModel?.customerHistoryId = items[indexPath.row].customerHistoryId.value ?? 0
                self?.navigationController?.pushViewController(vc)
            }
        }
     
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard self.viewModel?.order?.items.value?[indexPath.row].isOrderHasDetails.value ?? false else { return }
        let vc = StoryboardScene.Order.receiptViewController.instantiate()
        vc.viewModel?.customerHistoryId = self.viewModel?.order?.items.value?[indexPath.row].customerHistoryId.value ?? 0
        self.navigationController?.pushViewController(vc)
    }
}

extension OrderListViewController: IOrderListViewController{
  
    
    func onReloadTableView() {
      //  self.tableView.separatorStyle = .singleLine
        self.tableView.reloadData()
    }
}
