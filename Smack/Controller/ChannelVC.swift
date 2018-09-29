//
//  LeagueVC.swift
//  Smack
//
//  Created by Mac on 7/19/18.
//  Copyright © 2018 CO.KrystynaKruchcovska. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController {
// Outlets
    
    @IBOutlet weak var userImg: CircleImgView!
    
    @IBOutlet weak var loginBtn: UIButton!
    
    
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue){
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.userDataDidChange(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
    }

    @IBAction func loginBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_LOGIN, sender: nil)
    }
    
    @objc func userDataDidChange(_ notif:Notification){
        if AuthService.instance.isLoggedIn{
            loginBtn.setTitle(UserDataServise.instance.name, for: .normal)
            userImg.image = UIImage(named: UserDataServise.instance.avatarName)
            userImg.backgroundColor = UserDataServise.instance.returnUIColor(components: UserDataServise.instance.avatarColor)
            
        }else{
            loginBtn.setTitle("Login", for: .normal)
            userImg.image = UIImage(named:"menuProfileIcon")
            userImg.backgroundColor = UIColor.clear
        }
        
    }
    
}
