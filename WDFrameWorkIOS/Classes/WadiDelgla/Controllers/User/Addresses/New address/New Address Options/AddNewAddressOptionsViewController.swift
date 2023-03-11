//
//  AddNewAddressOptionsViewController.swift
//  SimpleTouch
//
//  Created by SimpleTouch on 14/5/20.
//  Copyright © 2020 SimpleTouch. All rights reserved.
//

import UIKit
//MARK: - IBOutlet
class AddNewAddressOptionsViewController: STUIViewController {
    
    @IBOutlet weak var addAddressManuallyButton: UIButton!
    @IBOutlet weak var mapButton: UIButton!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    var openAddNewAddress : (() -> Void)?
    var openMap : (() -> Void)?
}
//MARK: - View Life Cycle
extension AddNewAddressOptionsViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

}
//MARK: - Internal
extension AddNewAddressOptionsViewController {
      func setupUI(){
          self.titleLabel.text = R.string.localizable.add_new_address_title()
          self.titleLabel.textColor = COLOR_PRIMARY_TEXT
          self.titleLabel.font = UIFont(resource: APP_FONT_BOLD, size: 30)
          
          self.messageLabel.textColor = COLOR_PRIMARY_TEXT
          self.messageLabel.font = UIFont(resource: APP_FONT_REGULAR, size: 16)
          self.messageLabel.text = R.string.localizable.add_new_address_message()
          
          self.mapButton.setTitleColor(COLOR_BUTTON_TEXT, for: .normal)
          self.mapButton.setTitle(R.string.localizable.use_current_location(), for: .normal)
          self.mapButton.backgroundColor = COLOR_BUTTON
          self.mapButton.layer.cornerRadius = 5
          
          self.addAddressManuallyButton.setTitle(R.string.localizable.select_manually(), for: .normal)
          self.addAddressManuallyButton.setTitleColor(COLOR_PRIMARY_TEXT, for: .normal)
          self.addAddressManuallyButton.titleLabel?.font = UIFont(resource: APP_FONT_REGULAR, size: 14)
          self.addAddressManuallyButton.addTarget(self, action: #selector(openNewAddressManuallyTapped(_:)), for: .touchUpInside)
          self.mapButton.addTarget(self, action: #selector(openMapTapped(_:)), for: .touchUpInside)
      }
    
}
//MARK: - IBAction
extension AddNewAddressOptionsViewController {
    
      @IBAction func openNewAddressManuallyTapped(_ sender: Any){
          self.navigationController?.popViewController(animated: true, {
               self.openAddNewAddress!()
          })
      }
      @IBAction func openMapTapped(_ sender : Any){
          self.navigationController?.popViewController(animated: true, {
               self.openMap!()
          })
      }
}
