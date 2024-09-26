//
//  HomeViewController.swift
//  STDobites
//
//  Created by Nermeen Mohamed on 10/28/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import UIKit

internal class HomeViewController: STUIViewController ,IBaseController,UINavigationBarDelegate{
    
    // MARK: - Properties
    typealias T = IHomeViewModel
    var viewModel: IHomeViewModel?
    let notificationCountButton: UIButton = UIButton(type: .custom)
    var firstOpen = true
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        //bind UI
        self.setupTableView()
        self.bindingData()
        self.navigationItem.title =  R.string.localizable.home()
        self.viewModel?.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel?.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.setupNavigationBar()
    }
    
    @objc func onNotificationsTapped(){
        self.viewModel?.onNotificationsTapped()
    }
}

// MARK: - Internal
extension HomeViewController{
    
    func setupNavigationBar(){
        self.navigationController?.navigationBar.topItem?.title = R.string.localizable.home()
        
        notificationCountButton.frame = CGRect(x: 0, y: 0, width: 15, height: 15)
        
        notificationCountButton.layer.cornerRadius =  notificationCountButton.frame.height / 2
        
        notificationCountButton.backgroundColor = COLOR_STATUS_BAR
        
        notificationCountButton.addTarget(self, action: #selector(onNotificationsTapped), for: .touchUpInside)
        
        let notificationcountButtonItem = UIBarButtonItem(customView: notificationCountButton)
        
        let notificationBtn: UIButton = UIButton(type: .custom)
        
        let notificationButtonIconImage:UIImage? = UIImage.getFontAwaseomImage(fontName: "fas fa-bell",imageSize: CGSize(width: 30, height: 30),.white)

        notificationBtn.setImage(notificationButtonIconImage, for: [])

        notificationBtn.addTarget(self, action: #selector(onNotificationsTapped), for: .touchUpInside)
        
        notificationBtn.frame = CGRect(x: notificationCountButton.frame.width - 3, y: notificationCountButton.frame.height, width: 15, height: 30)
        
        let notificationImageButton = UIBarButtonItem(customView: notificationBtn)
        
        self.navigationItem.rightBarButtonItems = [notificationcountButtonItem,notificationImageButton]
                
    }
     func bindingData() {}
}

// MARK: - Table Data Source
extension HomeViewController: UITableViewDelegate,UITableViewDataSource,IBaseTableView{
    func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 60.0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel?.getRowHeight(indexPath.row) ?? 0
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (viewModel?.getNumberOfRows())!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0  || indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SIngleBannerTableViewCell", for: indexPath) as! SIngleBannerTableViewCell
            if let ads = viewModel?.adsList ,ads.count > 0{
                if indexPath.row == 0{
                    cell.configureCell(ads[0])
                } else{
                    cell.configureCell(ads[1])
                }
            }
            return cell

        }else if indexPath.row == 1  {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeActionsTableViewCell", for: indexPath) as! HomeActionsTableViewCell
           cell.selectionStyle = .none
            cell.onRewardTapped = { [weak self] in
                self?.viewModel?.onQRTapped()
            }
            cell.onRankingTapped = { [weak self] in
                self?.viewModel?.onRankingTapped()
            }
            cell.onNearResturantsTapped = { [weak self] in
                self?.viewModel?.onNearResturantsTapped()
            }
            cell.onExploreTapped = { [weak self] in
                self?.viewModel?.onExploreTapped()
            }
            cell.onFavoritesResturantsTapped = { [weak self] in
                self?.viewModel?.onFavoriteResturantsTapped()
             }
           
            cell.configureCell()
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "MultiBannerTableViewCell", for: indexPath) as! MultiBannerTableViewCell
           if let ads = viewModel?.adsList ,ads.count > 0{
             cell.configureCell(ads)
            }
           
            return cell
        }
       
    }
}

// MARK: - LoginProtocol Implementations
extension HomeViewController : LoginProtocol{
    func onUserLogedIn() {
        if let _ = UserDefaults.user{
            self.bindingData()
        }
    }
}
