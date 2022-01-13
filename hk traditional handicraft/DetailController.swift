//
//  DetailController.swift
//  hk traditional handicraft
//
//  Created by peter lam on 13/1/2022.
//

import UIKit

class DetailController: UIViewController {

    
    var shopID:Int16?
    var shopName:String?
    var Image : UIImage?
    var textD: String?
    @IBOutlet var shopname : UILabel!
    @IBOutlet var image: UIImageView!
    @IBOutlet var text: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        shopname.text = self.shopName
        image.image = self.Image
        text.text = self.textD
        
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
