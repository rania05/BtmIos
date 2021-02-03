//
//  MapViewController.swift
//  btm
//
//  Created by imen manai on 12/10/20.
//  Copyright © 2020 ESPRIT. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Alamofire


class MapViewController: UIViewController  , CLLocationManagerDelegate ,  MKMapViewDelegate{
    @IBOutlet weak var map: MKMapView!
    let locationManager = CLLocationManager()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.locationManager.requestAlwaysAuthorization()

            // For use in foreground
            self.locationManager.requestWhenInUseAuthorization()
        


            if CLLocationManager.locationServicesEnabled() {
                locationManager.delegate = self
                locationManager.desiredAccuracy = kCLLocationAccuracyBest
                locationManager.startUpdatingLocation()
            }

        map.delegate = self
        map.mapType = .standard
        map.isZoomEnabled = true
        map.isScrollEnabled = true
        self.map.showsUserLocation = true

            if let coor = map.userLocation.location?.coordinate{
                map.setCenter(coor, animated: true)
            }

        // Do any additional setup after loading the view.
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate

        map.mapType = MKMapType.standard

        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: locValue, span: span)
        map.setRegion(region, animated: true)

        let annotation = MKPointAnnotation()
        annotation.coordinate = locValue
        annotation.title = "You are here"
        annotation.subtitle = "current location"
        map.addAnnotation(annotation)

        //centerMap(locValue)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
