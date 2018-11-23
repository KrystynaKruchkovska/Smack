//
//  AdminPanelViewModel.swift
//  Smack
//
//  Created by Mac on 11/23/18.
//  Copyright © 2018 Jonny B. All rights reserved.
//

import UIKit

class AdminPanelViewModel: NSObject {
    let usersDataService = UsersDataService.instance
    let authService = AuthService.instance
    
    var users:[User]!
    
    override init() {
        self.users = self.usersDataService.users
    }
    
    func isAdmin(userID:String) -> Bool {
        return self.usersDataService.isAdmin(userId: userID)
    }
    
    func deleteUserByID(userID:String, handler: @escaping (_ success:Bool)->() ) { 
        
        self.authService.deleteUserbyId(id: userID) { (success) in
            handler(success)
        }
    }
    
    
    
    
}
