//
//  MapController.swift
//  compa
//
//  Created by m2sar on 12/04/2018.
//  Copyright © 2018 m2sar. All rights reserved.
//

import UIKit
import MapKit


class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    let regionRadius: CLLocationDistance = 1000
    let locationManager = CLLocationManager()
    @IBOutlet weak var map: MKMapView!
    
<<<<<<< HEAD
    static let dateFormatter = { () -> DateFormatter in
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss" //TODO Determine format of date string
=======
    
    let repo = UserRepository()
    
    static let dateFormatter = { () -> DateFormatter in
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
>>>>>>> 9d6a185ce5f5cad5fdc1ee2bc72f1b218c58881a
        return dateFormatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        map.showsUserLocation = true
        locationManager.delegate = self
        map.delegate = self
        
        locationManager.requestWhenInUseAuthorization()
<<<<<<< HEAD
        
        let locations = User.getMockLocationsFor(CLLocation(latitude:51.509865, longitude:-0.118092))
        
        /*locations = locations.sorted(by: {
            return $0.0 > $1.0
        })

        print(locations)*/
        
        
        for (date, location) in locations {
            let annotation = MKPointAnnotation()
            annotation.coordinate = location.coordinate
            annotation.title = MapViewController.dateFormatter.string(from:date)
            map.addAnnotation(annotation)
        }
        
=======
    }
    
    override func viewDidAppear(_ animated: Bool){

        repo.getFriends { data in
            //check error
            
          
            DispatchQueue.main.async(execute: {
                
                for user in data {
                    
                    let lastLocation = CLLocationCoordinate2D(latitude: user.lastLocation.latitude, longitude: user.lastLocation.longitude)
                    
                    print(lastLocation)
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = lastLocation
                    annotation.title = user.name
                    self.map.addAnnotation(annotation)
                }
                
            })
            
        }

    }
    
    
    @IBAction func centerTapped(_ sender: Any) {
        map.setCenter(CLLocationCoordinate2D(latitude: map.userLocation.coordinate.latitude, longitude: map.userLocation.coordinate.longitude), animated: false)
>>>>>>> 9d6a185ce5f5cad5fdc1ee2bc72f1b218c58881a
    }
    
    /*func test(){
        
        let sourceLocation = CLLocationCoordinate2D(latitude: 40.759011, longitude: -73.984472)
        let sourcePlacemark = MKPlacemark(coordinate: sourceLocation, addressDictionary: nil)
        let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
        let sourceAnnotation = MKPointAnnotation()
        if let location = sourcePlacemark.location {
            sourceAnnotation.coordinate = location.coordinate
        }
        
        
        let destinationLocation = CLLocationCoordinate2D(latitude: 40.748441, longitude: -73.985564)
        let destinationPlacemark = MKPlacemark(coordinate: destinationLocation, addressDictionary: nil)
        let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
        let destinationAnnotation = MKPointAnnotation()
        if let location = destinationPlacemark.location {
            destinationAnnotation.coordinate = location.coordinate
        }
        
        //self.map.showAnnotations([sourceAnnotation,destinationAnnotation], animated: true )
        
        let directionRequest = MKDirectionsRequest()
        directionRequest.source = sourceMapItem
        directionRequest.destination = destinationMapItem
        directionRequest.transportType = .automobile
        let directions = MKDirections(request: directionRequest)
        
        directions.calculate {
            (response, error) -> Void in
            
            guard let response = response else {
                if let error = error {
                    print("Error: \(error)")
                }
                
                return
            }
            
            let route = response.routes[0]
            self.map.add((route.polyline), level: MKOverlayLevel.aboveRoads)
            
            let rect = route.polyline.boundingMapRect
            self.map.setRegion(MKCoordinateRegionForMapRect(rect), animated: true)
        }
        
    }*/
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /*func mapView(aMapView: MKMapView!, viewForAnnotation annotation: CustomMapPinAnnotation!) -> MKAnnotationView! {
        
    }*/
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
            case .restricted, .denied:
                alert("why not :(")
                break
            
            case .authorizedWhenInUse,.authorizedAlways:
                locationManager.requestLocation()
                break
            
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
                break
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        print("update location")
        print(locations)
        //centerMapOnLocation(location: locations[locations.count], regionRadius: regionRadius)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error){
        print("failed update location")
        alert(error.localizedDescription)
    }
    
    private func alert(_ userMessage:String, handler: ((UIAlertAction) -> Void)? = nil){
        let myAlert = UIAlertController(title:"Alert", message:userMessage, preferredStyle: UIAlertControllerStyle.alert);
        myAlert.addAction(UIAlertAction(title:"Ok", style:UIAlertActionStyle.default, handler: handler));
        self.present(myAlert, animated:true, completion:nil);
    }
    
    private func centerMapOnLocation(location: CLLocation, regionRadius: CLLocationDistance) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius, regionRadius)
        map.setRegion(coordinateRegion, animated: true)
    }
    
}
