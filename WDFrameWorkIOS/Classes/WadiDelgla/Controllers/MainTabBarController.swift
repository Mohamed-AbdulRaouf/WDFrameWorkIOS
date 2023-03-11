//
//  MainTabBarController.swift
//  DoBites
//
//  Created by SimpleTouch on 8/5/19.
//  Copyright © 2019 Nermeen Mohdamed.. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController,UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let home = StoryboardScene.Main.homeViewController.instantiate()

        let iconHome = UITabBarItem(title: R.string.localizable.home(), image: R.image.ic_home(), selectedImage: R.image.ic_home())
        home.tabBarItem = iconHome
        
        let navHome = UINavigationController(rootViewController: home)

        
        let explore = StoryboardScene.Main.exploreViewController.instantiate()
        let iconExplore = UITabBarItem(title: R.string.localizable.explore(), image: R.image.ic_explore(), selectedImage: R.image.ic_explore())
        explore.tabBarItem = iconExplore
        
        let navExplore = UINavigationController(rootViewController: explore)

        let profile = StoryboardScene.User.userProfileViewController.instantiate()
        let iconProfile = UITabBarItem(title: R.string.localizable.profile(), image: R.image.ic_username(), selectedImage: R.image.ic_username())
        profile.tabBarItem = iconProfile
        
        let navProfile = UINavigationController(rootViewController: profile)

        let cart = StoryboardScene.Order.STCartViewController.instantiate()
        let iconCart = UITabBarItem(title: R.string.localizable.cart(), image: R.image.ic_cart(), selectedImage: R.image.ic_cart())
        cart.tabBarItem = iconCart

        let navCart = UINavigationController(rootViewController: cart)

        let more = StoryboardScene.Main.moreViewController.instantiate()
        let iconMore = UITabBarItem(title: R.string.localizable.more(), image: R.image.ic_more(), selectedImage: R.image.ic_more())
        more.tabBarItem = iconMore

        let navMore = UINavigationController(rootViewController: more)

        
//      var  controllers = [navHome,navExplore,navProfile,navCart,navMore]
        var  controllers = [navExplore,navProfile,navCart,navMore]

        self.viewControllers = controllers
    }
    
    
    func setupUI(){
        delegate = self
        tabBar.tintColor = .gray
        tabBar.unselectedItemTintColor = .black
        UITabBar.appearance().barTintColor =  COLOR_ACCENT
        tabBar.backgroundColor = COLOR_ACCENT
        tabBar.isTranslucent = false
    }
    //Delegate methods
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        print("Should select viewController: \(viewController.title ?? "") ?")
        return true;
    }
   
}
