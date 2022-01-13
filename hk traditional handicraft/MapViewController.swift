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
class MapViewController: UIViewController, CLLocationManagerDelegate,NSFetchedResultsControllerDelegate {

    var annotations = [MKPointAnnotation]();
    var locationManager : CLLocationManager?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var moc:NSManagedObjectContext!
    var fetchedResultController: NSFetchedResultsController = NSFetchedResultsController<NSFetchRequestResult>()
    
    
    
    
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
                   openDatabase()
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
            print("checkNearby()")
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
        for result in 1 ... ((fetchedResultController.fetchedObjects?.count)!-1) {
            let shop = fetchedResultController.fetchedObjects?[result] as! HandicraftsShop
            let center = CLLocationCoordinate2D(latitude: CLLocationDegrees(shop.lati), longitude: CLLocationDegrees(shop.long)) //check shop
            let region = CLCircularRegion(center: center,
                 radius: 5000.0, identifier: "\(result)")
            region.notifyOnEntry = true
            region.notifyOnExit = false
            self.locationManager?.startMonitoring(for: region)
        }
        
        
        
//        let center = CLLocationCoordinate2D(latitude: 22.302711, longitude: 114.177216) //check shop is nearby or not
//            // Make sure region monitoring is supported.
//            if CLLocationManager.isMonitoringAvailable(for: CLCircularRegion.self) {
//                // Register the region.
//                let maxDistance = self.locationManager?.maximumRegionMonitoringDistance
//                let region = CLCircularRegion(center: center,
//                     radius: 5000.0, identifier: "YourRegionID")
//                region.notifyOnEntry = true
//                region.notifyOnExit = false
//
//                self.locationManager?.startMonitoring(for: region)
//            }
    
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
            let shop = fetchedResultController.fetchedObjects?[Int(regionID) ?? 0] as! HandicraftsShop
            nycAnnotation.coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(shop.lati), longitude: CLLocationDegrees(shop.long));
            nycAnnotation.title = shop.name;
            self.annotations.append(nycAnnotation);
            self.mapView?.addAnnotations(self.annotations)
            print("pinned \(regionID)")
        
    
                let content = UNMutableNotificationContent()
                content.title = "你已經接近香港傳統手工藝店鋪\(shop.name)"
                content.subtitle = "詳情請進入app，地圖上會顯示店舖位置"
                content.body = "店舖詳細: \(shop.text)"
                content.badge = 1
                content.sound = UNNotificationSound.default
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
               
               let request = UNNotificationRequest(identifier: "notification", content: content, trigger: trigger)
               
               UNUserNotificationCenter.current().add(request, withCompletionHandler: {error in
                   print("成功建立通知...")
               })
        
        
        
//        let nycAnnotation = MKPointAnnotation();
//        nycAnnotation.coordinate = CLLocationCoordinate2D(latitude: 40.71, longitude: 74.0);
//        nycAnnotation.title = "New Yok City";
//        self.annotations.append(nycAnnotation);
//        //Do the rest cities here
//        self.mapView?.addAnnotations(self.annotations)
//
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

    func fetchData()
        {
            print("Fetching Data..")
            let request = shopFetchRequest()
            fetchedResultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: moc, sectionNameKeyPath: nil, cacheName: nil)
            request.returnsObjectsAsFaults = false
            do {
                try fetchedResultController.performFetch()
                print("Fetch Data complete")
            }
            catch let error as NSError{
                print("Fetching data Failed , error code = \(error.code), \(error)")
            }

        }
    
    func shopFetchRequest() -> NSFetchRequest<NSFetchRequestResult> {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "HandicraftsShop")
        let sortDescriptor = NSSortDescriptor(key: "id", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        return fetchRequest
    }
    
    func openDatabase(){
            moc = appDelegate.persistentContainer.viewContext
            let entity = NSEntityDescription.entity(forEntityName: "HandicraftsShop", in: moc)
            fetchData()
    }
    
    
   

}
