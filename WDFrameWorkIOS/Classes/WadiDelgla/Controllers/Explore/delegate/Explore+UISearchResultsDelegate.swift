//
//  Explore+UISearchResultsUpdating.swift
//  STDobites
//
//  Created by SimpleTouch on 11/6/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import UIKit
//MARK: -SearchBar Delegat
extension ExploreViewController : UISearchResultsUpdating ,UISearchBarDelegate{
    func setupSearchBar(){
        //MARK: -initialize search controller
        self.searchController.hidesNavigationBarDuringPresentation = false
        
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        searchController.searchBar.showsSearchResultsButton = true
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = R.string.localizable.search_for_brand()
        searchController.searchBar.tintColor = .white
        searchController.searchBar.backgroundColor = .clear
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        // Stop doing the search stuff
        // and clear the text in the search bar
        searchBar.text = ""
        // Hide the cancel button
        searchBar.showsCancelButton = false
        // You could also change the position, frame etc of the searchBar
        self.setFilter(searchController.searchBar.text!)
        
    }
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.setFilter(searchController.searchBar.text!)
    }
    
}

