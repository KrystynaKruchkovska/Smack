//
//  MassegeService.swift
//  Smack
//
//  Created by Mac on 10/3/18.
//  Copyright © 2018 Jonny B. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class MessageService {
    
    static let instance = MessageService()
    
    var channels = [Channel]()
    var messages = [Message]()
    var unreadChannels = [String]()
    var selectedChannel:Channel?
    
    func findAllChannels(completion:@escaping CompletionHandeler){
        Alamofire.request(URL_GET_CHANNELS, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            if response.result.error == nil{
                guard let data = response.data else{return}
                //parsing json decoding way
                //                do {
                //                    self.chanels =  try JSONDecoder().decode([Channels].self, from: data)
                //                }catch let error {
                //                    debugPrint(error as Any)
                //
                //                }
                //                print (self.chanels)
                
                if let json = try! JSON(data:data).array{
                    for item in json {
                        let name = item["name"].stringValue
                        let channelDescription = item["description"].stringValue
                        let id = item["_id"].stringValue
                        let channel = Channel(channelTitle: name, channelDescription: channelDescription, id: id)
                        self.channels.append(channel)
                    }
                    NotificationCenter.default.post(name: NOTIF_CHANNALS_LOADED, object: nil)
                    completion(true)
                
                    }
                }else{
                    completion(false)
                    debugPrint(response.result.error!)
                }
        }
        
    }
    func clearChannels (){
        channels.removeAll()
    }
    
    func clearMessages(){
        messages.removeAll()
    }
    
    func findAllMessagesForChannel(channedId:String, completion :@escaping CompletionHandeler) {
        Alamofire.request("\(URL_GET_MESSAGES)\(channedId)", method:.get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            
            if response.result.error == nil {
                self.clearMessages()
                guard let data = response.data else{ return }
                
                if let json = try! JSON(data:data).array{
                    
                    for item in json {
                        let messageBody = item["messageBody"].stringValue
                        let channelId = item["channelId"].stringValue
                        let id = item["_id"].stringValue
                        let userName = item["userName"].stringValue
                        let userAvatar = item["userAvatar"].stringValue
                        let userAvatarColor = item["userAvatarColor"].stringValue
                        let timeStamp = item["timeStamp"].stringValue
                        
                        let message = Message(message: messageBody, userName: userName, channelId: channelId, userAvatar: userAvatar, userAvatarColor: userAvatarColor, id: id, timeStamp: timeStamp)
                        self.messages.append(message)
                    }
                        print(self.messages)
                        completion(true)
                    }
                    
                 else {
                    debugPrint(response.result.error as Any)
                    completion(false)
                    
                }
            }
         
        }
    }
}
