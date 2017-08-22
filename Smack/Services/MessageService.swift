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
    
    static var instance = MessageService()
    
    var channels = [Channel]()
    
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
}
