//
//  Constants.swift
//  Smack
//
//  Created by Tushar Katyal on 19/08/17.
//  Copyright © 2017 Tushar Katyal. All rights reserved.
//

import Foundation

// segues
let TO_LOGIN = "toLogin"
let TO_CREATE_ACCOUNT = "toCreateAccount"
let UNWIND = "unwindToChannel"
let TO_AVATAR_PICKER = "toAvatarPicker"
// User defaults
let LOGGED_IN_KEY = "loggedin"
let TOKEN_KEY = "token"
let USER_EMAIL = "useremail"

//notifications constants
let NOTIF_USER_DATA_DID_CHANGE = Notification.Name("notifUserDataChanged")


typealias CompletionHandler = (_ Success: Bool) -> ()

// URL

let BASE_URL = "https://chatsmackwith.herokuapp.com/v1/"
let REGISTER_URL = "\(BASE_URL)account/register"
let LOGIN_URL = "\(BASE_URL)account/login"
let ADD_USER = "\(BASE_URL)user/add"
let USER_BY_EMAIL = "\(BASE_URL)user/byEmail/"
let GET_CHANNEL = "\(BASE_URL)/channel/"

// header
let HEADER = [ "Content-Type" : "application/json ; charset=utf-8"]
let BEARER_HEADER = ["Authorization" : "Bearer \(AuthService.instance.authToken)","Content-Type" : "application/json ; charset=utf-8"]

// Colors
let SMACK_PLACEHOLDER = #colorLiteral(red: 0.3266413212, green: 0.4215201139, blue: 0.7752227187, alpha: 0.5)
