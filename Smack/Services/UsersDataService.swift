//
//  UsersDataService.swift
//  Smack
//
//  Created by Mac on 10/14/18.
//  Copyright © 2018 Jonny B. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class UsersDataService{
    
    static let instance = UsersDataService()
    
    var users = [User]()
    
    func dataToUsersArray(data:Data) {
        if let json = try! JSON(data:data).array{
            
            self.users.removeAll()
            
            for item in json {
                let avatarColor = item["avatarColor"].stringValue
                let avatarName = item["avatarName"].stringValue
                let email = item["email"].stringValue
                let name = item["name"].stringValue
                let id = item["_id"].stringValue
                
                let user = User(id: id, avatarColor: avatarColor, avatarName: avatarName, email: email, name: name)
                self.users.append(user)
            }
        }
    }
    
    
    func findAllUsers(completion: @escaping CompletionHandeler){
        
        Alamofire.request("\(URL_FIND_ALL_USER)", method:.get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON {
            
            
            (response) in
            if response.result.error == nil {
                guard let data = response.data else { return }
                
              self.dataToUsersArray(data: data)
                
                completion(true)
            }
            else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
            
        }
        
    }
    

    
}
