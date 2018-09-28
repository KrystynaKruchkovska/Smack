//
//  AvatarCell.swift
//  Smack
//
//  Created by Mac on 9/28/18.
//  Copyright © 2018 Jonny B. All rights reserved.
//

import UIKit
enum AvatarType{
    case dark
    case light
}

class AvatarCell: UICollectionViewCell {
    
    
    @IBOutlet weak var avatarImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        seyUpView()
    }
    
    func configureCell(index:Int, type:AvatarType) {
        if type == AvatarType.dark{
            avatarImg.image = UIImage(named:"dark\(index)")
            self.layer.backgroundColor = UIColor.lightGray.cgColor
        }
        else{
            avatarImg.image = UIImage(named:"light\(index)")
            self.layer.backgroundColor = UIColor.gray.cgColor
        }
    }
    
    func seyUpView(){
        self.layer.backgroundColor = UIColor.lightGray.cgColor
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        
    }
}
