//
//  ViewController.swift
//  appMapsTest
//
//  Created by nicolasdeT on 02/03/2017.
//  Copyright © 2017 nicolasdeT. All rights reserved.
//

import UIKit
import MapKit

class MapController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet var mapView: MKMapView?
 

    @IBAction func showMeWhere(_ sender: Any) {

    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer
    {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.red
        renderer.lineWidth = 4.0
        
        return renderer
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        print("idde lacomamnde ")
        print(User.id_commande)
        print("adresse de la commande")
        print(User.adresse)
        
        let address = User.adresse
        let geocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(address, completionHandler: {(placemarks, error) -> Void in
            if((error) != nil){
                print("Error")
            }
            if let placemark = placemarks?.first {
                self.mapView?.showsUserLocation = true
                self.mapView?.showsCompass = true
                self.mapView?.showsScale = true
                self.mapView?.mapType = .standard
                // Coordonnées de départ
                let coordonneesDepart = CLLocationCoordinate2D(latitude: 48.851630, longitude: 2.286597)
                let pointDepart = MKPointAnnotation()
                pointDepart.coordinate = coordonneesDepart
                pointDepart.title = "ECE-Tech"
                self.mapView?.addAnnotation(pointDepart)
                // Coordonnées de d'arrivée
                let coordonneesArrivee:CLLocationCoordinate2D = placemark.location!.coordinate
                print("Coordonnées :")
                print(coordonneesArrivee)
                let regionRadius: CLLocationDistance = 500
                let coordinateRegion = MKCoordinateRegionMakeWithDistance(coordonneesArrivee, regionRadius * 2.0, regionRadius * 2.0)
                
                let pointArrivee = MKPointAnnotation()
                pointArrivee.coordinate = coordonneesArrivee
                pointArrivee.title = address
                self.mapView?.addAnnotation(pointArrivee)
                self.mapView?.setRegion(coordinateRegion, animated: true)
                // Calcul du trajet
                let sourcePlacemark = MKPlacemark(coordinate: coordonneesDepart, addressDictionary: nil)
                let destinationPlacemark = MKPlacemark(coordinate: coordonneesArrivee, addressDictionary: nil)
                let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
                let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
                let directionRequest = MKDirectionsRequest()
                directionRequest.source = sourceMapItem
                directionRequest.destination = destinationMapItem
                let directions = MKDirections(request: directionRequest)
                directions.calculate {
                    (response, error) -> Void in
                    
                    guard let response = response else {
                        if let error = error {
                            print("Error: \(error)")
                        }
                        
                        return
                    }
                    
                    if let route = response.routes.first
                    {
                        self.mapView?.add((route.polyline), level: MKOverlayLevel.aboveRoads)
                    
                        let rect = route.polyline.boundingMapRect
                        self.mapView?.setRegion(MKCoordinateRegionForMapRect(rect), animated: true)
                    
                  
                    }
                }
            }
        })
        
        
        let locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        

        
        //mapView?.mapType = MKMapTypeSatellite;
        
        print(mapView?.userLocation.coordinate.latitude)
        print(mapView?.userLocation.coordinate.longitude)
 
       // centerMapOnLocation(location: initialLocation)
            
        }
    
}


