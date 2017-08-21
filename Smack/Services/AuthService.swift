//
//  AuthService.swift
//  Smack
//
//  Created by Tushar Katyal on 20/08/17.
//  Copyright © 2017 Tushar Katyal. All rights reserved.
// Singleton class

import Foundation
import Alamofire
import SwiftyJSON
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
    
    // MArk : Register user with email and pass
    func registerUSer(email : String , password : String , completion : @escaping CompletionHandler) {
        
        let lowerCasedEmail = email.lowercased()
        let body : [String:Any] = [ "email" : lowerCasedEmail , "password" : password]
        
        Alamofire.request(REGISTER_URL, method: HTTPMethod.post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseString { (response) in
            
            if response.result.error == nil {
                completion(true)
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
        
       }
    // Mark : Authorize user with email and pass
    func loginUser(email : String , password : String, completion : @escaping CompletionHandler) {
        let lowerCasedEmail = email.lowercased()
        let body : [String:Any] = [ "email" : lowerCasedEmail , "password" : password]
        
        Alamofire.request(LOGIN_URL, method: HTTPMethod.post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response) in
            
            if response.result.error == nil {
                
//                if let json = response.result.value as? Dictionary<String,Any> {
//
//                    if let email = json["user"] as? String {
//                        self.userEmail = email
//                    }
//                    if let token = json["token"] as? String {
//                        self.authToken = token
//                    }
//                }
                // using swiftyJSON
                guard let data  = response.data else { return }
                let json = JSON(data: data)
                self.userEmail = json["user"].stringValue
                self.authToken = json["token"].stringValue
                
                self.isLoggedIn = true
                completion(true)
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
          }
        }
    
    // Mark : To create new user
    func createUser(name: String, email : String, avatarName: String, avatarColor : String, completion : @escaping CompletionHandler){
        let lowerCasedEmail = email.lowercased()
        let body : [String: Any] =
        [
            "name" : name,
            "email" : lowerCasedEmail,
            "avatarName" : avatarName,
            "avatarColor" : avatarColor
        ]

        Alamofire.request(ADD_USER, method: HTTPMethod.post, parameters: body, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            
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
    
    // when user login , search the data using the login email
    func findUserByEmail(completion : @escaping CompletionHandler) {
        
        Alamofire.request("\(USER_BY_EMAIL)\(userEmail)", method: HTTPMethod.get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            
            if response.result.error == nil {
                
                guard let data = response.data else {return}
                self.setUserInfo(data: data)
                completion(true)
            } else {
                
                print("Tush : error ")
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    // update user data
    func setUserInfo(data : Data) {
        
        let json = JSON(data: data)
        let id = json["_id"].stringValue
        let email = json["email"].stringValue
        let avatarName = json["avatarName"].stringValue
        let avatarColor = json["avatarColor"].stringValue
        let name = json["name"].stringValue
       
        UserDataService.instance.setUserData(id: id, name: name, email: email, avatarName: avatarName, avatarColor: avatarColor)
    }
}





