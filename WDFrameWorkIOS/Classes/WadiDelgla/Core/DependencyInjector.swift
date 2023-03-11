//
//  STContainer.swift
//  STDobites
//
//  Created by SimpleTouch on 10/14/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import Swinject
import SwinjectStoryboard
//import DAL
//import BLL


let container = Container() { container in
    container.register(NetworkingBLL.self) { _ in NetworkBLL() }.inObjectScope(.container)
    container.register(UserServiceBLL.self) { r in UserUseCasesBLL(network: r.resolve(NetworkingBLL.self)!)}.inObjectScope(.transient)
    container.register(BrandServiceBLL.self) { r in BrandUseCasesBLL(network: r.resolve(NetworkingBLL.self)!)}.inObjectScope(.transient)
    container.register(MenuServiceBLL.self) { r in MenuUseCasesBLL(network: r.resolve(NetworkingBLL.self)!)}.inObjectScope(.transient)
    container.register(OrderServiceBLL.self) { r in OrderUseCasesBLL(network: r.resolve(NetworkingBLL.self)!)}.inObjectScope(.transient)
    container.register(CartServiceBLL.self) { _ in CartUseCasesBLL() }.inObjectScope(.transient)
    container.register(IBaseDTODAL.self) { _ in BaseDTODAL() }.inObjectScope(.container)
    container.register(PaymentServiceBLL.self) { _ in PaymentUseCasesBLL() }.inObjectScope(.transient)
    container.register(CountryServiceBLL.self) { r in CountryUseCasesBLL(network: r.resolve(NetworkingBLL.self)!)}.inObjectScope(.transient)

    //login
    container.register(ILoginDTODAL.self) { _ in LoginDTODAL() }
    container.register(ILoginValidationDTOBLL.self) { _ in LoginValidationDTOBLL() }
    
    container.register(ILoginViewModel.self) { r in
        let viewModel = LoginViewModel(user_login_data: r.resolve(ILoginDTODAL.self)!, user_data: r.resolve(IUserDTODAL.self)!, apiClient: r.resolve(UserServiceBLL.self)!, errorModel: r.resolve(ILoginValidationDTOBLL.self)!)
        return viewModel
    }.inObjectScope(.transient)
    
    container.register(IUserDTODAL.self) {_ in UserDTODAL()}
    
    //         Views
    container.storyboardInitCompleted(LoginViewController.self) { r, c in
        c.viewModel = r.resolve(ILoginViewModel.self)!
        
    }
    //registeration
    container.register(IRegisterDTODAL.self) { r in RegisterDTODAL() }
    container.register(IRegisterValidationDTOBLL.self) { _ in RegisterValidationDTOBLL() }
    container.register(IAuthPhoneNumberDTODAL.self) { _ in AuthPhoneNumberDTODAL() }
    container.register(IRegisterViewModel.self) { r in
        let viewModel = RegisterViewModel(user_data: r.resolve(IRegisterDTODAL.self)!,apiClient: r.resolve(UserServiceBLL.self)!,errorModel: r.resolve(IRegisterValidationDTOBLL.self)!)
        return viewModel
    }.inObjectScope(.transient)
    //         Views
    
    container.storyboardInitCompleted(RegisterationViewController.self) { r, c in
        c.viewModel = r.resolve(IRegisterViewModel.self)!
        //            c.viewModel.user_data = r.resolve(IRegisterDTO.self)!
        
    }
    //forgot password
    container.register(IVerificationCodeDTODAL.self) { _ in VerificationCodeDTODAL() }
    container.register(IPhoneNumberValidationDTOBLL.self) { _ in PhoneNumberValidationDTOBLL() }
    container.register(IVerificationCodeValidationDTOBLL.self) { _ in VerificationCodeValidationDTOBLL() }
    
    container.register(IForgotPasswordVerifyCodeViewModel.self) { r in
        
        let viewModel =   ForgotPasswordVerifyCodeViewModel(verificationCodeModel: r.resolve(IAuthPhoneNumberDTODAL.self)!, apiClient: r.resolve(UserServiceBLL.self)!, errorModel: r.resolve(IPhoneNumberValidationDTOBLL.self)!)
        return viewModel
    }.inObjectScope(.transient)
    
    
    //         Views
    container.storyboardInitCompleted(ForgotPasswordVerifyCodeViewController.self) { r, c in
        c.viewModel = r.resolve(IForgotPasswordVerifyCodeViewModel.self)!
    }
    //reset password
    container.register(IResetPasswordDTODAL.self) { _ in ResetPasswordDTODAL() }
    container.register(IResetPasswordValidationDTOBLL.self) { _ in ResetPasswordValidationDTO() }
    
    container.register(IResetPasswordViewModel.self) { r in
        
        let viewModel =   ResetPasswordViewModel(newPasswordModel: r.resolve(IResetPasswordDTODAL.self)!,verificationCodeModel: r.resolve(IVerificationCodeDTODAL.self)!, apiClient: r.resolve(UserServiceBLL.self)!, errorModel: r.resolve(IResetPasswordValidationDTOBLL.self)!)
        return viewModel
    }.inObjectScope(.transient)
    
    
    //         Views
    container.storyboardInitCompleted(ResetPasswordViewController.self) { r, c in
        c.viewModel = r.resolve(IResetPasswordViewModel.self)!
    }
    
    //User Profile
    container.register(IUserDTODAL.self) { r in UserDTODAL() }
    container.register(IUserProfileValidationDTOBLL.self) { _ in UserProfileValidationDTOBLL() }
    container.register(IUserProfileViewModel.self) { r in
        let viewModel = UserProfileViewModel(user_data: r.resolve(IUserDTODAL.self)!,apiClient: r.resolve(UserServiceBLL.self)!,errorModel: r.resolve(IUserProfileValidationDTOBLL.self)!)
        return viewModel
    }.inObjectScope(.transient)
    //         Views
    
    container.storyboardInitCompleted(UserProfileViewController.self) { r, c in
        c.viewModel = r.resolve(IUserProfileViewModel.self)!
        
    }
    //Change Password
    container.register(INewPasswordDTODAL.self) { r in NewPasswordDTODAL() }
    container.register(IChangePasswordValidationDTOBLL.self) { _ in ChangePasswordValidationDTOBLL() }
    container.register(IChangePasswordViewModel.self) { r in
        let viewModel = ChangePasswordViewModel(newPasswordModel: r.resolve(INewPasswordDTODAL.self)!,apiClient: r.resolve(UserServiceBLL.self)!,errorModel: r.resolve(IChangePasswordValidationDTOBLL.self)!)
        return viewModel
    }.inObjectScope(.transient)
    //         Views
    
    container.storyboardInitCompleted(ChangePasswordViewController.self) { r, c in
        c.viewModel = r.resolve(IChangePasswordViewModel.self)!
        
    }
    //Verify Code
    container.register(IVerificationCodeViewModel.self) { r in
        let viewModel = VerificationCodeViewModel(verificationCodeModel: r.resolve(IAuthPhoneNumberDTODAL.self)!,apiClient: r.resolve(UserServiceBLL.self)!,errorModel: r.resolve(IVerificationCodeValidationDTOBLL.self)!)
        return viewModel
    }.inObjectScope(.transient)
    //         Views
    
    container.storyboardInitCompleted(VerificationCodeViewController.self) { r, c in
        c.viewModel = r.resolve(IVerificationCodeViewModel.self)!
        
    }
    //Mark:- Location
    container.register(LocationServiceBLL.self) { r in LocationUseCasesBLL(network: r.resolve(NetworkingBLL.self)!)}
    
    
    container.register(ICityDTODAL.self) { r in CityDTODAL() }
#warning("check from code")
//    container.register(ISearchItemDTODAL.self) { r in SearchItemDTODAL() }
    
    container.register(ILocationViewModel.self) { r in
        let viewModel = LocationViewModel(apiClient: r.resolve(LocationServiceBLL.self)!, cartService: r.resolve(CartServiceBLL.self)!)
        return viewModel
    }.inObjectScope(.transient)
    //         Views
    
    container.storyboardInitCompleted(LocationViewController.self) { r, c in
        c.viewModel = r.resolve(ILocationViewModel.self)!
    }
    
    container.storyboardInitCompleted(SearchViewController.self) { r, c in
        //        c.viewModel = r.resolve(ILocationViewModel.self)!
    }
    
    //MARK:- Splash
    
    container.register(ISplashViewModel.self) { r in
        let viewModel = SplashViewModel(user_login_data: r.resolve(ILoginDTODAL.self)!,apiClient: r.resolve(UserServiceBLL.self)!,apiCountry: r.resolve(CountryServiceBLL.self)!)
        return viewModel
    }.inObjectScope(.transient)
    
    container.storyboardInitCompleted(SplashViewController.self) { r, c in
        c.viewModel = r.resolve(ISplashViewModel.self)!
    }
    
    //Mark:- Home
    container.register(IPagingDTODAL.self) { _ in PagingDTODAL() }
    container.register(IAdsDTODAL.self) { _ in AdsDTODAL() }
    container.register(IHomeViewModel.self) { r in
        let viewModel = HomeViewModel(pagingDTO: r.resolve(IPagingDTODAL.self)!, apiClient: r.resolve(BrandServiceBLL.self)!, userService: r.resolve(UserServiceBLL.self)!, requestOrderDTO: r.resolve(IRequestDTODAL.self)!)
        return viewModel
    }.inObjectScope(.transient)
    //         Views
    container.storyboardInitCompleted(HomeViewController.self) { r, c in
        c.viewModel = r.resolve(IHomeViewModel.self)!
    }
    //MARK:- Ranking
    
    container.register(ITopRatedReferralsDTODAL.self) { _ in TopRatedReferralsDTODAL() }
    container.register(IRankingViewModel.self) { r in
        let viewModel = RankingViewModel( apiClient: r.resolve(UserServiceBLL.self)!)
        return viewModel
    }.inObjectScope(.transient)
    //         Views
    container.storyboardInitCompleted(RankingViewController.self) { r, c in
        c.viewModel = r.resolve(IRankingViewModel.self)!
    }
    
    //MARK:_ QR
    
    container.register(IQRViewModel.self) { r in
        let viewModel = QRViewModel()
        return viewModel
    }.inObjectScope(.transient)
    //         Views
    container.storyboardInitCompleted(QRcodeViewController.self) { r, c in
        c.viewModel = r.resolve(IQRViewModel.self)!
    }
    
    
    // Map
    container.register(IBrandLocationDTODAL.self) { _ in BrandLocationDTODAL() }
    container.register(IArtWorkDAL.self) { _ in ArtworkDAL() }
    container.register(IArtWorkDAL.self) { r in
        let viewModel = ArtworkDAL(brand: r.resolve(IBrandLocationDTODAL.self)!)
        return viewModel
    }.inObjectScope(.transient)
    container.register(INearResturantsLocationsViewModel.self) { r in
        let viewModel = NearResturantsLocationsViewModel( apiClient: r.resolve(BrandServiceBLL.self)!)
        return viewModel
    }.inObjectScope(.transient)
    //         Views
    container.storyboardInitCompleted(NearResturantsLocationsViewController.self) { r, c in
        c.viewModel = r.resolve(INearResturantsLocationsViewModel.self)!
    }
    
    
    //More
    
    container.register(IMoreViewModel.self) { r in
        let viewModel = MoreViewModel( apiClient: r.resolve(UserServiceBLL.self)!,cartService: r.resolve(CartServiceBLL.self)!)
        return viewModel
    }.inObjectScope(.transient)
    //         Views
    container.storyboardInitCompleted(MoreViewController.self) { r, c in
        c.viewModel = r.resolve(IMoreViewModel.self)!
    }
    
    //Customer Orders
    container.register(IRequestDTODAL.self) { _ in RequestDTODAL() }
    container.register(IOrderDTODAL.self) { _ in OrderDTODAL() }
    container.register(IOrderListDTODAL.self) { _ in OrderListDTODAL() }
    container.register(IOrderListViewModel.self) { r in
        let viewModel = OrderListViewModel( requestOrderDTO: r.resolve(IRequestDTODAL.self)!, apiClient: r.resolve(UserServiceBLL.self)!)
        return viewModel
    }.inObjectScope(.transient)
    //         Views
    container.storyboardInitCompleted(OrderListViewController.self) { r, c in
        c.viewModel = r.resolve(IOrderListViewModel.self)!
    }
    
    //Notifications
    container.register(INotificationDTODAL.self) { _ in NotificationDTODAL() }
    container.register(INotificationListViewModel.self) { r in
        let viewModel = NotificationListViewModel( requestDTO: r.resolve(IRequestDTODAL.self)!, apiClient: r.resolve(BrandServiceBLL.self)!)
        return viewModel
    }.inObjectScope(.transient)
    //         Views
    container.storyboardInitCompleted(NotificationListViewController.self) { r, c in
        c.viewModel = r.resolve(INotificationListViewModel.self)!
    }
    
    ///user address list
    container.register(IUserAddressDTODAL.self) { _ in UserAddressDTODAL() }
    container.register(IUserAddressListViewModel.self) { r in
        let viewModel = UserAddressListViewModel(apiClient: r.resolve(UserServiceBLL.self)!)
        return viewModel
    }.inObjectScope(.transient)
    //         Views
    container.storyboardInitCompleted(UserAddressListViewController.self) { r, c in
        c.viewModel = r.resolve(IUserAddressListViewModel.self)!
    }
    
    ///add new address
    container.register(IAddressValidationDTOBLL.self) { _ in AddressValidationDTOBLL() }
    container.register(IAddNewUserAddressViewModel.self) { r in
        let viewModel = AddNewUserAddressViewModel(address_data: r.resolve(IUserAddressDTODAL.self)!, apiClient: r.resolve(UserServiceBLL.self)!, apiLocation: r.resolve(LocationServiceBLL.self)!, errorModel: r.resolve(IAddressValidationDTOBLL.self)!)
        return viewModel
    }.inObjectScope(.transient)
    //         Views
    container.storyboardInitCompleted(AddNewUserAddressViewController.self) { r, c in
        c.viewModel = r.resolve(IAddNewUserAddressViewModel.self)!
    }
    
    //BarCode
    container.register(IBarCodeViewModel.self) { _ in BarCodeViewModel() }
    
    //         Views
    container.storyboardInitCompleted(BarCodeViewController.self) { r, c in
        c.viewModel = r.resolve(IBarCodeViewModel.self)!
    }
    
    //Band Info
    container.register(IBaseFilterDTO.self) { _ in BaseFilterDTO() }
    container.register(IBrandDTODAL.self) { _ in BrandDTODAL() }
    container.register(IFacilityDTODAL.self) { _ in FacilityDTODAL() }
    container.register(ICuisinesDTODAL.self) { _ in CuisinesDTODAL() }
    container.register(IBaseOrderDTODAL.self) { _ in BaseOrderDTODAL() }
    //    container.register([IFacilityDTO].self) { _ in [BaseOrderDTO]() }
    
    //    container.register(IBrandHeaderInfoTableViewCellViewModel.self) { _ in BrandHeaderInfoTableViewCellViewModel() }
    
    container.register(IBrandHeaderInfoTableViewCellViewModel.self) { r in
        let viewModel = BrandHeaderInfoTableViewCellViewModel()
        return viewModel
    }.inObjectScope(.transient)
    
    //         Views
    container.register(IBrandInfoViewModel.self) { r in
        let viewModel = BrandInfoViewModel(apiClient: r.resolve(BrandServiceBLL.self)!)
        return viewModel
    }.inObjectScope(.transient)
    
    //         Views
    container.storyboardInitCompleted(BrandInfoViewController.self) { r, c in
        c.viewModel = r.resolve(IBrandInfoViewModel.self)!
        
    }
    
    //MARK:- Explore
    container.register(IServiceDTODAL.self) { _ in ServiceDTODAL() }
    container.register(IRequestBrandDTODAL.self) { _ in RequestBrandDTODAL() }
    container.register(IFilterationListDTODAL.self) { _ in FilterationListDTODAL() }
#warning("check from code")
//    container.register(IFilterationSectionDTODAL.self) { _ in FilterationSectionDTO() }
    
    container.register(IExploreViewModel.self) { r in
        let viewModel = ExploreViewModel(requestBrandDTO: r.resolve(IRequestBrandDTODAL.self)!, apiClient: r.resolve(BrandServiceBLL.self)!, userService: r.resolve(UserServiceBLL.self)!)
        return viewModel
    }.inObjectScope(.transient)
    
    //         Views
    container.storyboardInitCompleted(ExploreViewController.self) { r, c in
        c.viewModel = r.resolve(IExploreViewModel.self)!
    }
    
    //MARK:- Filteration
    container.register(IFilterationSectionDTODAL.self) { _ in FilterationSectionDTODAL() }
    
    container.register(IFilterationViewModel.self) { r in
        let viewModel = FilterationViewModel()
        return viewModel
    }.inObjectScope(.transient)
    
    //         Views
    container.storyboardInitCompleted(FilterationViewController.self) { r, c in
        c.viewModel = r.resolve(IFilterationViewModel.self)!
    }
    //MARK:- Sort In Explore
    
    container.register(ISortViewModel.self) { r in
        let viewModel = SortViewModel()
        return viewModel
    }.inObjectScope(.transient)
    
    //         Views
    container.storyboardInitCompleted(SortViewController.self) { r, c in
        c.viewModel = r.resolve(ISortViewModel.self)!
    }
    
    
    //MARK:;- Menu
    container.register(IChoiceDTODAL.self) { _ in ChoiceDTODAL() }
    container.register(IChoiceGroupsDTODAL.self) { _ in ChoiceGroupsDTODAL() }
    container.register(IMenuSizeDTODAL.self) { _ in MenuSizeDTODAL() }
    container.register(IMenuItemsDTODAL.self) { _ in MenuItemsDTODAL() }
    container.register(ICategoryMenuItemsDTODAL.self) { _ in CategoryMenuItemsDTODAL() }
    container.register(IRequestCategoryListDTODAL.self) { _ in RequestCategoryListDTODAL() }
    
    container.register(IMenuViewModel.self) { r in
        let viewModel = MenuViewModel(requestCategoryListDTO: r.resolve(IRequestCategoryListDTODAL.self)!, apiClient: r.resolve(MenuServiceBLL.self)!, cartService: r.resolve(CartServiceBLL.self)!)
        return viewModel
    }.inObjectScope(.transient)
    
    //         Views
    container.storyboardInitCompleted(MenuViewController.self) { r, c in
        c.viewModel = r.resolve(IMenuViewModel.self)!
    }
    
    
    //MARK:- Receipt
    container.register(IOrderItemDTODAL.self) { _ in OrderItemDTODAL() }
    container.register(IOrderItemChoiceDTODAL.self) { _ in OrderItemChoiceDTODAL() }
    container.register(IOrderDetailsDTODAL.self) { _ in OrderDetailsDTODAL() }
    container.register(IReceiptDTODAL.self) { _ in ReceiptDTODAL() }
    
    
    container.register(IReceiptViewModel.self) { r in
        let viewModel = ReceiptViewModel(apiClient: r.resolve(UserServiceBLL.self)!)
        return viewModel
    }.inObjectScope(.transient)
    
    //         Views
    container.storyboardInitCompleted(ReceiptViewController.self) { r, c in
        c.viewModel = r.resolve(IReceiptViewModel.self)!
    }
    
    //MARK:- CART
    container.register(ISTItemAttributeDTODAL.self) { _ in STItemAttributeDTODAL() }
    container.register(ISTCartItemDTODAL.self) { _ in STCartItemDTODAL() }
    container.register(ISTCheckoutOrderDTODAL.self) { _ in STCheckoutOrderDTODAL() }
    container.register(ICalOrderResponseDTODAL.self) { _ in CalOrderResponseDTODAL() }
    container.register(IOrderValidationDTOBLL.self) { _ in OrderValidationDTOBLL() }
    
    container.register(ISTCartViewModel.self) { r in
        let viewModel = STCartViewModel(cartService:  r.resolve(CartServiceBLL.self)!, orderService:  r.resolve(OrderServiceBLL.self)!,errorModel: r.resolve(IOrderValidationDTOBLL.self)!)
        return viewModel
    }.inObjectScope(.transient)
    
    //         Views
    container.storyboardInitCompleted(STCartViewController.self) { r, c in
        c.viewModel = r.resolve(ISTCartViewModel.self)!
    }
    
    //MARK:- ProductViewController
    container.register(IProductViewModel.self) { r in
        let viewModel = ProductViewModel(cartService:  r.resolve(CartServiceBLL.self)!)
        return viewModel
    }.inObjectScope(.transient)
    
    //         Views
    container.storyboardInitCompleted(ProductViewController.self) { r, c in
        c.viewModel = r.resolve(IProductViewModel.self)!
    }
    
    //MARK:- CheckoutViewController
    container.register(ICheckoutViewModel.self) { r in
        let viewModel = CheckoutViewModel(cartService: r.resolve(CartServiceBLL.self)!, orderService:  r.resolve(OrderServiceBLL.self)!,paymentService: r.resolve(STKashierService.self)!,errorModel: r.resolve(IOrderValidationDTOBLL.self)!, brandService: r.resolve(BrandServiceBLL.self)!)
        return viewModel
    }.inObjectScope(.transient)
    
    //         Views
    container.storyboardInitCompleted(CheckOutViewController.self) { r, c in
        c.viewModel = r.resolve(ICheckoutViewModel.self)!
    }
    //MARK:- RedeemViewController
    container.register(IRedeemViewModel.self) { r in
        let viewModel = RedeemViewModel()
        return viewModel
    }.inObjectScope(.transient)
    
    //         Views
    container.register(CartServiceBLL.self) { _ in CartUseCasesBLL() }
    container.storyboardInitCompleted(RedeemViewController.self) { r, c in
        c.viewModel = r.resolve(IRedeemViewModel.self)!
    }
    
    //MARK:- RateOrderViewController
    container.register(IRateOrderDTODAL.self) { _ in RateOrderDTODAL() }
    container.register(IBrandRatingItemDTODAL.self) { _ in BrandRatingItemDTODAL() }
    container.register(IBrandCategoryDTODAL.self) { _ in BrandCategoryDTODAL() }
    container.register(IRateOrderViewModel.self) { r in
        let viewModel = RateOrderViewModel(orderService: r.resolve(OrderServiceBLL.self)!)
        return viewModel
    }.inObjectScope(.transient)
    
    //         Views
    container.storyboardInitCompleted(RateOrderViewController.self) { r, c in
        c.viewModel = r.resolve(IRateOrderViewModel.self)!
    }
    
    //MARK:- NoTRatedOrderViewController
    container.register(INotRatedOrderViewModel.self) { r in
        let viewModel = NotRatedOrderViewModel(orderService: r.resolve(OrderServiceBLL.self)!)
        return viewModel
    }.inObjectScope(.transient)
    
    //         Views
    container.storyboardInitCompleted(NotRatedOrdersViewController.self) { r, c in
        c.viewModel = r.resolve(INotRatedOrderViewModel.self)!
    }
    /* CreditCardViewController */
    container.register(ISTKashierTokenDTODAL.self) { _ in STKashierTokenDTODAL() }
    container.register(ISTCartPaymentDTODAL.self) { _ in STCartPaymentDTODAL() }
    container.register(STKashierService.self) { _ in STKashierUseCase() }
    
    container.register(ICardDTODAL.self) { _ in CardDTODAL() }
    container.register(IConfirmPaymentDTODAL.self) { _ in ConfirmPaymentDTODAL() }
    container.register(IBrandPaymentDataDTODAL.self) { _ in BrandPaymentDataDTODAL() }
    container.register(ICreditCardValidationDTOBLL.self) { _ in CreditCardValidationDTOBLL() }
    
    container.register(ICreditCardViewModel.self) { r in
        let viewModel = CreditCardViewModel(cardData:r.resolve(ICardDTODAL.self)!,apiClient: r.resolve(PaymentServiceBLL.self)!,errorModel: r.resolve(ICreditCardValidationDTOBLL.self)!,kashierService: r.resolve(STKashierService.self)!)
        return viewModel
    }.inObjectScope(.transient)
    
    //         Views
    container.storyboardInitCompleted(CreditCardViewController.self) { r, c in
        c.viewModel = r.resolve(ICreditCardViewModel.self)!
    }
     /* ImageZoomingViewController */
        container.storyboardInitCompleted(ImageZoomingViewController.self) { r, c in
    }
    /* OrderTypeViewController */
      container.register(IOrderTypeDTODAL.self) { _ in OrderTypeDTODAL() }
      
      container.register(IOrderTypeViewModel.self) { r in
          let viewModel = OrderTypeViewModel()
          return viewModel
      }.inObjectScope(.transient)
      
      //         Views
      container.storyboardInitCompleted(OrderTypeViewController.self) { r, c in
          c.viewModel = r.resolve(IOrderTypeViewModel.self)!
      }
    /* CountryLisV*/
    container.register(ICountryDTODAL.self) { _ in CountryDTODAL() }
    
    container.register(ICountryListViewModel.self) { r in
        let viewModel = CountryListViewModel(apiClient: r.resolve(CountryServiceBLL.self)!)
        return viewModel
    }.inObjectScope(.transient)
    
    //         Views
    container.storyboardInitCompleted(CountryListViewController.self) { r, c in
        c.viewModel = r.resolve(ICountryListViewModel.self)!
    }
}
