//
//  UserAddressDTO.swift
//  DAL
//
//  Created by Nermeen Mohamed on 11/3/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//
import Foundation
import Bond
//import SwiftyJSON
public class UserAddressDTODAL :IUserAddressDTODAL{
    
    public var id: Observable<Int?> = Observable<Int?>(nil)
    
    public var countryId: Observable<Int?> = Observable<Int?>(nil)
    
    public var cityId: Observable<Int?> = Observable<Int?>(nil)
    
    public var cityCode: Observable<Int?> = Observable<Int?>(nil)
    
    public var areaId: Observable<Int?> = Observable<Int?>(nil)
    
    public var buildingNo: Observable<String?> = Observable<String?>(nil)
    
    public var floorNo: Observable<String?> = Observable<String?>(nil)
    
    public var countryCode: Observable<String?> = Observable<String?>(nil)
    
    public var companyName: Observable<String?> = Observable<String?>(nil)
    
    public var countryName: Observable<String?> = Observable<String?>(nil)
    
    public var cityName: Observable<String?> = Observable<String?>(nil)
    
    public var areaName: Observable<String?> = Observable<String?>(nil)
    
    public var streetName: Observable<String?> = Observable<String?>(nil)
    
    public var addressDescription: Observable<String?> = Observable<String?>(nil)
    
    public var isAddressValidToUpdate: Observable<Bool?> = Observable<Bool?>(nil)
    
    public var addressIndex: Observable<Int?> = Observable<Int?>(nil)
    
    public var brandId: Observable<Int?> = Observable<Int?>(nil)
    
    public var longitude: Observable<Double?> = Observable<Double?>(nil)
    
    public var latitude: Observable<Double?> = Observable<Double?>(nil)
    
    public var addressDetailsText: String = ""
    public init(){}
    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case countryId = "CountryID"
        case cityId = "CityID"
        case cityCode = "CityCode"
        case areaId = "AreaID"
        case buildingNo = "BuildingNo"
        case floorNo = "FloorNo"
        case countryCode = "CountryCode"
        case companyName = "CompanyName"
        case counrtyName = "CountryName"
        case cityName = "CityName"
        case areaName = "AreaName"
        case streetName = "StreetName"
        case addressDescription = "Description"
        case isAddressValidToUpdate = "IsAddressValidToUpdate"
        case brandId = "BrandId"
        case longitude = "Longitude"
        case latitude = "Latitude"
    }
    public init(country:String,city:String,area:String,street:String,lat:Double,long:Double) {
        self.countryName.value = country
        self.cityName.value = city
        self.streetName.value = street
        self.latitude.value = lat
        self.longitude.value = long
        
    }
    public init(json:JSON)   {
        self.id.value = json[CodingKeys.id.rawValue].intValue
        self.countryId.value = json[CodingKeys.countryId.rawValue].intValue
        self.cityId.value = json[CodingKeys.cityId.rawValue].intValue
        self.cityCode.value = json[CodingKeys.cityCode.rawValue].intValue
        self.areaId.value = json[CodingKeys.areaId.rawValue].intValue
        self.buildingNo.value = json[CodingKeys.buildingNo.rawValue].stringValue
        self.floorNo.value = json[CodingKeys.floorNo.rawValue].stringValue
        self.countryCode.value = json[CodingKeys.countryCode.rawValue].stringValue
        self.companyName.value = json[CodingKeys.companyName.rawValue].stringValue
        self.countryName.value = json[CodingKeys.counrtyName.rawValue].stringValue
        self.cityName.value = json[CodingKeys.cityName.rawValue].stringValue
        self.areaName.value = json[CodingKeys.areaName.rawValue].stringValue
        self.streetName.value = json[CodingKeys.streetName.rawValue].stringValue
        self.addressDescription.value = json[CodingKeys.addressDescription.rawValue].stringValue
        self.isAddressValidToUpdate.value = json[CodingKeys.isAddressValidToUpdate.rawValue].boolValue
        self.addressIndex.value = 0
        self.brandId.value = json[CodingKeys.brandId.rawValue].intValue
        self.latitude.value = json[CodingKeys.latitude.rawValue].doubleValue
        self.longitude.value = json[CodingKeys.longitude.rawValue].doubleValue
        self.handleAddressDetails()
    }
    func handleAddressDetails() {
        if let floorNo = self.floorNo.value,floorNo != "" {
            addressDetailsText += "\(floorNo) ,"
        }
        if let buildingNo = self.buildingNo.value,buildingNo != "" {
            addressDetailsText += "\(buildingNo) ,"
        }
        if let streetName = self.streetName.value,streetName != "" {
            addressDetailsText += "\(streetName) ,"
        }
        if let areaName = self.areaName.value ,areaName != ""{
            addressDetailsText += "\(areaName) ,"
        }
        if let addressDescription = self.addressDescription.value, addressDescription != "" {
            addressDetailsText += "\(addressDescription) ,"
        }
        if let companyName = self.companyName.value,companyName != "" {
            addressDetailsText += "\(companyName) ,"
        }
        if let cityName = self.cityName.value,cityName != "" {
            addressDetailsText += "\(cityName) ,"
        }
        if let countryName = self.countryName.value,countryName != "" {
            addressDetailsText += "\(countryName) "
        }
    }
    
}
