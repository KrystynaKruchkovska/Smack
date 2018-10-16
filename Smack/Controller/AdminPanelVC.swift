//
//  AdminPanelVC.swift
//  Smack
//
//  Created by Mac on 10/14/18.
//  Copyright © 2018 Jonny B. All rights reserved.
//

import UIKit

class AdminPanelVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        UsersDataService.instance.findAllUsers { (success) in
            if success{
                self.refreshList()
            }
        }
    }
    
    @IBAction func deleteBtnPressed(_ sender: Any) {
        let selectedRow = tableView.indexPathForSelectedRow?.row
        let id = UsersDataService.instance.users[selectedRow!].id
        
        print("DeleteBtnPressed with row:\(selectedRow)")
        
        AuthService.instance.deleteUserbyId(id: id!) { (success) in
            print("auth service delete user handler")
            if success {
                print("auth service delete user handler success")
                print("Left in array:\(UsersDataService.instance.users.count)")
                self.refreshList()
            }
        }
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func refreshList() {
        print("refresh list")
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
        cell?.deleteBtn.isHidden = false
        
        return cell!
        
        
        
        
        //        if let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath) as? MessageCell{
        //            let massege = MessageService.instance.messages[indexPath.row]
        //            cell.configureCell(message: massege)
        //            return cell
        //        }else{
        //            return UITableViewCell()
        //
        //        }
        //
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Number of rows:\(UsersDataService.instance.users.count)")
        return UsersDataService.instance.users.count
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
}
