//
//  ShopTableViewController.swift
//  hk traditional handicraft
//
//  Created by peter lam on 12/1/2022.
//

import UIKit
import CoreData


class ShopTableViewController: UITableViewController,NSFetchedResultsControllerDelegate {
    
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var moc:NSManagedObjectContext!
    var fetchedResultController: NSFetchedResultsController = NSFetchedResultsController<NSFetchRequestResult>()
    

    
    var shopArray = [HandicraftsShop]()

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchedResultController.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
        openDatabase()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        print((fetchedResultController.fetchedObjects?.count)!)
        return fetchedResultController.fetchedObjects?.count ?? 0 
        
            
        
    }

    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let CellIdentifier = "shopCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier, for: indexPath as IndexPath) as! shopCell
        let shop = fetchedResultController.fetchedObjects![indexPath.section] as! HandicraftsShop
        
       // cell.textLabel?.text = String(shop.name!)
        cell.nameLabel?.text =  shop.name
        let url =  URL.init(fileURLWithPath: "/Users/peterlam/Desktop/xcode/Biometric /traditional handicraft/hk traditional handicraft/hk traditional handicraft/example.jpg")
        let ImageData:NSData = NSData(contentsOf: url)!
        cell.thrumbnail.image = UIImage(data: ImageData as Data)
        // Configure the cell...
        

        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let destination = segue.destination as? DetailController{
            if let indexPath = self.tableView.indexPathForSelectedRow{
                let row = indexPath.row
                let shop = fetchedResultController.fetchedObjects![row] as! HandicraftsShop
                destination.shopID = shop.id
                destination.shopName = shop.name
                let url =  URL.init(fileURLWithPath: "/Users/peterlam/Desktop/xcode/Biometric /traditional handicraft/hk traditional handicraft/hk traditional handicraft/example.jpg")
                let ImageData:NSData = NSData(contentsOf: url)!
                destination.Image = UIImage(data: ImageData as Data)
                destination.textD = shop.text
            }
        }
    }
    

    func openDatabase(){
            moc = appDelegate.persistentContainer.viewContext
            let entity = NSEntityDescription.entity(forEntityName: "HandicraftsShop", in: moc)
            cleanData()
        print("Storing Data..")
        for index in  1...5{
            let shop = NSManagedObject(entity: entity!, insertInto: moc)
            print(index)
            shop.setValue(index, forKey: "id")
            shop.setValue("香港傳統奶茶", forKey: "name")
            shop.setValue((22.302711), forKey: "lati")
            shop.setValue((114.177216), forKey: "long")
            shop.setValue("港式奶茶俗稱「絲襪奶茶」，由殖民地時代的英式奶茶，經過百年的逐漸演變，成為今天香港普羅大眾的飲品。港式奶茶由調配茶葉、煲茶、焗茶、撞茶、撞奶等步驟炮製而成，深受香港人歡迎。港式奶茶製作技藝反映了中西飲食文化在香港的交融與發展，也反映出本地市民的生活和飲食的面貌。", forKey: "text")
        }
        
       
        do {
            try moc.save()
        } catch {
            print("Storing data Failed")
        }
        fetchData()
    }

    
    func cleanData()
    {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "HandicraftsShop")
        request.includesPropertyValues = false
        let batchDeleteRequest =  NSBatchDeleteRequest(fetchRequest: request)
        do{
            try moc.execute(batchDeleteRequest)
                print("clean complete")
        }catch{
            print("can't clean")
        }
            
        
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
