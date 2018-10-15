//
//  UserCell.swift
//  Smack
//
//  Created by Mac on 10/15/18.
//  Copyright © 2018 Jonny B. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {
    
    
    @IBOutlet weak var userImg: UIImageView!
    
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var userEmailLbl: UILabel!
    
    @IBOutlet weak var deleteBtn: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected{
            self.deleteBtn.isHidden = false
        }else{
            self.deleteBtn.isHidden = true
            
        }
    }

}
