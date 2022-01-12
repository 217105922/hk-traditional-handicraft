//
//  MapViewController.swift
//  hk traditional handicraft
//
//  Created by peter lam on 10/1/2022.
//

import UIKit
import MapKit
import CoreLocation
import CoreData
class MapViewController: UIViewController, CLLocationManagerDelegate {

    var annotations = [MKPointAnnotation]();
    var locationManager : CLLocationManager?
    
    @IBOutlet weak var mapView : MKMapView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if CLLocationManager.locationServicesEnabled() { //Lab exercise
               self.locationManager = CLLocationManager();
               self.locationManager?.delegate = self;
               if CLLocationManager.authorizationStatus() != .authorizedAlways {
                   self.locationManager?.requestAlwaysAuthorization();
               }
       else {
                   self.setupAndStartLocationManager();
               }
            
            
       }
    }
    
        //for in-app authorization event
        func locationManager(_ manager: CLLocationManager,
                             didChangeAuthorization status: CLAuthorizationStatus) { //Labexercise
            if status == .authorizedAlways {
                self.setupAndStartLocationManager();
            }
        }
        
        func setupAndStartLocationManager(){
            self.locationManager?.desiredAccuracy = kCLLocationAccuracyBest;//Lab exercise
            self.locationManager?.distanceFilter = kCLDistanceFilterNone;//Lab exercise
            self.locationManager?.startUpdatingLocation();//Lab exercise
            checkNearby()
        }
        
        
    func locationManager(_ manager: CLLocationManager,
                                didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01);
            let coord = location.coordinate;
            let region = MKCoordinateRegion(center: coord, span: span)
            self.mapView?.setRegion(region, animated: false);
    } }
        
    
    func checkNearby(){
        
        let center = CLLocationCoordinate2D(latitude: 22.302711, longitude: 114.177216) //check shop is nearby or not
        
        
        
        if CLLocationManager.authorizationStatus() == .authorizedAlways {
            // Make sure region monitoring is supported.
            if CLLocationManager.isMonitoringAvailable(for: CLCircularRegion.self) {
                // Register the region.
                let maxDistance = self.locationManager?.maximumRegionMonitoringDistance
                let region = CLCircularRegion(center: center,
                     radius: 5000.0, identifier: "YourRegionID")
                region.notifyOnEntry = true
                region.notifyOnExit = false

                self.locationManager?.startMonitoring(for: region)
            }
    }
    }
        
        
        func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
            if let region = region as? CLCircularRegion {
                // your logic to handle region-entered notification
                let identifier = region.identifier
                       pinnedshop(regionID: identifier)
            }
        }
    
    
    func pinnedshop(regionID:String){
        
        
        let nycAnnotation = MKPointAnnotation();
        nycAnnotation.coordinate = CLLocationCoordinate2D(latitude: 40.71, longitude: 74.0);
        nycAnnotation.title = "New Yok City";
        self.annotations.append(nycAnnotation);
        //Do the rest cities here
        self.mapView?.addAnnotations(self.annotations)
        
    }
      

        // Do any additional setup after loading the view.
    
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
