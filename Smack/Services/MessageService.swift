//
//  MessageService.swift
//  Smack
//
//  Created by Tushar Katyal on 22/08/17.
//  Copyright © 2017 Tushar Katyal. All rights reserved.
// MArk : To store Messages, channels

import Foundation
import Alamofire
import SwiftyJSON

class MessageService {
    
    static let instance = MessageService()
    
    // Variables
    var channels = [Channel]()
    var selectedChannel : Channel?
    var messages = [Message]()
    var unreadChannels = [String]()
    
    func findAllChannels(completion : @escaping CompletionHandler){
        
        Alamofire.request(GET_CHANNEL, method: HTTPMethod.get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            if response.result.error == nil {
                
                guard let data = response.data else {return}
                
                if let json = JSON(data: data).array {
                    
                    for item in json {
                        let name = item["name"].stringValue
                        let channelDescription = item["description"].stringValue
                        let id = item["_id"].stringValue
                        let channel = Channel(channelName: name, channelId: id, description: channelDescription)
                        self.channels.append(channel)
                        }
                    NotificationCenter.default.post(name: NOTIF_CHANNELS_LOADED, object: nil)
                    completion(true)
                    }
//                // swift 4 way of parsig JSON data, we have to make sure that the service has the var in same sequence
//                do {
//                    self.channels = try JSONDecoder().decode([Channel].self, from: data)
//                } catch let error{
//
//                    debugPrint(error as Any)
//
//                }
//                print(self.channels)
                
                } else {
                
                debugPrint(response.result.error as Any)
                completion(false)
                    }
                }
            }
    // remove channels when we logOut
    func clearChannels(){
        channels.removeAll()
    }
    // remove the messages
    func clearMessages() {
        messages.removeAll()
    }
    // get all the messages
    func findAllMessageForChannel(channelId : String,completion : @escaping CompletionHandler){
        
        Alamofire.request("\(GET_MESSAGES)\(channelId)", method: HTTPMethod.get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            if response.result.error == nil {
                self.clearMessages()
                
                guard let data = response.data else {return}
                if let json = JSON(data : data).array {
                    for item in json {
                        
                        let messageBody = item["messageBody"].stringValue
                        let channelId = item["channelId"].stringValue
                        let userName = item["userName"].stringValue
                        let userAvatar = item["userAvatar"].stringValue
                        let userAvatarColor = item["userAvatarColor"].stringValue
                        let id = item["_id"].stringValue
                        let timeStamp = item["timeStamp"].stringValue
         
                        let message = Message(message: messageBody, userName: userName, channelId: channelId, userAvatar: userAvatar, userAvatarColor: userAvatarColor, id: id, timeStamp: timeStamp)
                        self.messages.append(message)
                    }
                    print(self.messages)
                    completion(true)
                }
            } else {
                debugPrint(response.result.error as Any)
                completion(false)
            }
        }
    }
    
}
