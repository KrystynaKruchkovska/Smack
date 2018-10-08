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
        userImg.backgroundColor = UserDataServise.instance.returnUIColor(components: message.userAvatarColor)
        
    }
   

}
