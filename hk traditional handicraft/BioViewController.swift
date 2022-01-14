//
//  ChatViewController.swift
//  hk traditional handicraft
//
//  Created by peter lam on 13/1/2022.
//

import UIKit
import LocalAuthentication

class BioViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func authenticateUser(_ sender: UIButton){ 
        let context = LAContext()
        var error : NSError?
        if context.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: &error){
            
            //Device can use bios
            context.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: "access required", reply: {(success,error) in
                DispatchQueue.main.async {
                    if let err = error {
                        switch err._code{
                        case LAError.Code.systemCancel.rawValue:
                            self.notifyUser("Session cancel", err: err.localizedDescription)
                        default:
                            self.notifyUser("failed",err:err.localizedDescription)
                        }
                    }else{
                        self.notifyUser("successful",err: "success")
                        sender.removeFromSuperview()
                        
                        
                    }
                }
            
            
            })
            
            
            
            
        }else{
            if let err = error{
                switch err.code{
                case LAError.Code.biometryNotEnrolled.rawValue:
                    notifyUser("User is not enrolled", err: err.localizedDescription)
                    
                case LAError.Code.passcodeNotSet.rawValue:
                    notifyUser("passcodenotset", err: err.localizedDescription)
                default:
                    notifyUser("not available", err: err.localizedDescription)
                    
                }
            }
        }
    }

    
    func notifyUser(_ msg: String , err: String?){
        let alert = UIAlertController(title: msg, message: err, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        self.present(alert,animated: true,completion: nil)
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
