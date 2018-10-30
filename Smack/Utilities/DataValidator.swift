//
//  DataValidator.swift
//  Smack
//
//  Created by Mac on 10/30/18.
//  Copyright © 2018 Jonny B. All rights reserved.
//

import UIKit

class DataValidator {
    
    static func isCredentialCorrect(email:String,password:String, vc:UIViewController) -> Bool{
        
        do{
            try validateLogin(email: email, password: password)
            
        } catch LogginError.incompleteForm {
            Alert.showBasic(title: "Incomplete Form", message: "Please fill out bouth email and password fields", vc: vc)
            return false
        } catch LogginError.incorrectPasswordLengt {
            Alert.showBasic(title: "incorrect Password Lengt", message: "Password should be at least 8 characters", vc: vc)
            return false
        } catch LogginError.invalidEmail {
            Alert.showBasic(title: "Invalid Email", message: "Make sure you format your email correctly", vc: vc)
            return false
        } catch  {
            Alert.showBasic(title: "Unable To Login", message: "There was an error when attamping to login", vc: vc)
            return false
        }
        
        return true
    }
    
    static func validateLogin(email:String,password:String) throws{
        
        if email.isEmpty || password.isEmpty{
            throw LogginError.incompleteForm
        }
        
        if !email.isValidemail {
            throw LogginError.invalidEmail
        }
        
        if password.count < 8 {
            throw LogginError.incorrectPasswordLengt
        }
    }
}
