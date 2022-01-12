//
//  ViewController.swift
//  hk traditional handicraft
//
//  Created by peter lam on 10/1/2022.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
//
//    let appDelegate = UIApplication.shared.delegate as! AppDelegate
//    var moc:NSManagedObjectContext!

    override func viewDidLoad() {
        super.viewDidLoad()
//        openDatabase()

    }

//    func openDatabase(){
//            moc = appDelegate.persistentContainer.viewContext
//            let entity = NSEntityDescription.entity(forEntityName: "HandicraftsShop", in: moc)
//            let newData = NSManagedObject(entity: entity!, insertInto: moc)
//            cleanData()
//            saveData(newDBObject:newData)
//
//
//
//
//    }
//
//    func saveData(newDBObject : NSManagedObject){
//
//        newDBObject.setValue(1, forKey: "id")
//        newDBObject.setValue("test", forKey: "name")
//        newDBObject.setValue(22.302711, forKey: "lati")
//        newDBObject.setValue(114.177216, forKey: "long")
//
//
//               print("Storing Data..")
//               do {
//                   try moc.save()
//               } catch {
//                   print("Storing data Failed")
//               }
//        fetchData()
//    }
//
//    func cleanData()
//    {
//        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "HandicraftsShop")
//        request.includesPropertyValues = false
//        let batchDeleteRequest =  NSBatchDeleteRequest(fetchRequest: request)
//        do{
//            try moc.execute(batchDeleteRequest)
//                print("clean complete")
//        }catch{
//            print("can't clean")
//        }
//
//
//    }
//
//
//
//    func fetchData()
//        {
//            print("Fetching Data..")
//            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "HandicraftsShop")
//            request.returnsObjectsAsFaults = false
//            do {
//                let result = try moc.fetch(request)
//                for data in result as! [NSManagedObject] {
//                    let id = data.value(forKey: "id") as! Int16
//                    let name = data.value(forKey: "name") as! String
//                    let lati = data.value(forKey: "lati") as! Float
//                    let long = data.value(forKey: "long") as! Float
//                    print( id )
//                    print(name )
//                    print(long)
//                    print(lati)
//                }
//            } catch {
//                print("Fetching data Failed")
//            }
//
//        }
    

    
}

