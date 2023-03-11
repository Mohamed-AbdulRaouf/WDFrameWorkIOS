//
//  FilterationViewController.swift
//  STDobites
//
//  Created by SimpleTouch on 11/11/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import UIKit

class FilterationViewController: UIViewController ,IBaseController{
    
    // MARK: - Properties
    typealias T = IFilterationViewModel
    var viewModel: IFilterationViewModel?
    
    // MARK: - IBOutlets
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var tableView: UITableView!

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        //bind UI
        self.setupUI()
    }
    
    // MARK: - IBActions
    @IBAction func onTappedDone(_ sender: Any) {
        self.viewModel?.setSelectedFacilitiesAndCuisies()
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - Internal
extension FilterationViewController{
    func setupUI(){
        self.viewModel?.viewDidLoad()
        self.setupTableView()
        self.doneButton.setTitle(R.string.localizable.done(), for: .normal)
    }
    
    func bindingData() {}
}

// MARK: - Table Data Source
extension FilterationViewController: UITableViewDelegate,UITableViewDataSource,IBaseTableView{
    func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel?.model?.count ?? 0
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60.0
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = Bundle.main.loadNibNamed("filterHeaderView", owner: self, options: nil)?.first as! filterHeaderView
        header.filterTitleLbl.text = self.viewModel?.model?[section].title.value
        return header
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.model?[section].items.value?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FilterTableViewCell", for: indexPath) as! FilterTableViewCell
        if let items = viewModel?.model?[indexPath.section].items.value {
            cell.configureCell(items[indexPath.row])
            cell.onfilterTapped = { [weak self] isselected in
                self?.viewModel?.model?[indexPath.section].items.value?[indexPath.row].isSelected.value = isselected
            }
        }
        
        return cell
    }
}
