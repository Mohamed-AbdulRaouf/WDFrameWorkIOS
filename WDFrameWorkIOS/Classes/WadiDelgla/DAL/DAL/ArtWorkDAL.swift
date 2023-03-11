//
//  ArtWork.swift
//  DAL
//
//  Created by Nermeen Mohamed on 10/30/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import Foundation
import MapKit
import Contacts
import Bond
public class ArtworkDAL: NSObject, MKAnnotation,IArtWorkDAL {
    public var coordinate: CLLocationCoordinate2D
    
    public var  title: String?
    
    public var subtitle: String?
    
    public var locationName: Observable<String?> = Observable<String?>(nil)
    
    public  var discipline: Observable<String?> = Observable<String?>(nil)
    


    public override init(){
        self.coordinate = CLLocationCoordinate2D(latitude: 0, longitude: 0)
        super.init()
    }
    
    init(title: String, locationName: String, discipline: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.locationName.value = locationName
        self.discipline.value = discipline
        self.coordinate = coordinate
        
        super.init()
    }
   public  init(brand: IBrandLocationDTODAL) {
        
        self.coordinate =  CLLocationCoordinate2D(latitude: brand.latitude.value ?? 0.0, longitude:  brand.longitude.value ?? 0.0)
        self.title =  brand.brandName.value ?? ""
        self.subtitle = brand.name.value ?? ""
        self.locationName.value = brand.name.value ?? ""
        self.discipline.value = "Sculpture"
    }
    
    // Annotation right callout accessory opens this mapItem in Maps app
    public func mapItem() -> MKMapItem {
        let addressDict = [CNPostalAddressStreetKey: subtitle!]
        let placemark = MKPlacemark(coordinate: coordinate , addressDictionary: addressDict)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = title
        return mapItem
    }
}
