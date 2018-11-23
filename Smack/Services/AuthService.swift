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
    let localUserDataService = LocalUserDataService.instance
    let userDataService = UsersDataService.instance
    
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
    
    func registerUser(email:String, password:String, completion: @escaping CompletionHandeler) {
        let lowerCaseEmail = email.lowercased()
        
        let body: [String:Any] = [
            REQUEST_BODY_KEYS.EMAIL: lowerCaseEmail,
            REQUEST_BODY_KEYS.PASSWORD : password
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
            REQUEST_BODY_KEYS.EMAIL: lowerCaseEmail,
            REQUEST_BODY_KEYS.PASSWORD : password
        ]
        
        Alamofire.request(URL_LOGIN, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseJSON {
            (response) in
            
            if response.result.error == nil {
                guard let data = response.data else {return}
                let json = try! JSON(data: data)
                self.userEmail = json["user"].stringValue // Response with email for key "user"
                let token = json[REQUEST_BODY_KEYS.TOKEN].stringValue
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
            REQUEST_BODY_KEYS.NAME : name,
            REQUEST_BODY_KEYS.EMAIL : lowerCaseEmail,
            REQUEST_BODY_KEYS.AVATAR_NAME: avatarName,
            REQUEST_BODY_KEYS.AVATAR_COLOR : avatarColor
        ]
        
        Alamofire.request(URL_USER_ADD, method: .post, parameters: body, encoding: JSONEncoding.default, headers: BEARER_HEADER) .responseData {
            (response) in
    
            print( response.response?.statusCode ?? 0)
            
            if response.result.error == nil {
                guard let data = response.data else {return}
                self.setUserInfo(data: data)
                completion(true)
                
            } else {
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
                
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
        
    }
    
    
    func updateUserNameById(name:String, completion: @escaping CompletionHandeler) {
        let body:[String:String] = [
            REQUEST_BODY_KEYS.NAME : name,
            REQUEST_BODY_KEYS.EMAIL: self.userEmail,
            REQUEST_BODY_KEYS.AVATAR_NAME: self.localUserDataService.avatarName,
            REQUEST_BODY_KEYS.AVATAR_COLOR: self.localUserDataService.avatarColor
        ]
        
        
        Alamofire.request("\(URL_FIND_ALL_USER)\(self.localUserDataService.id)", method: .put, parameters: body, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON {
            (response) in
            if response.result.error == nil {
                self.localUserDataService.updateName(name:name)
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
                
                self.userDataService.findAllUsers(completion: { (success) in
                    if success {
                        NotificationCenter.default.post(name: NOTIF_ALL_USERS_FOUND, object: nil)
                        completion(true)
                    }
                })
                
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
      
        
    }
    
    func setUserInfo(data:Data){
        let json = try! JSON(data:data)
        let color = json[REQUEST_BODY_KEYS.AVATAR_COLOR].stringValue
        let avatarName = json[REQUEST_BODY_KEYS.AVATAR_NAME].stringValue
        let email = json[REQUEST_BODY_KEYS.EMAIL].stringValue
        let name = json[REQUEST_BODY_KEYS.NAME].stringValue
        let id = json[REQUEST_BODY_KEYS.ID].stringValue
        
        self.localUserDataService.setUserData(id: id, color: color, avatarName: avatarName, email: email, name: name)
    }
    
}
