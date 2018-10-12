//
//  HelloVC.swift
//  Smack
//
//  Created by Mac on 10/11/18.
//  Copyright © 2018 Jonny B. All rights reserved.
//

import UIKit

class HelloVC: UIViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(sender:)))
        rightSwipe.direction = .right
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(sender:)))
        
        leftSwipe.direction = .left
        
        
        view.addGestureRecognizer(rightSwipe)
        view.addGestureRecognizer(leftSwipe)
        // Do any additional setup after loading the view.
    }
    
    @objc func handleSwipe(sender:UISwipeGestureRecognizer){
        
        if sender.state == .ended{
            switch sender.direction{
            case .right, .left:
                performSegue(withIdentifier:TO_REVEAL_VC, sender:nil)
                
            default:
                break
            }
        }
        
    }
    
}
