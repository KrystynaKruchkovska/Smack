//
//  UserDataService.swift
//  Smack
//
//  Created by Mac on 9/13/18.
//  Copyright © 2018 Jonny B. All rights reserved.
//

import Foundation

class UserDataServise{
    
    static let instance = UserDataServise()
    
    public private(set) var id = ""
    public private(set) var avatarColor = ""
    public private(set) var avatarName = ""
    public private(set) var email = ""
    public private(set) var name = ""
    
    
    func setUserData(id:String, color:String, avatarName:String, email:String, name:String) {
        
        self.id = id
        self.avatarColor = color
        self.avatarName = avatarName
        self.email = email
        self.name = name
    }
    func setAvatarName(avatarName:String) {
        self.avatarName = avatarName
        
    }
    
    func returnUIColor(components:String) -> UIColor{
        let scanner = Scanner(string: components)
        let skipped = CharacterSet(charactersIn:"[], ")
        let comma = CharacterSet(charactersIn: ",")
        scanner.charactersToBeSkipped = skipped
        
        var r,g,b,a : NSString?
        
        scanner.scanUpToCharacters(from: comma, into: &r)
        scanner.scanUpToCharacters(from: comma, into: &g)
        scanner.scanUpToCharacters(from: comma, into: &b)
        scanner.scanUpToCharacters(from: comma, into: &a)
        
        let defoultColor = UIColor.gray
        
        
        guard let rUnwrapped = r else {
            return defoultColor
        }
        guard let gUnwrapped = g else {
            return defoultColor
        }
        guard let bUnwrapped = b else {
            return defoultColor
        }
        guard let aUnwrapped = a else {
            return defoultColor
        }
        
        
        let rFloat = CGFloat(rUnwrapped.doubleValue)
        let gFloat = CGFloat(gUnwrapped.doubleValue)
        let bFloat = CGFloat(bUnwrapped.doubleValue)
        let aFloat = CGFloat(aUnwrapped.doubleValue)
        
        let newColor = UIColor(red: rFloat, green: gFloat, blue: bFloat, alpha: aFloat)
        
        return newColor
    }
    
    func logoutUser(){
        id = ""
        avatarName = ""
        avatarColor = ""
        name = ""
        email = ""
        AuthService.instance.isLoggedIn = false
        AuthService.instance.userEmail = ""
        AuthService.instance.authToken = ""
        MassegeService.instance.clearChannels()
        
    }
    
}
