//
//  AddChannelVC.swift
//  Smack
//
//  Created by Tushar Katyal on 22/08/17.
//  Copyright © 2017 Tushar Katyal. All rights reserved.
//

import UIKit

class AddChannelVC: UIViewController {

    //Outlets
    
    @IBOutlet weak var channelName: UITextField!
    @IBOutlet weak var channelDescription: UITextField!
    @IBOutlet weak var bgView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpView()
    }

 
    // gesture recognizer to close view, custom placeholder
    func setUpView() {
        let closeTouch = UITapGestureRecognizer(target: self, action: #selector(AddChannelVC.closeTap(_:)))
        bgView.addGestureRecognizer(closeTouch)
        
        channelName.attributedPlaceholder = NSAttributedString(string: "Channel Name", attributes: [NSAttributedStringKey.foregroundColor : SMACK_PLACEHOLDER])
        channelDescription.attributedPlaceholder = NSAttributedString(string: "Description", attributes: [NSAttributedStringKey.foregroundColor : SMACK_PLACEHOLDER])
    }
    @objc func closeTap(_ recognizer : UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    //Actions
    
    @IBAction func createBtnPressed(_ sender: Any) {
        
        guard let uChannelName = channelName.text , channelName.text != "" else {return}
        guard let  uChannelDesc = channelDescription.text, channelDescription.text != "" else {return}
        SocketService.instance.addChannel(channelName: uChannelName, channelDescription: uChannelDesc) { (success) in
            
            if success {
               self.dismiss(animated: true, completion: nil)
            }
        }
        
    }
    
    @IBAction func closeBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

}
