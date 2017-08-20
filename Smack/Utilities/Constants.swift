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

// User defaults
let LOGGED_IN_KEY = "loggedin"
let TOKEN_KEY = "token"
let USER_EMAIL = "useremail"

//
typealias CompletionHandler = (_ Success: Bool) -> ()

// URL

let BASE_URL = "https://chatsmackwith.herokuapp.com/v1/"
let REGISTER_URL = "\(BASE_URL)account/register"
let LOGIN_URL = "\(BASE_URL)account/login"
let ADD_USER = "\(BASE_URL)user/add"


// header
let HEADER = [ "Content-Type" : "application/json ; charset=utf-8"]
