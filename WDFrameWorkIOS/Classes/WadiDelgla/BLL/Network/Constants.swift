//
//  Constants.swift
//  Netwroking
//
//  Created by SimpleTouch on 9/22/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation

public struct KBLL {

    struct APIParameterKey {
        static let id = "Id"
        static let code = "Code"
        static let firstName = "FirstName"
        static let lastName = "LastName"
        static let mobile = "Mobile"
        static let email = "Email"
        static let password = "Password"
        static let gender = "Gender"
        static let mobileAppToken = "MobileAppToken"
        static let CustomerSourceID = "CustomerSourceID"
        static let customerSourceID = "customerSourceID"
        static let brandId = "BrandID"
        static let shareCode = "ShareCode"
        static let language = "Lang"
        static let userName = "username"
        static let verfingCode = "VerfingCode"
        static let newPassword = "NewPassword"
        static let birthDay = "Birthday"
        static let birthMonth = "Birthmonth"
        static let newUserPassword = "NewUserPassword"
        static let pageSize = "pageSize"
        static let pageNumber = "pageNumber"
        static let qr = "QR"
        static let latitude = "latitude"
        static let longitude = "longitude"
        static let areaId = "AreaID"
        static let buildingNo = "BuildingNo"
        static let cityID = "CityID"
        static let companyName = "CompanyName"
        static let description = "Description"
        static let streetName = "StreetName"
        static let floorNo = "FloorNo"
        static let cart = "cart"
        static let transactionId = "TransactionId"
        static let merchanOrderId = "MerchanOrderId"
        static let orderId = "OrderId"
        static let status = "Status"
        static let countryCode = "CountryCode"
        static let frontOrderReferenceId = "FrontOrderReferenceId"
        static let referencePaymentId = "ReferencePaymentId"
        static let referenceTransactionId = "ReferenceTransactionId"
        static let referenceInvoiceId = "ReferenceInvoiceId"
        static let customerHistoryId = "CustomerHistoryId"
        
    }
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
    case X_Dobites_Country_Id = "X-Dobites-Country-Id"
}

enum ContentType: String {
    case json = "application/json; charset = utf-8"
}
