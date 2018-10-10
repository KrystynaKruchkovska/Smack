//
//  ProfileVCViewController.swift
//  Smack
//
//  Created by Mac on 10/1/18.
//  Copyright © 2018 Jonny B. All rights reserved.
//

import UIKit

class ProfileVCViewController: UIViewController {
    
    @IBOutlet weak var profileImg: UIImageView!
    
    @IBOutlet weak var userName: UILabel!
    
    
    @IBOutlet weak var userEmail: UILabel!
    
    
    @IBOutlet weak var bgView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()

    }
    
    
    @IBAction func updateUserByIDBtn(_ sender: Any) {
        
//        let name  = UserDataServise.instance.name
//
//        AuthService.instance.updateUserById(name: name) { (success) in
//
//            if success {
//                self.userName.text = name
//                NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
//            }
//        }
        
    }
    
    

    @IBAction func logoutPressed(_ sender: Any) {
        UserDataServise.instance.logoutUser()
        NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func closeModalPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setupView(){
        userName.text = UserDataServise.instance.name
        userEmail.text = UserDataServise.instance.email
        profileImg.image = UIImage(named: UserDataServise.instance.avatarName)
        profileImg.backgroundColor = UserDataServise.instance.returnUIColor(components: UserDataServise.instance.avatarColor)
        let closeTouch = UITapGestureRecognizer(target: self, action: #selector(ProfileVCViewController.closeTap(_:)))
        bgView.addGestureRecognizer(closeTouch)
    }
    
    @objc func closeTap (_ regognizer:UITapGestureRecognizer){
        dismiss(animated: true, completion: nil)
    }
    
    
}
