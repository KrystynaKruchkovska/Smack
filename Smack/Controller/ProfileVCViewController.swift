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

        
        NotificationCenter.default.addObserver(self, selector: #selector(ProfileVCViewController.userDataDidChange(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
    }
    
    
    @objc func userDataDidChange(_ notif: NotificationCenter){
       setupView()
    }
    
    @IBAction func updateUserInfoBtnPressed(_ sender: Any) {
        
    if AuthService.instance.isLoggedIn{
            let updateNameVC = UpdateVC()
            updateNameVC.modalPresentationStyle = .custom
            present(updateNameVC, animated: true, completion: nil)
        }
        
        
    }

    
    

    @IBAction func logoutPressed(_ sender: Any) {
        LocalUserDataService.instance.logoutUser()
        NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func closeModalPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setupView(){
        userName.text = LocalUserDataService.instance.name
        userEmail.text = LocalUserDataService.instance.email
        profileImg.image = UIImage(named: LocalUserDataService.instance.avatarName)
        profileImg.backgroundColor = LocalUserDataService.instance.returnUIColor(components: LocalUserDataService.instance.avatarColor)
        let closeTouch = UITapGestureRecognizer(target: self, action: #selector(ProfileVCViewController.closeTap(_:)))
        bgView.addGestureRecognizer(closeTouch)
        
    }
    
    @objc func closeTap (_ regognizer:UITapGestureRecognizer){
        dismiss(animated: true, completion: nil)
    }
    
    
}
