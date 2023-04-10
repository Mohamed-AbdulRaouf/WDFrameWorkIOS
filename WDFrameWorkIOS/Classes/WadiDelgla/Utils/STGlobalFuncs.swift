//
//  STGlobalFuncs.swift
//  SimpleTouch
//
//  Created by SimpleTouch on 5/20/20.
//  Copyright © 2020 SimpleTouch. All rights reserved.
//

import UIKit
//import DAL
//import BLL
func changeLanguage() {
       
    let newLang = (LocalizationSystem.sharedInstance.getLanguage() == "en") ? "ar" : "en"
       
       UserDefaults.currentAppLanguage = newLang
       UserDefaults.standard.synchronize()
       UserDefaults.currentArea = nil
       UserDefaults.currentCity = nil
       Bundle.setLanguage(newLang)
      
       // Done to reintantiate the storyboards instantly
        doPostNotification("exit_wdframework")
//       let rootviewcontroller: UIWindow = ((UIApplication.shared.delegate?.window)!)!
//       rootviewcontroller.rootViewController = UINavigationController(rootViewController: StoryboardScene.Location.locationViewController.instantiate())
//       let mainwindow = (UIApplication.shared.delegate?.window!)!
//    mainwindow.backgroundColor = .black
//       UIView.transition(with: mainwindow, duration: 0.55001, options: .transitionFlipFromLeft, animations: { () -> Void in
//       }) { (finished) -> Void in
//       }
       
   }
func changeCountry(withCountry country: ICountryDTODAL) {
       UserDefaults.currentAppCountry = country as? CountryDTODAL
       UserDefaults.currentArea = nil
       UserDefaults.currentCity = nil
       // delete cart
       UserDefaults.order = nil
       
      
       
       // Done to reintantiate the storyboards instantly
       
       //    UIApplication.shared.keyWindow?.rootViewController = StoryboardScene.Main.splashViewController.instantiate()
       
       
       let rootviewcontroller: UIWindow = ((UIApplication.shared.delegate?.window)!)!
       rootviewcontroller.rootViewController = UINavigationController(rootViewController: StoryboardScene.Main.splashViewController.instantiate())
       let mainwindow = (UIApplication.shared.delegate?.window!)!
       mainwindow.backgroundColor = COLOR_ACCENT_DARK
       UIView.transition(with: mainwindow, duration: 0.55001, options: .transitionFlipFromLeft, animations: { () -> Void in
       }) { (finished) -> Void in
       }
       
}
