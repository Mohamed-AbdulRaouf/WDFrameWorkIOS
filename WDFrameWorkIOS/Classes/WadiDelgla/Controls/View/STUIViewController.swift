//
//  STUIViewController.swift
//  Auntie Annes
//
//  Created by Mohammed Habib on 1/17/19.
//  Copyright © 2019 Mohammed Habib. All rights reserved.
//


import UIKit
//import AZDialogView
//import Toast_Swift
import RswiftResources
//import BLL
class STUIViewController: UIViewController {
    //MARK: - VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        // remove dark mode
        // overrideUserInterfaceStyle is available with iOS 13
        if #available(iOS 13.0, *) {
            // Always adopt a light interface style.
            overrideUserInterfaceStyle = .light
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getCattItemsCountBadget()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.defaultUI()
    }
}
//MARK: - Functions
extension STUIViewController {
    func getCattItemsCountBadget(){
        guard let items = UserDefaults.order?.cartItems,items.count > 0 else {
            self.tabBarController?.tabBar.items?[2].badgeValue = nil
            return
        }
        let totalSum = items.map({$0.amount}).reduce(0, +)
        self.tabBarController?.tabBar.items?[2].badgeValue = "\(totalSum)"
    }
    func defaultUI(){
        self.tabBarController?.navigationItem.titleView = nil
        self.tabBarController?.navigationItem.rightBarButtonItems = nil
        self.tabBarController?.navigationItem.leftBarButtonItems = nil
        
    }
    func addDismissKeyboardTapGesture(){
        let tapToDismiss = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard(_:)))
        view.addGestureRecognizer(tapToDismiss)
    }
    @objc func onDismissTapped(){
        self.navigationController?.popViewController()
    }
    @objc func dismissKeyboard(_ tap: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    func addDismissButton(){
        self.dismissCnfiguration(withTitle: "X")
    }
    func addSkipButton(){
        self.dismissCnfiguration(withTitle: R.string.localizable.skip())
    }
    private func dismissCnfiguration(withTitle dismissTitle: String) {
        self.navigationController?.navigationBar.topItem?.title = ""
        let skipButton =   UIBarButtonItem(title:dismissTitle, style: .plain, target: self, action: #selector(onDismissTapped))
        skipButton.tintColor = .black
        self.navigationItem.rightBarButtonItems = [skipButton]
        self.navigationItem.leftBarButtonItems = []
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.setHidesBackButton(true, animated: true)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
    }
    @objc func endEditing(){
        self.view.endEditing(true)
    }
    /* bab el hara functions*/
    
    
    
    //   func addDismissButton(){
    //       self.navigationController?.navigationBar.topItem?.title = ""
    //       let dismissButton = UIBarButtonItem(title: "X", style: .plain, target: self, action: #selector(onDismissTapped))
    //       dismissButton.tintColor = .black
    //
    //       //        UIBarButtonItem(image: R.image.ic_close(), style: .plain, target: self, action: #selector(onDismissTapped))
    //       self.navigationItem.rightBarButtonItems = [dismissButton]
    //       self.navigationItem.leftBarButtonItems = []
    //       self.navigationController?.isNavigationBarHidden = false
    //       self.navigationItem.setHidesBackButton(true, animated: true)
    //       self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
    //       self.navigationController?.navigationBar.shadowImage = UIImage()
    //       self.navigationController?.navigationBar.isTranslucent = true
    //       self.navigationController?.view.backgroundColor = UIColor.clear
    //   }
    //
}

//MARK: - Dialog Messages
extension STUIViewController {
    //MARK: - show Dialog message with ok action
    func showMessage(withTitle title: String = "", andMessage message: String, withcompletion completion: (() -> Void )? = nil) {
        
        self.showAlertMessage(message: message)
#warning("check from code")
//        DispatchQueue.main.async {
//            let dialog = AZDialogViewController(title: title, message: message)
//            dialog.imageHandler = { (imageView) in
//
//                imageView.image = R.image.logo()
//                imageView.contentMode = .scaleAspectFit
//                return true
//            }
//            dialog.addAction(AZDialogAction(title: R.string.localizable.ok()) { (dialog) -> (Void) in
//                dialog.dismiss(animated: true, completion: {
//                    completion?()
//                })
//            })
//
//            dialog.show(in: self)
//        }
    }
    
    //MARK: - show Dialog message with custom actions
    func showMessage(withTitle title: String,andMessage message: String,withCancel showCancel: Bool){
#warning("check from code")
        self.showAlertMessage(message: message)
//        DispatchQueue.main.async {
//            let dialog = AZDialogViewController(title: title, message: message)
//            dialog.imageHandler = { (imageView) in
//                imageView.image = R.image.logo()
//                imageView.contentMode = .scaleAspectFit
//                return true
//            }
//            for  action in actions {
//                dialog.addAction(action)
//            }
//            if showCancel {
//                let cancel = AZDialogAction(title: R.string.localizable.cancel()) { (dialog) -> (Void) in
//                    dialog.dismiss()
//                }
//                dialog.addAction(cancel)
//            }
//            dialog.cancelEnabled = true
//            dialog.show(in: self)
//        }
    }
    
    //MARK: - show bottom toast with message
    func showToast(_ message: String){
        self.showAlertMessage(message: message)
    }
    
    func showAlertMessage(title: String? = "", message: String?, selfDismissing: Bool = true, time: TimeInterval = 2) {
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        
        alert.title = title
        alert.message = message
        
        if !selfDismissing {
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        }
        
        present(alert, animated: true)
        
        if selfDismissing {
            Timer.scheduledTimer(withTimeInterval: time, repeats: false) { t in
                t.invalidate()
                alert.dismiss(animated: true)
            }
        }
    }
    
}
//MARK: - Alerts
extension STUIViewController {
    //MARK: - show Alert with custom actions
    func showAlert(withTitle title: String,andMessage message: String,withActions actions:[UIAlertAction],withCancel showCancel: Bool){
        let dialog = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        for  action in actions {
            dialog.addAction(action)
        }
        if showCancel {
            let cancelAction = UIAlertAction(title: R.string.localizable.cancel(), style: .cancel) { (_) in }
            dialog.addAction(cancelAction)
        }
        //finally presenting the dialog box
        self.present(dialog, animated: true, completion: nil)
    }
    
    //MARK: - show Alert with textfield - custom actions
    func showAlertWithText(withTitle title: String,andMessage message: String,andTextPlaceHolder placeholder : String,withActions actions:[UIAlertAction],withCancel showCancel: Bool){
        let dialog = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        //adding textfields to our dialog box
        dialog.addTextField { (textField) in
            textField.placeholder = placeholder
            textField.textAlignment = .center
        }
        
        for  action in actions {
            dialog.addAction(action)
        }
        if showCancel {
            let cancelAction = UIAlertAction(title: R.string.localizable.cancel(), style: .cancel) { (_) in }
            dialog.addAction(cancelAction)
        }
        //finally presenting the dialog box
        self.present(dialog, animated: true, completion: nil)
    }
    
}
