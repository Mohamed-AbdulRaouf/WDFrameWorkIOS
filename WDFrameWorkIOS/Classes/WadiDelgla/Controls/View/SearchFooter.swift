//
//  SearchFooter.swift
//  DoBites
//
//  Created by Nermeen Mohdamed.on 8/27/18.
//  Copyright © 2018 Nermeen Mohdamed. All rights reserved.
//

import UIKit

class SearchFooter: UIView {
  let label = UILabel()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    configureView()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    
    configureView()
  }
  
  override func draw(_ rect: CGRect) {
    label.frame = bounds
  }
  
  func setNotFiltering() {
    label.text = ""
    hideFooter()
  }
  
  func setIsFilteringToShow(filteredItemCount: Int, of totalItemCount: Int) {
    if (filteredItemCount == totalItemCount) {
      setNotFiltering()
    } else if (filteredItemCount == 0) {
        label.text = R.string.localizable.no_items_match_search_query()
      showFooter()
    } else {
        label.text = "\(R.string.localizable.filtering()) \(filteredItemCount) \(R.string.localizable.of()) \(totalItemCount)"
      showFooter()
    }
  }
  
  func hideFooter() {
    UIView.animate(withDuration: 0.7) {
      self.alpha = 0.0
    }
  }
  
  func showFooter() {
    UIView.animate(withDuration: 0.7) {
      self.alpha = 1.0
    }
  }
  
  func configureView() {
    backgroundColor = UIColor.candyGreen
    alpha = 0.0
    
    label.textAlignment = .center
    label.textColor = UIColor.white
    addSubview(label)
  }
}
extension UIColor {
  static let candyGreen = UIColor(red: 67.0/255.0, green: 205.0/255.0, blue: 135.0/255.0, alpha: 1.0)
}
