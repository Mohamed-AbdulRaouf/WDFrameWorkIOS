//
//  StoryboardAllScenes.swift
//  WadiDeglaFramework
//
//  Created by Raouf on 21/02/2023.
//

import UIKit
import SwinjectStoryboard

public class MainStoryboardScene {

    public static var shared = MainStoryboardScene()

    public init() {}

    public func splashViewControllerVC() -> UIViewController {
        return StoryboardScene.Main.splashViewController.instantiate()
    }

    public func homeViewControllerVC() -> UIViewController {
        return StoryboardScene.Main.homeViewController.instantiate()
    }

    public func exploreViewControllerVC() -> UIViewController {
        return StoryboardScene.Main.exploreViewController.instantiate()
    }

    public func tabBarViewControllerVC() -> UIViewController {
        return StoryboardScene.Main.tabBarViewController.instantiate()
    }

}

public class UserStoryboardScene {

    public static var shared = UserStoryboardScene()

    public init() {}

    public func loginViewControllerVC() -> UIViewController {
        return StoryboardScene.User.loginViewController.instantiate()
    }

    public func addNewAddressOptionsVC() -> UIViewController {
        return StoryboardScene.User.addNewAddressOptionsViewController.instantiate()
    }

    public func addNewUserAddressVC() -> UIViewController {
        return StoryboardScene.User.addNewUserAddressViewController.instantiate()
    }

    public func changePasswordVC() -> UIViewController {
        return StoryboardScene.User.changePasswordViewController.instantiate()
    }

    public func forgotPasswordVerifyCodeVC() -> UIViewController {
        return StoryboardScene.User.forgotPasswordVerifyCodeViewController.instantiate()
    }

    public func orderListVC() -> UIViewController {
        return StoryboardScene.User.orderListViewController.instantiate()
    }

    public func registerVC() -> UIViewController {
        return StoryboardScene.User.registerViewController.instantiate()
    }

    public func userProfileVC() -> UIViewController {
        return StoryboardScene.User.userProfileViewController.instantiate()
    }
}

public class MenuStoryboardScene {

    public static var shared = MenuStoryboardScene()

    public init() {}

    public func menuVC() -> UIViewController {
        let vc = StoryboardScene.Menu.menuViewController.instantiate()
        return vc
    }

    public func productVC() -> UIViewController {
        return StoryboardScene.Menu.productViewController.instantiate()
    }
}

public class FeaturesStoryboardScene {

    public static var shared = FeaturesStoryboardScene()

    public init() {}

    public func searchVC() -> UIViewController {
        return StoryboardScene.Features.searchViewController.instantiate()
    }

    public func qRcodeVC() -> UIViewController {
        return StoryboardScene.Features.qRcodeViewController.instantiate()
    }

    public func notificationListVC() -> UIViewController {
        return StoryboardScene.Features.notificationListViewController.instantiate()
    }
}

public class BrandStoryboardScene {

    public static var shared = BrandStoryboardScene()

    public init() {}

    public func brandInfoVC() -> UIViewController {
        return StoryboardScene.Brand.brandInfoViewController.instantiate()
    }

    public func filterationVC() -> UIViewController {
        return StoryboardScene.Brand.filterationViewController.instantiate()
    }
}

public class PaymentStoryboardScene {

    public static var shared = PaymentStoryboardScene()

    public init() {}

    public func creditCardVC() -> UIViewController {
        return StoryboardScene.Payment.creditCardViewController.instantiate()
    }

}

public class OrderStoryboardScene {

    public static var shared = OrderStoryboardScene()

    public init() {}

    public func STCartVC() -> UIViewController {
        return StoryboardScene.Order.STCartViewController.instantiate()
    }

    public func checkOutVC() -> UIViewController {
        return StoryboardScene.Order.checkOutViewController.instantiate()
    }

    public func notRatedOrdersVC() -> UIViewController {
        return StoryboardScene.Order.notRatedOrdersViewController.instantiate()
    }

    public func receiptVC() -> UIViewController {
        return StoryboardScene.Order.receiptViewController.instantiate()
    }

    public func redeemVC() -> UIViewController {
        return StoryboardScene.Order.redeemViewController.instantiate()
    }

    public func rateOrderVC() -> UIViewController {
        return StoryboardScene.Order.rateOrderViewController.instantiate()
    }
}
