//
//  UIStoryBoard+STAdditions.swift
//  STDobites
//
//  Created by SimpleTouch on 10/17/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import UIKit
import SwinjectStoryboard
// swiftlint:disable file_length

public protocol StoryboardType {
    static var storyboardName: String { get }
}

extension StoryboardType {
    public static var storyboard: UIStoryboard {
        let bundlePath = Bundle(for: UserTestPath.self).path(forResource: "resources", ofType: "bundle")
        let bundle = Bundle(path: bundlePath!)
        return SwinjectStoryboard.create(name: self.storyboardName, bundle: bundle, container: container)
    }
}

public struct SceneType<T: Any> {
    let storyboard: StoryboardType.Type
    let identifier: String
    
    public func instantiate() -> T {
        guard let controller = storyboard.storyboard.instantiateViewController(withIdentifier: identifier) as? T else {
            fatalError("ViewController '\(identifier)' is not of the expected class \(T.self).")
        }
        return controller
    }
}

public struct InitialSceneType<T: Any> {
    let storyboard: StoryboardType.Type
    
    func instantiate() -> T {
        guard let controller = storyboard.storyboard.instantiateInitialViewController() as? T else {
            fatalError("ViewController is not of the expected class \(T.self).")
        }
        
        return controller
    }
}

public protocol SegueType: RawRepresentable { }

extension UIViewController {
    func perform<S: SegueType>(segue: S, sender: Any? = nil) where S.RawValue == String {
        performSegue(withIdentifier: segue.rawValue, sender: sender)
    }
}

// swiftlint:disable explicit_type_interface identifier_name line_length type_body_length type_name
public enum StoryboardScene {
    public enum User : StoryboardType {
        
       public static let storyboardName = "User"
        
        static let loginViewController = SceneType<LoginViewController>(storyboard: User.self, identifier: "LoginViewController")
        
        
        static let registerViewController = SceneType<RegisterationViewController>(storyboard: User.self, identifier: R.storyboard.user.registerationViewController.identifier)
        static let forgotPasswordVerifyCodeViewController = SceneType<ForgotPasswordVerifyCodeViewController>(storyboard: User.self, identifier: R.storyboard.user.forgotPasswordVerifyCodeViewController.identifier)
        static let resetPasswordViewController = SceneType<ResetPasswordViewController>(storyboard: User.self, identifier: "ResetPasswordViewController")
        static let userProfileViewController = SceneType<UserProfileViewController>(storyboard: User.self, identifier: R.storyboard.user.userProfileViewController.identifier)
        static let userProfileNavigationViewController = SceneType<UINavigationController>(storyboard: User.self, identifier: "UserProfileNavigationController")
        static let changePasswordViewController = SceneType<ChangePasswordViewController>(storyboard: User.self, identifier: "ChangePasswordViewController")
        static let verificationCodeViewController = SceneType<VerificationCodeViewController>(storyboard: User.self, identifier: "VerificationCodeViewController")
        
        static let orderListViewController = SceneType<OrderListViewController>(storyboard: User.self, identifier: "OrderListViewController")
        
        static let userAddressListViewController = SceneType<UserAddressListViewController>(storyboard: User.self, identifier: "UserAddressListViewController")
        
        static let addNewUserAddressViewController = SceneType<AddNewUserAddressViewController>(storyboard: User.self, identifier: "AddNewUserAddressViewController")
        
        static let addNewAddressOptionsViewController = SceneType<AddNewAddressOptionsViewController>(storyboard: User.self, identifier: "AddNewAddressOptionsViewController")
              
        static let locationPickerViewController = SceneType<LocationPickerViewController>(storyboard: User.self, identifier: "LocationPickerViewController")
    }
    public enum Location :StoryboardType {
        public static let storyboardName = "Location"
        
        static let locationViewController = SceneType<LocationViewController>(storyboard: Location.self, identifier: "LocationViewController")
        
        static let nearResturantsLocationsViewController = SceneType<NearResturantsLocationsViewController>(storyboard: Location.self, identifier: "NearResturantsLocationsViewController")
        
    }
    
    public enum Features :StoryboardType {
        public static let storyboardName = "Features"
        
        static let searchViewController = SceneType<SearchViewController>(storyboard: Features.self, identifier: "SearchViewController")
        
        static let rankingViewController = SceneType<RankingViewController>(storyboard: Features.self, identifier: "RankingViewController")
        
        static let qRcodeViewController = SceneType<QRcodeViewController>(storyboard: Features.self, identifier: "QRcodeViewController")
        
        static let notificationListViewController = SceneType<NotificationListViewController>(storyboard: Features.self, identifier: "NotificationListViewController")
        
        static let barCodeViewController = SceneType<BarCodeViewController>(storyboard: Features.self, identifier: "BarCodeViewController")
        
        static let imageZoomingViewController = SceneType<ImageZoomingViewController>(storyboard: Features.self, identifier: "ImageZoomingViewController")

        static let countryListViewController = SceneType<CountryListViewController>(storyboard: Features.self, identifier: "CountryListViewController")        
        
    }
    public enum Main :StoryboardType {
        public static let storyboardName = "Main"
        
        static let splashViewController = SceneType<SplashViewController>(storyboard: Main.self, identifier: "SplashViewController")
        
        static let tabBarViewController = SceneType<UITabBarController>(storyboard: Main.self, identifier: "tabController")
        
        static let homeViewController = SceneType<HomeViewController>(storyboard: Main.self, identifier: "HomeViewController")
        
        static let moreViewController = SceneType<MoreViewController>(storyboard: Main.self, identifier: "MoreViewController")
        
        static let exploreViewController = SceneType<ExploreViewController>(storyboard: Main.self, identifier: "ExploreViewController")
        
        
        
    }
   public enum Brand :StoryboardType {
       public static let storyboardName = "Brand"
        
        static let brandInfoViewController = SceneType<BrandInfoViewController>(storyboard: Brand.self, identifier: "BrandInfoViewController")
        
        static let filterationViewController = SceneType<FilterationViewController>(storyboard: Brand.self, identifier: "FilterationViewController")
        
        static let sortViewController = SceneType<SortViewController>(storyboard: Brand.self, identifier: "SortViewController")
        
        
    }
   public enum Menu :StoryboardType {
       public static let storyboardName = "Menu"
        
        static let menuViewController = SceneType<MenuViewController>(storyboard: Menu.self, identifier: "MenuViewController")
        
        static let productViewController = SceneType<ProductViewController>(storyboard: Menu.self, identifier: "ProductViewController")
        
        
    }
   public enum Order :StoryboardType {
       public static let storyboardName = "Order"
        
        static let receiptViewController = SceneType<ReceiptViewController>(storyboard: Order.self, identifier: "ReceiptViewController")
        
        static let STCartViewController = SceneType<STCartViewController>(storyboard: Order.self, identifier: "STCartViewController")
        
        static let checkOutViewController = SceneType<CheckOutViewController>(storyboard: Order.self, identifier: "CheckOutViewController")
        
        static let redeemViewController = SceneType<RedeemViewController>(storyboard: Order.self, identifier: "RedeemViewController")
        
        static let rateOrderViewController = SceneType<RateOrderViewController>(storyboard: Order.self, identifier: "RateOrderViewController")
        
        static let notRatedOrdersViewController = SceneType<NotRatedOrdersViewController>(storyboard: Order.self, identifier: "NotRatedOrdersViewController")
        
        static let orderTypeViewController = SceneType<OrderTypeViewController>(storyboard: Order.self, identifier: "OrderTypeViewController")
        
    }
    public enum Payment: StoryboardType {
        public static let storyboardName = "Payment"
        
        static let creditCardViewController = SceneType<CreditCardViewController>(storyboard: Payment.self, identifier: "CreditCardViewController")
        
    }
    
    public enum RaoufTest: StoryboardType {
        public static let storyboardName = "Main"
        
       static let splashViewControllerTwo = SceneType<SplashViewController>(storyboard: Main.self, identifier: "SplashViewController")
    }
    
}

public enum StoryboardSegue {
}
// swiftlint:enable explicit_type_interface identifier_name line_length type_body_length type_name

public final class BundleToken {}
