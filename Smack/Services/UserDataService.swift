//
//  UserDataService.swift
//  Smack
//
//  Created by Tushar Katyal on 20/08/17.
//  Copyright © 2017 Tushar Katyal. All rights reserved.
//

import Foundation
class UserDataService {
    
    
    static let instance = UserDataService()
    
    public private(set) var id = ""
    public private(set) var name = ""
    public private(set) var email = ""
    public private(set) var avatarName = ""
    public private(set) var avatarColor = ""
    
    func setUserData(id : String,name: String,email :String,avatarName :String,avatarColor : String) {
        
        self.id = id
        self.name = name
        self.avatarColor = avatarColor
        self.email = email
        self.avatarName = avatarName
    }
    
    func setAvatarName(avatarName : String) {
        
        self.avatarName = avatarName
    }
    
    
}
