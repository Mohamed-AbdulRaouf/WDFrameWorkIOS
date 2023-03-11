//
//  ViewController.swift
//  TestSearchBar
//
//  Created by Nermeen Mohamed on 10/23/19.
//  Copyright © 2019 Nermeen Mohamed. All rights reserved.
//

import UIKit
//import DAL

//MARK: - IBOutlets
class SearchViewController: STUIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var searchFooter: SearchFooter!
    @IBOutlet var searchFooterBottomConstraint: NSLayoutConstraint!
    
    var data : [SearchItemDTOModelDAL] = []
    var searchController = UISearchController(searchResultsController: nil)
    var filteredData : [SearchItemDTOModelDAL] = []
    var onItemSelect: ((SearchItemDTOModelDAL) -> Void)?
    
    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }
    
    
}
//MARK: - ViewLifeCycle
extension SearchViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Status bar white font
        self.navigationController?.navigationBar.barStyle = UIBarStyle.black
        self.navigationController?.navigationBar.backgroundColor = COLOR_ACCENT
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationItem.hidesBackButton = false

        navigationItem.hidesSearchBarWhenScrolling = false

        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
        setStatusBarStyle(STATUS_BAR_STYLE)

    }
    override func viewDidAppear(_ animated: Bool) {
       super.viewDidAppear(animated)
       searchController.searchBar.becomeFirstResponder()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        setStatusBarStyle(.default)
        self.navigationController?.navigationBar.backgroundColor = .clear
    }
}

//MARK: - Functions
extension SearchViewController {
    func filterContentForSearchText(_ searchText: String) {
        filteredData = data.filter { (candy: SearchItemDTOModelDAL) -> Bool in
            return (candy.name.value!.lowercased().contains(searchText.lowercased()))
        }
        
        tableView.reloadData()
    }
    func handleKeyboard(notification: Notification) {
        // 1
//        guard notification.name == UIResponder.keyboardWillChangeFrameNotification else {
//            searchFooterBottomConstraint.constant = 0
//            view.layoutIfNeeded()
//            return
//        }
//        
//        guard
//            let info = notification.userInfo,
//            let keyboardFrame = info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
//            else {
//                return
//        }
//        
//        // 2
//        let keyboardHeight = keyboardFrame.cgRectValue.size.height
//        UIView.animate(withDuration: 0.1, animations: { () -> Void in
//            self.searchFooterBottomConstraint.constant = keyboardHeight
//            self.view.layoutIfNeeded()
//        })
    }
    
    
}
//MARK: - Internal
extension SearchViewController {
    func setupUI() {
        tableView.dataSource = self
        tableView.delegate = self
        // 1
        searchController.searchResultsUpdater = self
        // 2
        searchController.obscuresBackgroundDuringPresentation = false
        // 3
        searchController.searchBar.placeholder = R.string.localizable.searching()
        // 4
        navigationItem.searchController = searchController
//        tableView.tableHeaderView = searchController.searchBar

        // 5
        definesPresentationContext = true
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.searchBar.searchTextField.textAlignment =  K.shared.APP_LANGUAGE == SupportedLanguage.Arabic.rawValue ? .right : .left
        
//        let notificationCenter = NotificationCenter.default
//        notificationCenter.addObserver(
//            forName: UIResponder.keyboardWillChangeFrameNotification,
//            object: nil, queue: .main) { (notification) in
//                self.handleKeyboard(notification: notification)
//        }
//        notificationCenter.addObserver(
//            forName: UIResponder.keyboardWillHideNotification,
//            object: nil, queue: .main) { (notification) in
//                self.handleKeyboard(notification: notification)
//        }
        
    }
    
}
//MARK: - UISearchResultsUpdating , UISearchBarDelegate
extension SearchViewController : UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!)
        
    }
    
    
}
//MARK: - UITableViewDelegate & DataSource
extension SearchViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            searchFooter.setIsFilteringToShow(filteredItemCount:
                filteredData.count, of: data.count)
            return filteredData.count
        }
        searchFooter.setNotFiltering()
        return data.count
    }
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as? SearchCell {
            let text: String!
            if isFiltering {
                text = filteredData[indexPath.row].name.value ?? ""
            }else{
                text = data[indexPath.row].name.value ?? ""
            }
            cell.configureCell(data: text)
            return cell
        }else{
            return UITableViewCell()
        }
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isFiltering {
            self.onItemSelect!(self.filteredData[indexPath.row])
        }else{
            self.onItemSelect!(self.data[indexPath.row])
        }
        
        self.navigationController?.popViewController(animated: true)
    }
  

}
