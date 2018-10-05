//
//  LeagueVC.swift
//  Smack
//
//  Created by Mac on 7/19/18.
//  Copyright © 2018 CO.KrystynaKruchcovska. All rights reserved.
//
import UIKit

class ChatVC: UIViewController {
    
    // Outlets
    @IBOutlet weak var menuBtn: UIButton!
    
    
    @IBOutlet weak var channelNameLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.userDataDidChange(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.channelSelected(_:)), name: NOTIF_CHANNAL_SELECTED, object: nil)
        
        if AuthService.instance.isLoggedIn {
            AuthService.instance.findUserByEmail(completion: { (success) in
                NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
                
            })
        }
        MessageService.instance.findAllChannels { (success) in
        }
    }
    @objc func userDataDidChange(_ notif: NotificationCenter){
        if AuthService.instance.isLoggedIn{
            onLoginGetMasseges()
        }else{
            channelNameLbl.text = "Please Log In"
        }
    }
        
    @objc func channelSelected(_ notif:Notification){
            updateWithChannel()
        }
        
        
        func updateWithChannel (){
            let channelName = MessageService.instance.selectedChannel?.channelTitle ?? ""
            channelNameLbl.text = channelName
            getMessages()
        }
    
    
    func onLoginGetMasseges(){
        MessageService.instance.findAllChannels { (success) in
            if success {
                //Do staff with channels
                if MessageService.instance.channels.count > 0 {
                    MessageService.instance.selectedChannel = MessageService.instance.channels[0]
                    self.updateWithChannel()
                }
                else{
                    self.channelNameLbl.text = "No channels yet!"
                }
            }
        }
    }
    func getMessages(){
        guard let channelId = MessageService.instance.selectedChannel?.id else {return}
        MessageService.instance.findAllMessagesForChannel(channedId: channelId) { (success) in
            
        }
      
        
    }

}
