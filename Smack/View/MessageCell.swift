//
//  MessageCell.swift
//  Smack
//
//  Created by Mac on 10/8/18.
//  Copyright © 2018 Jonny B. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {
    
    // Outlets
    
    @IBOutlet weak var userImg: CircleImgView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var timeStampLbl: UILabel!
    @IBOutlet weak var messageBodyLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(message:Message){
        
        messageBodyLbl.text = message.message
        userName.text = message.userName
        userImg.image = UIImage(named: message.userAvatar)
        userImg.backgroundColor = LocalUserDataService.instance.returnUIColor(components: message.userAvatarColor)
        
        
        //2018-19-9T18:02:10.520Z
        
        guard var isoData = message.timeStamp else {return}
        let end = isoData.index(isoData.endIndex, offsetBy: -5)
        isoData = String(isoData[..<end])
        
        let isoFormatter = ISO8601DateFormatter()
        let chatDate = isoFormatter.date(from: isoData.appending("Z"))
        
        let newFormatter = DateFormatter()
        newFormatter.dateFormat = "MMM d, h:m a"
        
        
        if let finalDate = chatDate {
           let finalDate = newFormatter.string(from: finalDate)
            timeStampLbl.text = finalDate
        }
        
        
    }
   

}
