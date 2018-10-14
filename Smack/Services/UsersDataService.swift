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
    
    func findAllUsers(completion: @escaping CompletionHandeler){
        
        Alamofire.request("\(URL_FIND_ALL_USER)", method:.get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON {
            
            
            (response) in
            if response.result.error == nil {
                guard let data = response.data else {return}
                completion(true)
                
            }
            else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
            
        }
        
    }
    
    
}
