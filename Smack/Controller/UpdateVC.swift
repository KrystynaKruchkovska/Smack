//
//  UpdateVC.swift
//  Smack
//
//  Created by Mac on 10/13/18.
//  Copyright © 2018 Jonny B. All rights reserved.
//

import UIKit

class UpdateVC: UIViewController {
    
    
    @IBOutlet weak var newNameTxtFld: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func sendBtnwasPressed(_ sender: Any) {
        
        guard  var name = newNameTxtFld.text, newNameTxtFld.text != "" else {return}
        
        AuthService.instance.updateUserNameById(name:name)
            { (success) in
            if success {
                self.dismiss(animated: true, completion: nil)
                
                NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
            }
        }
    }
    


}
