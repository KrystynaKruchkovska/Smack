//
//  AuthService.swift
//  Smack
//
//  Created by Mac on 8/31/18.
//  Copyright © 2018 Jonny B. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON



class AuthService{
     static let instance = AuthService()
    
    let defaults = UserDefaults.standard
    
    var isLoggedIn:Bool{
        get {
            return defaults.bool(forKey: LOGGED_IN_KEY)
        }
        set{
            defaults.set(newValue, forKey: LOGGED_IN_KEY)
        }
    }
    
    var authToken:String{
        get {
            return defaults.value(forKey: TOKEN_KEY) as! String
        }
        set{
            defaults.set(newValue, forKey: TOKEN_KEY)
            
        }
    }
    
    var userEmail:String{
        get {
            return defaults.value(forKey: USER_EMAIL) as! String
        }
        set{
            defaults.set(newValue, forKey: USER_EMAIL)
            
        }
    }
    
   
    
    func registerUser(email:String, password:String, completion: @escaping CompletionHandeler){
        let lowerCaseEmail = email.lowercased()
        
       
        
        let body: [String:Any] = [
            "email" : lowerCaseEmail,
            "password" : password
        ]
        
        Alamofire.request(URL_REGISTER, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseString
            { (response) in
            
                if response.result.error == nil{
                    completion(true)
                } else {
                    completion(false)
                    debugPrint(response.result.error!)
                }
        }
    }
    
    func loginUser(email:String, password:String, completion: @escaping CompletionHandeler){
        
        
        let lowerCaseEmail = email.lowercased()
        
   
        let body: [String:Any] = [
            "email" : lowerCaseEmail,
            "password" : password
        ]
        
        Alamofire.request(URL_LOGIN, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseJSON {
            (response) in
            
            if response.result.error == nil {
//                if let json = response.result.value as? Dictionary<String,Any>{
//                    if let email = json["user"] as? String {
//                        self.userEmail = email
//                    }
//                    if let token = json["token"] as? String{
//                        self.authToken = token
//                    }
                // Using SwiftyJSON
                guard let data = response.data else {return}
                let json = try! JSON(data: data)
                self.userEmail = json["user"].stringValue
                let token = json["token"].stringValue
                self.authToken = token
                self.isLoggedIn = true
                completion(true)
            }else{
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
        
        
    }
    
    func createUser(name:String,email:String, avatarName:String, avatarColor:String, completion: @escaping CompletionHandeler){
        
        let lowerCaseEmail = email.lowercased()
        
        let body: [String:Any] = [
            "name" : name,
            "email" : lowerCaseEmail,
            "avatarName": avatarName,
            "avatarColor" : avatarColor
        ]
        
        Alamofire.request(URL_USER_ADD, method: .post, parameters: body, encoding: JSONEncoding.default, headers: BEARER_HEADER) .responseData {
            (response) in
            
           
            print( response.response?.statusCode ?? 0)
            
            if response.result.error == nil {
                guard let data = response.data else {return}
                self.setUserInfo(data: data)
                completion(true)
        
            }
            else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    
    }
    func findUserByEmail(completion: @escaping CompletionHandeler){

        Alamofire.request("\(URL_USER_BY_EMAIL)\(userEmail)", method:.get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON {
            (response) in
            if response.result.error == nil {
                guard let data = response.data else {return}
                self.setUserInfo(data: data)
        
                completion(true)
                
            }
            else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
        
    }
    
 
    func updateUserNameById(name:String, completion: @escaping CompletionHandeler) {
        let body:[String:String] = [
            "name" : name,
            "email": self.userEmail,
            "avatarName": LocalUserDataService.instance.avatarName,
            "avatarColor" : LocalUserDataService.instance.avatarColor
        ]
        
        
        Alamofire.request("\(URL_FIND_ALL_USER)\(LocalUserDataService.instance.id)", method: .put, parameters: body, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON {
            (response) in
            if response.result.error == nil {
                LocalUserDataService.instance.updateName(name:name)
                completion(true)
                
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
        
        
    }
    
    func deleteUserbyId( id:String, completion: @escaping CompletionHandeler){
        
        
        Alamofire.request("\(URL_FIND_ALL_USER)\(id)", method: .delete, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON {
            (response) in
            if response.result.error == nil {
                
         
                
                UsersDataService.instance.findAllUsers(completion: { (success) in
                    if success {
                        //send notification to AdminPanel, in admin panel, on notification refreshTableView
                    }
                })
                
                completion(true)
                
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
        
        
        
        
    }
    
    
 
    
    func setUserInfo(data:Data){
        let json = try! JSON(data:data)
        let color = json["avatarColor"].stringValue
        let avatarName = json["avatarName"].stringValue
        let email = json["email"].stringValue
        let name = json["name"].stringValue
        let id = json["_id"].stringValue
        
        LocalUserDataService.instance.setUserData(id: id, color: color, avatarName: avatarName, email: email, name: name)
    }
    
    
    
    
}
