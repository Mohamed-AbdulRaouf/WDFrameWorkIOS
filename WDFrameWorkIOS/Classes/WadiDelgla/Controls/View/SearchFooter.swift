//
//  SearchFooter.swift
//  DoBites
//
//  Created by Nermeen Mohdamed.on 8/27/18.
//  Copyright © 2018 Nermeen Mohdamed. All rights reserved.
//
/*
import UIKit

class SearchFooter: UIView {
    let label = UILabel()

    required public init?(coder : NSCoder) {
        super.init(coder: coder)
        configureView()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    override func draw(_ rect: CGRect) {
        label.frame = self.bounds
    }
    
    func configureView(){
        self.backgroundColor = UIColor(red: 230.0 / 255.0, green: 77.0 / 255.0, blue: 77.0 / 255.0, alpha: 1.0)
        self.alpha = 0.0
        label.textAlignment = .center
        label.textColor = .white
        addSubview(label)
    }
    
    //MARK: Animate the search footer budget
    
    fileprivate func hideFooter() {
        UIView.animate(withDuration: 0.7) { [unowned self] in
            self.alpha = 0.0
        }
    }
    
    fileprivate func showFooter() {
        UIView.animate(withDuration: 0.7) {[unowned self] in
            self.alpha = 1.0
        }
    }

}


extension SearchFooter {
    public func setNotFiltering(){
        label.text = ""
        hideFooter()
    }
    
    public func showIsFilteringToShow(filterItemCount: Int){
        if filterItemCount == 0 {
            let lang : String  = UserDefaults.standard.object(forKey: "DoBitesLang") as? String ?? "en"
            label.text = lang == "en" ? "No Items Found" : "لا يوجد عناصر في هذه القائمة"
            showFooter()
        } else {
            label.text = "Filtering \(filterItemCount) Results"
            showFooter()
        }
    }
}
*/
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
