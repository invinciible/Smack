//
//  AuthService.swift
//  Smack
//
//  Created by Tushar Katyal on 20/08/17.
//  Copyright © 2017 Tushar Katyal. All rights reserved.
// Singleton class

import Foundation
import Alamofire

class AuthService {
    
    static let instance = AuthService()
    
    let defaults = UserDefaults.standard
    
    // MArk : User defauls
    var isLoggedIn : Bool {
        
        get {
           return defaults.bool(forKey: LOGGED_IN_KEY)
        }
        set {
            defaults.set(newValue, forKey: LOGGED_IN_KEY)
        }
    }
    
    var authToken : String {
        get {
            return defaults.value(forKey: TOKEN_KEY) as! String
        }
        set {
            
            defaults.set(newValue, forKey: TOKEN_KEY)
        }
    }
    var userEmail : String {
        get {
           return defaults.value(forKey: USER_EMAIL) as! String
        }
        set {
            defaults.set(newValue, forKey: USER_EMAIL)
        }
    }
    
    // MArk : Http post request function
    func registerUSer(email : String , password : String , completion : @escaping CompletionHandler) {
        
        let lowerCasedEmail = email.lowercased()
        
        let header = [ "Content-Type" : "application/json ; charset=utf-8"
        ]
        let body : [String:Any] = [ "email" : lowerCasedEmail , "password" : password]
        
        Alamofire.request(REGISTER_URL, method: HTTPMethod.post, parameters: body, encoding: JSONEncoding.default, headers: header).responseString { (response) in
            
            if response.result.error == nil {
                completion(true)
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
        
    }
    
}





