//
//  droppablePin.swift
//  DoBites
//
//  Created by Nermeen Mohdamed. on 8/27/18.
//  Copyright © 2018 Nermeen Mohdamed.. All rights reserved.
//

import UIKit
import MapKit

public class droppablePiDALn: NSObject , MKAnnotation{
    dynamic public var coordinate: CLLocationCoordinate2D
    public var title: String?
    public var identifier: String
    
   public init(coordinate: CLLocationCoordinate2D, title: String, identifier: String) {
        self.coordinate = coordinate
        self.title = title
        self.identifier = identifier
        super.init()
    }

}
