//
//  LogginError.swift
//  Smack
//
//  Created by Mac on 10/30/18.
//  Copyright © 2018 Jonny B. All rights reserved.
//

import Foundation

enum LogginError: Error{
    case incompleteForm
    case invalidEmail
    case incorrectPasswordLengt 
}



extension String{
    var isValidemail:Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with:self)
        
    }
}
