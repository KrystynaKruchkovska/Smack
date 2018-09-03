//
//  LeagueVC.swift
//  Smack
//
//  Created by Mac on 7/19/18.
//  Copyright © 2018 CO.KrystynaKruchcovska. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {
    
    // Outlets
    
    
    @IBOutlet weak var usernameTxF: UITextField!
    
    @IBOutlet weak var emailTxf: UITextField!
    
    @IBOutlet weak var passTxt: UITextField!
    
    @IBOutlet weak var userimg: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    @IBAction func createAccountPressed(_ sender: Any) {
        
        guard let email = emailTxf.text, emailTxf.text != "" else
        {return}
        guard let pass = passTxt.text, passTxt.text != "" else
        {return}
        AuthService.instance.registerUser(email: email, password: pass) { (success) in
            if success {
                print("registered user!")
            }
        }
    }
    
    @IBAction func pickAvatarPressed(_ sender: Any) {
    }
    @IBOutlet weak var pickBGColorPressed: UIButton!
    
    
    @IBAction func closedPressed(_ sender: Any) {
        
        performSegue(withIdentifier: UNWIND, sender:nil)
    }
    


}
