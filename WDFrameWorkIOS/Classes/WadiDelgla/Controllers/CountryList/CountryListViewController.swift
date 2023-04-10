//
//  CountryListViewController.swift
//  STDobites
//
//  Created by SimpleTouch on 11/10/20.
//  Copyright © 2020 SimpleTouch. All rights reserved.
//

import UIKit
import RxSwift
//import RxCocoa
//import DAL
class CountryListViewController: STUIViewController,IBaseController {
    
    
    // MARK: - Properties
    typealias T = ICountryListViewModel
    var viewModel: ICountryListViewModel?
    var searchController = UISearchController(searchResultsController: nil)
    var filteredData: [ICountryDTODAL] = []
    
    var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }

    var isFiltering: Bool {
      return !isSearchBarEmpty
    }

    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.setupUI()
        self.bindingData()
        self.navigationItem.title = ""
           
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)

    }
    //MARK: - Functions
    func filterContentForSearchText(_ searchText: String) {
        if let countryList = self.viewModel?.countryList,countryList.count > 0 {
           filteredData = countryList.filter { (item: ICountryDTODAL) -> Bool in
            return (item.name.value ?? "").lowercased().contains(searchText.lowercased())
           }
        }
      tableView.reloadData()
    }

    
}
// MARK: - Internal
extension CountryListViewController {
    func setupUI(){
        self.viewModel?.delegate = self
        self.setupSearchController()
        self.setupTableView()
    }
    
    
    func setupSearchController() {
//        // 1
//        searchController.searchResultsUpdater = self
//        // 2
//        searchController.obscuresBackgroundDuringPresentation = false
//        // 3
//        searchController.searchBar.placeholder = "Search Countries"
//        // 4
//        navigationItem.searchController = searchController
//        // 5
//        definesPresentationContext = true
        
        
         searchController = ({
                let controller = UISearchController(searchResultsController: nil)
                controller.searchResultsUpdater = self
                controller.obscuresBackgroundDuringPresentation = false
                controller.searchBar.sizeToFit()
             controller.searchBar.placeholder = "search_country".localized()
                controller.searchBar.searchTextField.textAlignment = LocalizationSystem.sharedInstance.isCurrentLanguageArabic() ? .right : .left

                tableView.tableHeaderView = controller.searchBar

                return controller
            })()

            // Reload the table
            tableView.reloadData()

    }
    
    func bindingData() {}
}
extension CountryListViewController : ICountryListViewController {
    func onReloadTableView() {
        self.tableView.reloadData()
         
    }
}
extension CountryListViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
   let searchBar = searchController.searchBar
    filterContentForSearchText(searchBar.text!)
  }
   
}
