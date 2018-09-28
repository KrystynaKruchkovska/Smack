//
//  AvatarCell.swift
//  Smack
//
//  Created by Mac on 9/28/18.
//  Copyright © 2018 Jonny B. All rights reserved.
//

import UIKit

class AvatarCell: UICollectionViewCell {
    
    
    @IBOutlet weak var avatarImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        seyUpView()
    }
    
    func seyUpView(){
        self.layer.backgroundColor = UIColor.lightGray.cgColor
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        
    }
}
