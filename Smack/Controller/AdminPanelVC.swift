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
//
//        tableView.delegate = self
//        tableView.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        UsersDataService.instance.findAllUsers { (success) in
            if success{
                self.tableView.reloadData()
            }
        }
    }

    @IBAction func backBtnPressed(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let userCell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath)
        let user = UsersDataService.instance.users[indexPath.row]
        userCell.textLabel!.text = user.name + " email:" + user.email
        return userCell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UsersDataService.instance.users.count
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    

}
