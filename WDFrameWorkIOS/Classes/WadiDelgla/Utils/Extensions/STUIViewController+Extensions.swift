//
//  STUIViewController+Extensions.swift
//  STDobites
//
//  Created by Nermeen Mohamed on 11/3/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import UIKit
public extension UIViewController {
    func setNavigationBarHidden(_ hidden: Bool){
           navigationController?.setNavigationBarHidden(hidden, animated: true)
       }
       func setStatusBarStyle(_ statusBarStyle : UIStatusBarStyle) {
            UIApplication.shared.statusBarStyle = statusBarStyle
       }
    @available(iOS 16.0, *)
    func createSettingsAlertController(title: String, message: String) {

            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let cancelAction = UIAlertAction(title: NSLocalizedString("cancel".localized(), comment: ""), style: .cancel, handler: nil)
        let settingsAction = UIAlertAction(title: NSLocalizedString("settings".localized(), comment: ""), style: .default) { (UIAlertAction) in
               UIApplication.shared.open(URL(string: UIApplication.openNotificationSettingsURLString)! as URL, options: [:], completionHandler: nil)
            }

            alertController.addAction(cancelAction)
            alertController.addAction(settingsAction)
            self.present(alertController, animated: true, completion: nil)

         }
}
