//
//  CircleImgView.swift
//  Smack
//
//  Created by Mac on 9/28/18.
//  Copyright © 2018 Jonny B. All rights reserved.
//

import UIKit
@IBDesignable
class CircleImgView: UIImageView {
    
    override func awakeFromNib() {
        setUpView()
    }

    func setUpView(){
        self.layer.cornerRadius = self.frame.width / 2
        self.clipsToBounds = true
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.setUpView()
    }

}
