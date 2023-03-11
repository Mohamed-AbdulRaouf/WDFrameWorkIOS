//
//  oldSearchController.swift
//  STDobites
//
//  Created by SimpleTouch on 1/17/21.
//  Copyright © 2021 SimpleTouch. All rights reserved.
//

/*
import UIKit
//import DAL
import RxSwift
import RxCocoa
class SearchViewController: UIViewController ,UISearchBarDelegate{
    
    // MARK: - Properties
    lazy var searchBar:UISearchBar = UISearchBar(frame: CGRect(x: 0, y: 10, width: self.view.frame.width - 20, height: 40))
    let disposeBag = DisposeBag()
    
    //input
    var onItemSelect: ((SearchItemDTO) -> Void)?
    
    //output
    var data = [SearchItemDTO]()
    var filteredData = Variable<[SearchItemDTO]>([])
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        //setup UI
        self.setupUI()
        self.setupSearchController()
        self.setupCellTapHandling()
    }
    
    // MARK: - IBActions
    @IBAction func onDismissTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - Internal
extension SearchViewController{
    func setupUI(){
        searchBar.placeholder = R.string.localizable.searching()
        let barButton = UIBarButtonItem(customView:searchBar)
        if K.shared.APP_LANGUAGE == "ar"{
            self.navigationItem.rightBarButtonItem = barButton
        }else{
            self.navigationItem.leftBarButtonItem = barButton
        }
        
        searchBar.returnKeyType = UIReturnKeyType.done
    }
}

// MARK: - Rx Setup
extension SearchViewController{
    func setupSearchController(){
        searchBar.textField?.rx.controlEvent(.editingDidEndOnExit).asObservable().subscribe(onNext: {
           print("return pressed")
        }).disposed(by: disposeBag)
        
        searchBar.rx.text
            .orEmpty
            .subscribe(onNext: { query in
                if query.isEmpty {
                    self.filteredData.value = self.data
                    return
                }
                    self.filteredData.value = self.data.filter { (searchItem : SearchItemDTO) -> Bool in
                        return ((searchItem.name.value?.lowercased().contains(query.lowercased()))!)
                    }
            })
        
        self.filteredData
            .asObservable()
            .bind(to: self.tableView.rx.items(cellIdentifier: "SearchCell",
                                              cellType: SearchCell.self)) {  row, searchItem, cell in
                                                cell.configureCell(data: searchItem.name.value ?? "")
            }
            .disposed(by: self.disposeBag)
    }
    func setupCellTapHandling() {
        tableView
            .rx
            .modelSelected(SearchItemDTO.self)
            .subscribe(onNext: { [unowned self] searchItem in
                self.onItemSelect!(searchItem)
                if let selectedRowIndexPath = self.tableView.indexPathForSelectedRow {
                    self.tableView.deselectRow(at: selectedRowIndexPath, animated: true)
                }
                self.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)
    }
}
*/
