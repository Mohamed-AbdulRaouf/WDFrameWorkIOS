//
//  RankingViewController.swift
//  STDobites
//
//  Created by Nermeen Mohamed on 10/28/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import UIKit

class RankingViewController: STUIViewController ,IBaseController{
    
    // MARK: - Properties
    typealias T = IRankingViewModel
    var viewModel: IRankingViewModel?
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        //bind UI
        self.setupTableView()
        self.bindingData()
        self.navigationItem.title = R.string.localizable.topRanking()
 
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.getTopReferralsCustomers()
    }
    
}

// MARK: - Internal
extension RankingViewController{
    func bindingData() {
        if let viewModel = viewModel{
            viewModel.onReloadTable = {  [weak self]  in
                self?.tableView.reloadData()
            }
            viewModel.onError = { [weak self] error in
                self?.showMessage(andMessage: error)
            }
        }
    }
}

// MARK: - Table Data Source
extension RankingViewController: UITableViewDelegate,UITableViewDataSource,IBaseTableView{
    func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
     }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.rankingList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "RankingTableViewCell", for: indexPath) as! RankingTableViewCell
        if let rankings = viewModel?.rankingList {
            rankings[indexPath.row].index.value = indexPath.row + 1
            cell.configureCell(rankings[indexPath.row],totalReferral:viewModel?.totalValue ?? 0)
        }
        return cell
    }
}
