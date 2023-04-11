//
//  ServerPaths.swift
//  Netwroking
//
//  Created by SimpleTouch on 9/22/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
public enum ServerPathsBLL: String {
    //User Authentication
    case LOGIN = "https://wdorderonlineapi.azurewebsites.net/api/Loyalty/CustomerApp/Login"
    case REGISTER = "api/Loyalty/CustomerApp/Register"
    case RESEND_VERIFY_CODE = "api/Loyalty/CustomerApp/ResendVerifyCode"
    case CHECK_VERIFICATION_CODE = "api/Loyalty/CustomerApp/CheckMobileVerfingCode/"
    case VERIFY_NEW_PASSWORD = "api/Loyalty/CustomerApp/NewPasswordVerify"
    case UPDATE_USER = "api/Loyalty/CustomerApp/UpdateCustomerApp/"
    case UPDATE_PASSWORD = "api/Loyalty/CustomerApp/ChangeCustomerAppPassword/"
    case UPDATE_MOBILE_TOKEN = "api/Loyalty/CustomerApp/UpdateMobileToken"
    case GET_TOP_RATED_CUSTOMERS = "api/Loyalty/CustomerApp/GetTopRatedReferrals"
    case CUSTOMER_GAIN_REWARD_QR = "api/Loyalty/CustomerApp/CustomerGainReward/"
    case REGISTER_TO_BRAND_BY_REFERRAL_CODE = "api/Loyalty/CustomerApp/RegisterToBrand"
    case GET_PREVIOUS_ORDERS = "api/Loyalty/CustomerApp/GetCustomerPreviousOrders/"
    case GET_CUSTOMER_ADDRESSES = "api/Loyalty/CustomerApp/GetCustomeraddresses"
    case GET_CUSTOMER_ADDRESSES_BY_AREAId = "api/Loyalty/CustomerApp/GetCustomeraddressesByAreaID/"
    case ADD_ADDRESS = "api/Loyalty/CustomerApp/AddAddress"
    case UPDATE_ADDRESS = "api/Loyalty/CustomerApp/UpdateAddress"
    case GET_CUSTOMER_PREVIOUS_ORDER_DETAILS = "api/Loyalty/CustomerApp/GetCustomerPreviousOrderDetails/"
    case REGISTER_USER_IN_BRAND = "api/Loyalty/CustomerApp/GetRegisterCustomerInBrandApp/"
    case GET_NOT_RATED_ORDER = "api/Loyalty/CustomerApp/GetNotRatedOrders/"
    case GET_USER = "api/Loyalty/CustomerApp/GetCustomerData/"
    case VALIDATE_CUSTOMER  = "api/Loyalty/CustomerApp/ValidateCustomer/"
    //location
    case GET_CITIES_AREAS = "api/Loyalty/BrandApp/GetCitiesAndAreas/"
    //Brand
    case GET_ADS_LIST = "api/Loyalty/BrandApp/GetAdsListApp/"
    case GET_BRANCHES_NEAR_BY =  "api/Loyalty/BrandApp/GetBranchsNearBy/"
    case GET_BRANDS_NOTIFICATIONS = "api/Loyalty/BrandApp/GetBrandsNotificationAppByCustomerID/"
    case GET_BRAND_NOTIFICATIONS = "api/Loyalty/BrandApp/GetBrandNotification/"
    case REMOVE_NOTIFICATION = "api/Loyalty/BrandApp/DeleteBrandNotification/"
    case READ_NOTIFICATION = "api/Loyalty/BrandApp/ReadBrandNotification/"
    case GET_BRAND_INFO_BY_ID = "api/Loyalty/BrandApp/GetBrandInfoByID/"
    case GET_BRAND_LOCATION_BY_AREA_ID = "api/Loyalty/BrandApp/GetBrandLocations/"
//    case BET_BRAND_SERVICES = "api/Loyalty/BrandApp/GetSortAndFilterBrandApp/"
    case GET_BRAND_LIST = "api/Loyalty/BrandApp/GetBrandsListByArea"
    case GET_BRAND_FILTERATION_LIST = "api/Loyalty/BrandApp/GetSortAndFilterBrandApp/"
    case GET_BRANDS_NOTIFICATION_COUNT = "api/Loyalty/BrandApp/GetBrandsNotificationAppCount"
    case GET_BRAND_BRANCHES = "api/Loyalty/BrandApp/GetBrandBranchs/"
    //menu items
    case GET_MENU_ITEMS = "api/Loyalty/MenuItemApp/GetAllMenuItemsApp"
    case GET_MENU_CATEGORIES = "api/Loyalty/MenuItemApp/GetCategoriesApp/"
    /* Order */
    case CALC_ORDER = "api/Loyalty/OrderApp/CalcOrder/"
    case CHECKOUT = "api/Loyalty/OrderApp/CheckOut"
    case MAKE_ORDER = "api/Loyalty/OrderApp/MakeOrder"
    case GET_ORDER_RATE = "api/Loyalty/OrderApp/GetOrderRate"
    case RATE_ORDER = "api/Loyalty/OrderApp/RateOrder"
    case CONFIRM_ONLINE_PAYMENT_FOR_ORDER = "api/Loyalty/OrderApp/ConfirmOnLinePaymentForOrder"
    case GET_ORDER_BY_FRONT_REFERENCE = "api/Loyalty/OrderApp/GetOrderByFrontReference"
    case CONFIRM_ONLINE_PAYMENT_FOR_ORDER_MY_FATOORAH = "api/Loyalty/OrderApp/ConfirmOnLinePaymentForOrderMyFatoorah"
    case phoneActivation = "phone_activation"
    case resendPhoneActivation = "resend_phone_activation_code"
    case resendEmailLink = "send_reset_link_email"
    case resetPassword = "reset_password"
    case userInfo = "get_account_info"
    case updateInfo = "update_account_info"
    case userBalance = "get_user_internal_balance"
    case search
    
    /* Error Messages */
    case GET_ERROR_MESSAGES = "api/Loyalty/ErrorMessages/GetErrorMessages"
    /* Payment */
    case GET_BRAND_PAYMENT_DATA = "api/Loyalty/BrandApp/GetBrandPaymentData/"
    case GET_MY_FATOORAH_BRAND_PAYMENT_DATA = "api/Loyalty/BrandApp/GetMyFatoorahBrandPaymentData/"
    /* Country */
//    case GET_AVAILABLE_COUNTRIES = "api/Loyalty/CountryApp/GetAvailableCountries/"
    case GET_ALL_AVAILABLE_COUNTRIES = "api/Loyalty/CountryApp/GetAllAvailableCountries/"
    case GET_BRAND_AVAILABLE_COUNTRIES = "api/Loyalty/CountryApp/GetBrandAvailableCountries/"
}
