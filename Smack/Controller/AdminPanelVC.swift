//
//  AdminPanelVC.swift
//  Smack
//
//  Created by Mac on 10/14/18.
//  Copyright © 2018 Jonny B. All rights reserved.
//

import UIKit

class AdminPanelVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(AdminPanelVC.onAllUsersFound(_:)), name: NOTIF_ALL_USERS_FOUND, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        UsersDataService.instance.findAllUsers { (success) in
            if success{
                self.refreshList()
            }
        }
    }
    
    
    
    @objc func onAllUsersFound(_ notif:Notification){
        self.refreshList()
        self.spinner.isHidden = true
        self.spinner.stopAnimating()
        
        
    }
    
    
    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func refreshList() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath)  as? UserCell
        let selectedUser = UsersDataService.instance.users[indexPath.row]
        cell?.userName?.text = selectedUser.name
        cell?.userEmailLbl.text = selectedUser.email
        cell?.userImg.image = UIImage(named: selectedUser.avatarName)
        
        
        return cell!
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Number of rows:\(UsersDataService.instance.users.count)")
        return UsersDataService.instance.users.count
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        if UsersDataService.instance.isAdmin(userId: UsersDataService.instance.users[indexPath.row].id)  {
//            return [UITableViewRowAction]()
            
            let impossibledelete = UITableViewRowAction(style: .normal, title: "Impossible delete admin") { (rowAction, indexPath) in
               
            }
                impossibledelete.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
             return [impossibledelete]
            
            
        }else{
            
            let deleteAction = UITableViewRowAction(style: .destructive, title: "DELETE") { (rowAction, indexPath) in
                
                
                
                let deletedRow  = indexPath.row
                
                let id = UsersDataService.instance.users[deletedRow].id
                
                
                AuthService.instance.deleteUserbyId(id: id!) { (success) in
                    
                    if success {
                        self.tableView.deleteRows(at: [indexPath], with: .automatic)
                    }
                }
                
                
            }
            deleteAction.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
            return [deleteAction]
            
        }
        
        
    }
    
}
