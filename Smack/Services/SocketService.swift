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
    
}
