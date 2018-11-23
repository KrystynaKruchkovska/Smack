//
//  UserDataService.swift
//  Smack
//
//  Created by Mac on 9/13/18.
//  Copyright © 2018 Jonny B. All rights reserved.
//

import Foundation

class LocalUserDataService{
    
    static let instance = LocalUserDataService()
    
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

    func updateName(name:String) {
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
        
        let defaultColor = UIColor.gray
        
        guard let rUnwrapped = r else {
            return defaultColor
        }
        guard let gUnwrapped = g else {
            return defaultColor
        }
        guard let bUnwrapped = b else {
            return defaultColor
        }
        guard let aUnwrapped = a else {
            return defaultColor
        }
    
        
        let rgbaDouble = [rUnwrapped, gUnwrapped, bUnwrapped, aUnwrapped]
    
        let rgba = rgbaDouble.map{ CGFloat($0.doubleValue) }
        
        let newColor = UIColor(red: rgba[0], green: rgba[1], blue: rgba[2], alpha: rgba[3])
        
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
        MessageService.instance.clearChannels()
        MessageService.instance.clearMessages()
    }
    
}
