//
//  AddChannelVC.swift
//  Smack
//
//  Created by Mac on 10/4/18.
//  Copyright © 2018 Jonny B. All rights reserved.
//

import UIKit

class AddChannelVC: UIViewController {

    @IBOutlet weak var chanDescTxt: UITextField!
    @IBOutlet weak var nameTxt: UITextField!
    
    @IBOutlet weak var bgView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()

    }

    @IBAction func closeBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func createChannelPressed(_ sender: Any) {
        guard  var name = nameTxt.text, nameTxt.text != "" else {return}
        guard var description = chanDescTxt.text, chanDescTxt.text != "" else {return}
        SocketService.instance.addChannel(channelName: name, channelDescription: description) { (success) in
            if success {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    func setUpView(){
        let closeTouch = UITapGestureRecognizer(target: self, action: #selector(AddChannelVC.closeTap(_:)))
        bgView.addGestureRecognizer(closeTouch)
        
        nameTxt.attributedPlaceholder = NSAttributedString(string: "name", attributes: [NSAttributedStringKey.foregroundColor : smackPurplePlaceholder])
        
      chanDescTxt.attributedPlaceholder = NSAttributedString(string: "description", attributes: [NSAttributedStringKey.foregroundColor : smackPurplePlaceholder])
    }
    @objc func closeTap(_ recognizer: UITapGestureRecognizer){
        dismiss(animated: true, completion: nil)
    }


}
