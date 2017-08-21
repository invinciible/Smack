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
    
    // converting the avatarcolor string into uicolor
    
    func returnUIColor(components : String) -> UIColor {
        let scanner = Scanner(string: components)
        let skipped = CharacterSet(charactersIn: "[],")
        let comma = CharacterSet(charactersIn: ",")
        scanner.charactersToBeSkipped = skipped
        
        var r,b,g,a : NSString?
        
        scanner.scanUpToCharacters(from: comma, into: &r)
        scanner.scanUpToCharacters(from: comma, into: &b)
        scanner.scanUpToCharacters(from: comma, into: &g)
        scanner.scanUpToCharacters(from: comma, into: &a)
        
        let defaulColor = UIColor.lightGray
        
        guard let rUnwrapped = r else {return defaulColor}
        guard let bUnwrapped = b else {return defaulColor}
        guard let gUnwrapped = g else {return defaulColor}
        guard let aUnwrapped = a else {return defaulColor}
        
        let rFloat = CGFloat(rUnwrapped.doubleValue)
        let bFloat = CGFloat(bUnwrapped.doubleValue)
        let gFloat = CGFloat(gUnwrapped.doubleValue)
        let aFloat = CGFloat(aUnwrapped.doubleValue)
        
        
        return UIColor(red: rFloat, green: gFloat, blue: bFloat, alpha: 1)
        
    }
    
}
