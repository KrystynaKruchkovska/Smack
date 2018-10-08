//
//  LeagueVC.swift
//  Smack
//
//  Created by Mac on 7/19/18.
//  Copyright © 2018 CO.KrystynaKruchcovska. All rights reserved.
//
import UIKit

class ChatVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // Outlets
    @IBOutlet weak var menuBtn: UIButton!
    
    @IBOutlet weak var messageTxtFld: UITextField!
    
    @IBOutlet weak var channelNameLbl: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.bindToKeyboard()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableViewAuto
        maticDimension
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(ChatVC.handleTap))
        view.addGestureRecognizer(tap)
        
        
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
    
    @objc func handleTap(){
        view.endEditing(true)
    }
    
    @IBAction func sendBtnPressed(_ sender: Any) {
        
        if AuthService.instance.isLoggedIn{
            guard let channelId = MessageService.instance.selectedChannel?.id else {return}
            guard let message = messageTxtFld.text else{return}
            
            SocketService.instance.addMessage(messageBody: message, userId: UserDataServise.instance.id, channelId: channelId, completion: { (success) in
                if success {
                    self.messageTxtFld.text = ""
                    self.messageTxtFld.resignFirstResponder()
                    
                }
            })
        }
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
            
            if success {
                self.tableView.reloadData()
            }
            
        }
      
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath) as? MessageCell{
            let massege = MessageService.instance.messages[indexPath.row]
            cell.configureCell(message: massege)
            return cell
        }else{
            return UITableViewCell()
            
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageService.instance.messages.count
    }
    
    
   

}
