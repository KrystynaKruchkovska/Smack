//
//  LeagueVC.swift
//  Smack
//
//  Created by Mac on 7/19/18.
//  Copyright © 2018 CO.KrystynaKruchcovska. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController,UITableViewDelegate, UITableViewDataSource {
// Outlets
    
    @IBOutlet weak var userImg: CircleImgView!
    
    @IBOutlet weak var loginBtn: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue){
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.userDataDidChange(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        
        SocketService.instance.getChannel { (success) in
            if success {
                self.tableView.reloadData()
            }
        }
        
    }
    override func viewDidAppear(_ animated: Bool) {
        setupUserInfo()
    }
    
    @IBAction func addChannelBtnPressed(_ sender: Any) {
        let addChanel = AddChannelVC()
        addChanel.modalPresentationStyle = .custom
        present(addChanel, animated: true, completion: nil)
    }
    

    @IBAction func loginBtnPressed(_ sender: Any) {
       if AuthService.instance.isLoggedIn{
            //show profile page
        let profile = ProfileVCViewController()
        profile.modalPresentationStyle = .custom
        present(profile, animated: true, completion: nil)
       } else {
        performSegue(withIdentifier: TO_LOGIN, sender: nil)
        }
        
    }
    
    @objc func userDataDidChange(_ notif:Notification){
        setupUserInfo()
    }
    
    func setupUserInfo(){
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
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "channelCell", for: indexPath) as? ChannelCell {
            let channel = MassegeService.instance.channels[indexPath.row]
            cell.configurCell(channel: channel)
            return cell
        }else{
            return UITableViewCell()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MassegeService.instance.channels.count
    }
}
