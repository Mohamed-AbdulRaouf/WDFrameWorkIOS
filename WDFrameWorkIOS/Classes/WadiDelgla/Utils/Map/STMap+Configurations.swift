//
//  STMap+Configurations.swift
//  STDobites
//
//  Created by Nermeen Mohamed on 10/30/19.
//  Copyright © 2019 SimpleTouch. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
//import DAL
enum MapType: String {
    case google = "Google"
    case apple = "apple"
}
class MapController : STUIViewController,IMap{
    
    typealias K = IBrandLocationDTODAL
    
    var locationManager = CLLocationManager()
    let regionRadius: CLLocationDistance = 1000
    let authorizationStatus = CLLocationManager.authorizationStatus()
    var mapView: MKMapView!
    var selectedMap: MapType?
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        mapView = MKMapView()
        
        let leftMargin:CGFloat = 10
        let topMargin:CGFloat = 0
        let mapWidth:CGFloat = view.frame.size.width-20
        let mapHeight:CGFloat = self.view.frame.height
        
        mapView.frame = CGRect(x: leftMargin, y: topMargin, width: mapWidth, height: mapHeight)
        
        mapView.mapType = MKMapType.standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        
        // Or, if needed, we can position map in the center of the view
        mapView.center = view.center
        
        view.addSubview(mapView)
        self.mapView.delegate = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkLocationAuthorizationStatus()
        mapView.fitAll()
    }
    
    func removeAllPins() {
        for annotation in mapView.annotations {
            mapView.removeAnnotation(annotation)
        }
    }
    
    func dropPins(_ locations: [IBrandLocationDTODAL]) {
        removeAllPins()
        let validWorks = locations.compactMap { ArtworkDAL(brand: $0) }
        mapView.addAnnotations(validWorks)
    }
    
    func zoomtoLocation() {
        //Zoom to user location
        if let userLocation = locationManager.location?.coordinate {
            //            guard  self.brandLocations.count > 0 else {return}
            let viewRegion = MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2D(latitude: userLocation.latitude , longitude: userLocation.longitude ), regionRadius * 5, regionRadius * 5)
            mapView.setRegion(viewRegion, animated: true)
            let coordinatesOfPoints = CLLocationCoordinate2DMake(userLocation.latitude, userLocation.longitude)
            let annotation = droppablePiDALn(coordinate: coordinatesOfPoints,title: R.string.localizable.yourLocation(), identifier: "droppablePin")
            mapView.addAnnotation(annotation)
            
        }
        
        
        DispatchQueue.main.async {
            self.locationManager.startUpdatingLocation()
        }
    }
    
    
    
}
extension MapController: MKMapViewDelegate {
    // 1
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // 2
        guard let annotation = annotation as? ArtworkDAL else { return nil }
        // 3
        let identifier = "marker"
        var view: MKMarkerAnnotationView
        // 4
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            // 5
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return view
    }
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView,
                 calloutAccessoryControlTapped control: UIControl) {
//        let location = view.annotation as! Artwork
//        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
//        location.mapItem().openInMaps(launchOptions: launchOptions)
    }
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView)
    {
        if let annotationTitle = view.annotation?.title
        {
            guard  selectedMap == nil else {
                if selectedMap == .apple {
                    self.openWithAppleMap(coordinate: view.annotation!.coordinate, withannotationTitle: annotationTitle ?? "")
                }else{
                    let coordinate = view.annotation?.coordinate
                    //google map
                    self.openWithGoogleMap(latitude: coordinate?.latitude, longitude: coordinate?.longitude)
                }
                return
            }
            let alert = UIAlertController(title: "\(R.string.localizable.show_direction_msg()) \(annotationTitle!)?", message: nil, preferredStyle: .alert)
            let appleMapAction = UIAlertAction(title: R.string.localizable.show_on_apple_map(), style: .default, handler: { (action) in
                self.selectedMap = .apple
                self.openWithAppleMap(coordinate: view.annotation!.coordinate, withannotationTitle: annotationTitle ?? "")
            })
            let googleMapAction = UIAlertAction(title: R.string.localizable.show_on_google_map(), style: .default, handler: { (action) in
                self.selectedMap = .google
                let coordinate = view.annotation?.coordinate
                //google map
                
                self.openWithGoogleMap(latitude: coordinate?.latitude, longitude: coordinate?.longitude)
               
            })
            let cancelAction = UIAlertAction(title: R.string.localizable.cancel(), style: .default, handler: { (action) in
                /* Just do nothing for now */
            })
            alert.addAction(appleMapAction)
            if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!))
            {
                alert.addAction(googleMapAction)
            }
           
            alert.addAction(cancelAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    func openWithGoogleMap(latitude:Double?,longitude:Double?) {
        UIApplication.shared.openURL(NSURL(string:
                                            "comgooglemaps://?saddr=&daddr=\(Float(latitude ?? 0)),\(Float(longitude ?? 0))&directionsmode=driving")! as URL)
    }
    func openWithAppleMap(coordinate: CLLocationCoordinate2D,withannotationTitle annotationTitle: String) {
        let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate, addressDictionary:nil))
        mapItem.name = annotationTitle
        mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving])
    }
    /*
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView)
    {
        if let annotationTitle = view.annotation?.title
        {
            print("User tapped on annotation with title: \(annotationTitle!)")
            let alert = UIAlertController(title: "\(R.string.localizable.show_direction_msg()) \(annotationTitle!)?", message: nil, preferredStyle: .alert)
            let yesAction = UIAlertAction(title: R.string.localizable.yes(), style: .default, handler: { (action) in
                let coordinate = view.annotation?.coordinate
                let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate!, addressDictionary:nil))
                mapItem.name = annotationTitle
                mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving])
            })
            let noAction = UIAlertAction(title: R.string.localizable.no(), style: .default, handler: { (action) in
                /* Just do nothing for now */
            })
            alert.addAction(yesAction)
            alert.addAction(noAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    */
}
extension MapController: CLLocationManagerDelegate {
    func checkLocationAuthorizationStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            mapView.showsUserLocation = false
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
}


