//
//  SocketService.swift
//  Smack
//
//  Created by Tushar Katyal on 22/08/17.
//  Copyright © 2017 Tushar Katyal. All rights reserved.
//

import UIKit
import SocketIO

class SocketService: NSObject {

    static let instance = SocketService()
    
    override init() {
        super.init()
    }
    
    var socket : SocketIOClient = SocketIOClient(socketURL: URL(string: BASE_URL)!)
    
    
    func establishConnection() {
        socket.connect()
    }
    func closeConnection() {
        socket.disconnect()
    }
    // To add a channel
    func addChannel(channelName : String , channelDescription : String, completion : @escaping CompletionHandler){
        
        socket.emit("newChannel", channelName,channelDescription)
        completion(true)
    }
    
    func getChannel(completion : @escaping CompletionHandler) {
        
        socket.on("channelCreated") { (dataArray, ack) in
            
            guard let channelName = dataArray[0] as? String else {return}
            guard let channelDesc = dataArray[1] as? String else {return}
            guard let channelId = dataArray[2] as? String else {return}
           
            let newChannel = Channel.init(channelName: channelName, channelId: channelId, description: channelDesc)
            MessageService.instance.channels.append(newChannel)
            completion(true)
        }
    }
    
    // when user sends a message
    func addMessage(messageBody : String, userId: String,channelId: String, completion : @escaping CompletionHandler) {
        
        let user = UserDataService.instance
        socket.emit("newMessage", messageBody,userId, channelId ,user.name,user.avatarName,user.avatarColor)
        completion(true)
    }
    
    
    
    func getChatMessage(completion: @escaping CompletionHandler) {
        
        socket.on("messageCreated") { (dataArray, ack) in
            
            guard let msgbody = dataArray[0] as? String else {return}
            guard let channelId = dataArray[2] as? String else {return}
           // guard let msgUserId = dataArray[1] as? String else {return}
            guard let userName = dataArray[3] as? String else {return}
            guard let userAvatar = dataArray[4] as? String else {return}
            guard let useravatarColor = dataArray[5] as? String else {return}
            guard let id = dataArray[6] as? String else {return}
            guard let timeStamp = dataArray[7] as? String else {return}
            
            if channelId == MessageService.instance.selectedChannel?.channelId && AuthService.instance.isLoggedIn {
                let newMessage = Message(message: msgbody, userName: userName, channelId: channelId, userAvatar: userAvatar, userAvatarColor: useravatarColor, id: id, timeStamp: timeStamp)
                MessageService.instance.messages.append(newMessage)
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
    func getTypingUsers(_ completionHandler : @escaping (_ typingUsers : [String:String] )-> Void) {
        
        socket.on("userTypingUpdate") { (dataArray, ack) in
            
            guard let typingUsers = dataArray[0] as? [String: String] else {return}
            completionHandler(typingUsers)
        }
    }
    
    
}
