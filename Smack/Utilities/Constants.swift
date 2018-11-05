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
let BASE_URL = "https://tinaschattychatchat.herokuapp.com/v1/"
let URL_REGISTER = "\(BASE_URL)account/register"
let URL_LOGIN = "\(BASE_URL)account/login"
let URL_USER_ADD = "\(BASE_URL)user/add"
let URL_USER_BY_EMAIL = "\(BASE_URL)user/byEmail/"
let URL_GET_CHANNELS = "\(BASE_URL)channel/"
let URL_GET_MESSAGES = "\(BASE_URL)message/byChannel/"
let URL_FIND_ALL_USER = "\(BASE_URL)user/"



// 5baf5e3ada557f00265e4779
//Colors
let smackPurplePlaceholder = #colorLiteral(red: 0.3266413212, green: 0.4215201139, blue: 0.7752227187, alpha: 0.5)
//Notification constant
let NOTIF_USER_DATA_DID_CHANGE = Notification.Name("NotifUserDataChanged")
let NOTIF_CHANNALS_LOADED = Notification.Name("ChannelsLoaded")
let NOTIF_CHANNAL_SELECTED = Notification.Name("ChannelSelected")
let NOTIF_ALL_USERS_FOUND = Notification.Name("FindedAllUsers")
let NOTIF_USER_LOGOUT = Notification.Name("UserIsLogout")


// segues
let TO_LOGIN = "toLogin"
let TO_CREATE_ACCOUNT = "toCreateAccount"
let UNWIND = "unwindToChannel"
let TO_AVATAR_PICKER = "toAvatarPicker"
let TO_REVEAL_VC = "toRevealVC"
let TO_ADMIN_PANEL = "toAdminPanel"


//Users defaults
let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL = "userEmail"

//Admins
let adminsArray = ["5bdec3aefb065b00268f2a96"] // admin user

//Headers
let HEADER =  [
    "Content-Type": "application/json; charset=utf-8 "
]
let BEARER_HEADER = [
    "Authorization":"Bearer \(AuthService.instance.authToken)",
    "Content-Type": "application/json; charset=utf-8 "
    
]
