//
//  SocketService.swift
//  Smack
//
//  Created by Mac on 10/4/18.
//  Copyright © 2018 Jonny B. All rights reserved.
//

import UIKit
import SocketIO

class SocketService: NSObject {

    static let instance = SocketService()
     var socket: SocketIOClient
    private var manager: SocketManager
    
    // for NSObjec we have to do super.init()
    private override init() {
        manager = SocketManager(socketURL: URL(string: "\(BASE_URL)")!, config: [.log(true), .compress])
        socket = manager.defaultSocket
        super.init()
    }
    
    func estabilishConnection() {
        socket.connect()
    }
    
    func closeConnection(){
        socket.disconnect()
    }
    
    func addChannel(channelName:String,channelDescription:String, completion: @escaping CompletionHandeler){
        socket.emit("newChannel",channelName,channelDescription )
        completion(true)
    }
    
        
    func startListeningOnGetChannel (completion: @escaping CompletionHandeler){
        socket.on("channelCreated") { (dataArray, ack) in
            guard let channelName =  dataArray[0] as? String else {return}
            guard let channelDesk =  dataArray[1] as? String else {return}
            guard let channelId =  dataArray[2] as? String else {return}
            
            let newChannel = Channel(channelTitle: channelName, channelDescription: channelDesk, id: channelId)
            MessageService.instance.channels.append(newChannel)
            completion(true)
        }
    }
    
    func addMessage(messageBody:String , userId:String, channelId:String, completion: @escaping CompletionHandeler){
        
        
        let user = LocalUserDataService.instance
        socket.emit("newMessage", messageBody, userId, channelId,user.name, user.avatarName, user.avatarColor)
        completion(true)
    }
    
    func startListeningOnGetChatMessage(completion: @escaping (_ newMwssage:Message) -> Void){
        socket.on("messageCreated") { (dataArray, ack) in
            guard let msgBody =  dataArray[0] as? String else {return}
            guard let channelId =  dataArray[2] as? String else {return}
            guard let userName =  dataArray[3] as? String else {return}
            guard let userAvatar =  dataArray[4] as? String else {return}
            guard let userAvatarColor =  dataArray[5] as? String else {return}
            guard let id =  dataArray[6] as? String else {return}
            guard let timeStamp =  dataArray[7] as? String else {return}
            
             let newMessage = Message(message: msgBody, userName: userName, channelId: channelId, userAvatar: userAvatar, userAvatarColor: userAvatarColor, id:id, timeStamp: timeStamp)
            
            completion(newMessage)
            
           
        }
        
    }
    
    func getTypingUsers(_ completionHandeler: @escaping (_ typingUsers :[String:String]) -> Void ){
        socket.on("userTypingUpdate") { (dataArray, ack) in
            guard let typingUsers = dataArray[0] as? [String:String] else {return}
            completionHandeler(typingUsers)
        }
        
    }
    
}
