//
//  SortViewController.swift
//  STDobites
//
//  Created by SimpleTouch on 11/11/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import UIKit

class SortViewController: UIViewController,IBaseController {

    // MARK: - Properties
    typealias T = ISortViewModel
    var viewModel: ISortViewModel?
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        //bind UI
        setupUI()
    }
}
// MARK: - Internal
extension SortViewController{
    func setupUI(){
        self.setupTableView()
    }
    func bindingData() {}
}

// MARK: - Table Data Source
extension SortViewController: UITableViewDelegate,UITableViewDataSource,IBaseTableView{
    func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.model?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SortTableViewCell", for: indexPath) as! SortTableViewCell
        if let items = viewModel?.model{
            cell.configureCell(items[indexPath.row])
          }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let _ =  self.viewModel?.delegate {
            self.viewModel?.delegate?.selectSortItem(indexPath.row)
            self.navigationController?.popViewController(animated: true)
        }
    }
}
