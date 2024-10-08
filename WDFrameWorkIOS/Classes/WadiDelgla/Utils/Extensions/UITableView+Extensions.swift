//
//  UITableView+Extensions.swift
//  STDobites
//
//  Created by SimpleTouch on 11/16/20.
//  Copyright © 2020 SimpleTouch. All rights reserved.
//

import UIKit

extension UITableView {

    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont(name: "TrebuchetMS", size: 15)
        messageLabel.sizeToFit()

        self.backgroundView = messageLabel
        self.separatorStyle = .none
    }

    func restore() {
        self.backgroundView = nil
    }
    func reloadDataWithAutoSizingCellWorkAround() {
         self.reloadData()
         self.setNeedsLayout()
         self.layoutIfNeeded()
         self.reloadData()
     }
}
