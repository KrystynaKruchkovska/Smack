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

class MassegeService {
    
    static let instance = MassegeService()
    
    var channels = [Channels]()
    
    func findAllChannels(completion:@escaping CompletionHandeler){
        Alamofire.request(GET_CHANNELS, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
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
                        let channel = Channels(channelTitle: name, channelDescription: channelDescription, id: id)
                           self.channels.append(channel)
                    }
//                print(self.channels[0].channelTitle)
                 completion(true)
                }
//
            }else{
                completion(false)
                debugPrint(response.result.error!)
            }
        }
        
    }
    
    
}
