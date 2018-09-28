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
    
    // Variables
    var avatarName = "profileDefault"
    var avatarColor = "[05,05,05, 1]"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        if UserDataServise.instance.avatarName != ""{
            userimg.image = UIImage(named: UserDataServise.instance.avatarName)
            avatarName = UserDataServise.instance.avatarName
        }
    }
    
    @IBAction func createAccountPressed(_ sender: Any) {
        guard let name = usernameTxF.text, usernameTxF.text != "" else
        {return}
        guard let email = emailTxf.text, emailTxf.text != "" else
        {return}
        guard let pass = passTxt.text, passTxt.text != "" else
        {return}
        AuthService.instance.registerUser(email: email, password: pass) { (success) in
            if success {
                AuthService.instance.loginUser(email: email, password: pass, completion:{(success) in
                    if success {
                        
                        AuthService.instance.createUser(name: name, email: email, avatarName: self.avatarName, avatarColor: self.avatarColor, completion:
                            {(success) in
                            if success{
                                print(UserDataServise.instance.name, UserDataServise.instance.avatarName)
                                self.performSegue(withIdentifier: UNWIND, sender: nil)
                            }
                            
                        })
                    }
                })
            }
        }
    }
    
    @IBAction func pickAvatarPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_AVATAR_PICKER, sender: nil)
    }
    @IBOutlet weak var pickBGColorPressed: UIButton!
    
    
    @IBAction func closedPressed(_ sender: Any) {
        
        performSegue(withIdentifier: UNWIND, sender:nil)
    }
    


}
