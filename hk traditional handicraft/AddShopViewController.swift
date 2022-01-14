//
//  AddShopViewController.swift
//  hk traditional handicraft
//
//  Created by peter lam on 14/1/2022.
//

import UIKit
import CoreData
import Foundation
class AddShopViewController: UIViewController,UINavigationControllerDelegate,UIImagePickerControllerDelegate {


    @IBOutlet weak var NameField : UITextField?
    @IBOutlet weak var longField : UITextField?
    @IBOutlet weak var lagiField : UITextField?
    @IBOutlet weak var UserImage : UIImageView?
    @IBOutlet weak var otherField : UITextField?
    
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var moc:NSManagedObjectContext!
    var fetchedResultController: NSFetchedResultsController = NSFetchedResultsController<NSFetchRequestResult>()
    




    // dispatch queues
    let convertQueue = DispatchQueue(label: "convertQueue")
    let saveQueue = DispatchQueue(label: "saveQueue")


    @IBAction func takeimage(_ sender: Any){
        
        if(UIImagePickerController.isSourceTypeAvailable(.camera))
        {
        let imagePicker = UIImagePickerController()
            imagePicker.sourceType = .camera
            imagePicker.allowsEditing = true
            imagePicker.delegate = self
            present(imagePicker, animated: true, completion: nil)
        }else{
            let actionController: UIAlertController = UIAlertController(title: "Camera is not available",message: "", preferredStyle: .alert)
                     let cancelAction: UIAlertAction = UIAlertAction(title: "OK", style: .cancel) { action -> Void  in
                                //Just dismiss the action sheet
            
        }
        }
    }

    


    @IBAction func submit (_ sender: Any){
        moc = appDelegate.persistentContainer.viewContext
        let newUser = NSEntityDescription.insertNewObject(forEntityName: "HandicraftsShop", into: moc)
        
        if UserImage?.image != nil{
            let data = (UserImage?.image)!.pngData()
            newUser.setValue(data, forKey: "img")
         }else{
            print("no image")
         }
        
        let lati = Double(lagiField?.text ?? "0")
        let long = Double(longField?.text ?? "0")
        let Name = NameField?.text
        let other = otherField?.text
        
        newUser.setValue(Name, forKey: "name")
        newUser.setValue(lati, forKey: "lati")
        newUser.setValue(long, forKey: "long")
        newUser.setValue(other, forKey: "text")
        

        do {
            try moc.save()
        }catch{
            print("Storing data Failed")
        }
        fetchData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
            UserImage?.image = image
            
        }
        
        picker.dismiss(animated: true)

    }

                         
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

}
