//
//  CountryListViewController+TableViewDelegate.swift
//  STDobites
//
//  Created by SimpleTouch on 11/10/20.
//  Copyright © 2020 SimpleTouch. All rights reserved.
//

import Foundation
import UIKit
//import DAL
extension CountryListViewController : UITableViewDelegate,UITableViewDataSource {
    func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        //        tableView.estimatedRowHeight = 60.0
        //        tableView.rowHeight = UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredData.count
        }
        
        return viewModel?.countryList?.count ?? 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountrySelectorTableViewCell", for: indexPath) as! CountrySelectorTableViewCell
        if let countries = viewModel?.countryList,indexPath.row < countries.count {
            let item: ICountryDTODAL
            if isFiltering {
                item = filteredData[indexPath.row]
            } else {
                item = countries[indexPath.row]
            }
            cell.configureCell(country: item, countryDataType: .phoneCode)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let countryList = self.viewModel?.countryList, countryList.count > 0 else {return}
        guard let _ = self.viewModel?.sourceDelegate else {
            return
        }
        let selectedCountry : ICountryDTODAL
        if self.isFiltering {
             selectedCountry = self.filteredData[indexPath.row]
            print(selectedCountry)
        } else {
             selectedCountry = countryList[indexPath.row]
            print(selectedCountry)
        }
        // Close Search Controller keyboard when you select cell
        if searchController.isActive {
            self.dismiss(animated: true, completion: nil)
        }
        self.dismiss(animated: true) {
                            self.viewModel?.sourceDelegate?.selectCountry(country: selectedCountry)
        }
    }
}

