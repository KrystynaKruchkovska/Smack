//
//  LeagueVC.swift
//  Smack
//
//  Created by Mac on 7/19/18.
//  Copyright © 2018 CO.KrystynaKruchcovska. All rights reserved.
//

import Foundation

typealias CompletionHandeler = (_ Success: Bool) -> ()

//URL Constants
let BASE_URL = " https://tinaschattychatchat.herokuapp.com/v1/"
let URL_REGISTER = "\(BASE_URL)account/register"

// segues
let TO_LOGIN = "toLogin"

let TO_CREATE_ACCOUNT = "toCreateAccount"
let UNWIND = "unwindToChannel"


//Users defaults
let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL = "userEmail"

