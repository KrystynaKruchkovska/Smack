//
//  RoundedButton.swift
//  Smack
//
//  Created by Mac on 9/3/18.
//  Copyright © 2018 Jonny B. All rights reserved.
//

import UIKit
@IBDesignable

class RoundedButton: UIButton {
    @IBInspectable var cornerRadius : CGFloat = 3.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    override func awakeFromNib() {
        self.setupView()
    }
    
    override func prepareForInterfaceBuilder() {
        self.setupView()
    }
    func setupView(){
        self.layer.cornerRadius = cornerRadius
    }
}
