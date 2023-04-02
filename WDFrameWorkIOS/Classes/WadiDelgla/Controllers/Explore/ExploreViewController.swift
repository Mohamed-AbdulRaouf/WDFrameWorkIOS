//
//  ExploreViewController.swift
//  STDobites
//
//  Created by Nermeen Mohamed on 10/28/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import UIKit

class ExploreViewController: STUIViewController ,IBaseController,UITabBarControllerDelegate{
    
    // MARK: - Properties
    typealias T = IExploreViewModel
    var viewModel: IExploreViewModel?
    var refreshControl : UIRefreshControl?
    let searchController = UISearchController(searchResultsController: nil)
    var selectedServiceIndex = 0 {
        didSet {
            self.serviceCollectionView.reloadData()
        }
    }
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var serviceCollectionView: UICollectionView!
    @IBOutlet weak var searchFooter: SearchFooter!
    var userId : String?
    // to notify that data that loaded before here is changed by login or log out
    var firstEnterToViewWillAppear = true
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //bind UI
        self.setupUI()
        self.bindingData()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.backBarButtonItem?.title = ""
        //change in loyalty
        self.viewModel?.checkIfChangeLoyalty()
        // check this from second entry to viewWillAppear as first time it will get it from viewDidLoad
        if userId != UserDefaults.user?.userId.value ,!firstEnterToViewWillAppear{
            self.refreshList()
            userId = UserDefaults.user?.userId.value
        }
        firstEnterToViewWillAppear = false
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupNavigationBar()
    }
    
    // MARK: - Functions
    @objc func onFilterTapped(){
        guard let _ = self.viewModel?.filterAndSeviceList?.sortList.value else { self.onShowToast(R.string.localizable.no_data_found())
            return
        }
        let vc = StoryboardScene.Brand.filterationViewController.instantiate()
        vc.viewModel?.delegate = self
        vc.viewModel?.filterationList = self.viewModel?.filterAndSeviceList
        self.navigationController?.pushViewController(vc)
    }
    @objc func onSortTapped(){
        guard let _ = self.viewModel?.filterAndSeviceList?.sortList.value else { self.onShowToast(R.string.localizable.no_data_found())
            return
        }
        let vc = StoryboardScene.Brand.sortViewController.instantiate()
        vc.viewModel?.model = self.viewModel?.filterAndSeviceList?.sortList.value
        vc.viewModel?.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
     }
    
    @objc func backToMainApp() {
        doPostNotification("exit_wdframework")
    }
   
}

// MARK: - Internal
extension ExploreViewController{
    func setupUI(){
        self.viewModel?.delegate = self
        self.userId = UserDefaults.user?.userId.value
        self.setupTableView()
        self.setupCollectionView()
        self.setupSearchBar()
        self.viewModel?.initdata()
//        DispatchQueue.global(qos: .background).async {
        doInBackground {
              self.viewModel?.getServices()
        }
        doOnMain {
             self.viewModel?.getBrandList()
        }       
      
        addRefreshControl()
    }
    func bindingData() {}
    
    func setupNavigationBar(){
        self.navigationController?.title = R.string.localizable.explore()
        self.navigationController?.navigationBar.topItem?.title = R.string.localizable.explore()
//        let sort = UIBarButtonItem(image: R.image.ic_sort(), style: .plain, target: self, action: #selector(onSortTapped))
//        let filter =   UIBarButtonItem(image: R.image.funnel(), style: .plain, target: self, action: #selector(onFilterTapped))
//        self.navigationItem.rightBarButtonItems = [sort, filter]
        let backToMainApp = UIBarButtonItem(image: UIImage(named: "exit-to-app"), style: .plain, target: self, action: #selector(backToMainApp))
        self.navigationItem.rightBarButtonItem = backToMainApp
        self.tabBarController?.delegate = self
        
//        self.navigationItem.titleView = self.searchController.searchBar
        
    }
    func addRefreshControl(){
           refreshControl = UIRefreshControl()
           refreshControl?.tintColor = COLOR_ACCENT
           refreshControl?.addTarget(self, action: #selector(refreshList), for: .valueChanged)
           tableView.addSubview(refreshControl!)
    }
       @objc func refreshList(){
        self.viewModel?.refreshList()
        refreshControl?.endRefreshing()
       }
}
