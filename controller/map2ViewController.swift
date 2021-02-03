//
//  map2ViewController.swift
//  BTMFINAL
//
//  Created by imen manai on 12/17/20.
//

import UIKit
import MapKit
import CoreLocation
import Alamofire
class map2ViewController: UIViewController, CLLocationManagerDelegate ,  MKMapViewDelegate{
    @IBOutlet weak var textFieldForAdress: UITextField!
    
    @IBOutlet weak var getDirectionButton: UIButton!
    @IBOutlet weak var map2: MKMapView!
    var locationManager = CLLocationManager()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      

                locationManager.delegate = self
                locationManager.desiredAccuracy = kCLLocationAccuracyBest
                locationManager.startUpdatingLocation()
        self.locationManager.requestAlwaysAuthorization()

            // For use in foreground
            self.locationManager.requestWhenInUseAuthorization()
        


        map2.delegate = self
        

        // Do any additional setup after loading the view.
    }
    
    @IBAction func getDirectionTapped(_ sender: Any) {
        getAddress()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
   print(locations)

        //centerMap(locValue)
    }
    
func getAddress ()
{
    let geoCoder = CLGeocoder()
    geoCoder.geocodeAddressString(textFieldForAdress.text!)
    {(placemarks,error) in
        guard let placemarks = placemarks , let location = placemarks.first?.location
        else {
            print("no location found")
            return
        }
        print(location)
        self.mapThis(destinationCord: location.coordinate)
    }
}
    func mapThis (destinationCord : CLLocationCoordinate2D )
    {
        let sourceCordinate  = (locationManager.location?.coordinate)!
        let sourcePlaceMark  = MKPlacemark (coordinate: sourceCordinate )
        let destPlaceMark = MKPlacemark (coordinate: destinationCord)
        let sourceItem = MKMapItem (placemark: sourcePlaceMark)
        let destItem  = MKMapItem (placemark: destPlaceMark)
        let destinationRequest  = MKDirections.Request()
        destinationRequest.source = sourceItem
        destinationRequest.destination = destItem
        destinationRequest.transportType = .automobile
        destinationRequest.requestsAlternateRoutes = true
        let directions = MKDirections(request :destinationRequest)
        directions.calculate  {
            (response,error) in
            guard let response = response else {
                if let error = error {
              print("something is wrong")
                }
                return
            }
            let route = response.routes[0]
            self.map2.addOverlay(route.polyline)
            self.map2.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
            
        }
        
    }
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let render = MKPolylineRenderer(overlay: overlay as! MKPolyline)
        render.strokeColor = .blue
        return render
    }
    

      
    }
    

