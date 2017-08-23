//
//  EditProfileVC.swift
//  Smack
//
//  Created by Tushar Katyal on 23/08/17.
//  Copyright © 2017 Tushar Katyal. All rights reserved.
//

import UIKit

class EditProfileVC: UIViewController {

    // outlets
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var newNameField: UITextField!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        spinner.isHidden = true
        newNameField.attributedPlaceholder = NSAttributedString(string: "Enter new name", attributes: [NSAttributedStringKey.foregroundColor : SMACK_PLACEHOLDER])
        newNameField.text = UserDataService.instance.name
        
        let tapClose = UITapGestureRecognizer(target: self, action: #selector(EditProfileVC.closeModalPrssed(_:)))
        bgView.addGestureRecognizer(tapClose)
        
    }

    @objc func tapCloseModel(_ recognizer : UITapGestureRecognizer) {
        
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func updateBtnPressed(_ sender: Any) {
        guard newNameField.text != UserDataService.instance.name else {return}
        
        guard let newName = newNameField.text , newNameField.text != "" else {return}
        spinner.isHidden = false
        spinner.startAnimating()
        AuthService.instance.updateUserName(name: newName) { (success) in
            
            if success {
                self.spinner.isHidden = true
                self.spinner.stopAnimating()
                AuthService.instance.findUserByEmail(completion: { (success) in
                    NotificationCenter.default.post(name: NOTIF_USERDATA_UPDATE, object: nil)
                    print("tush :",UserDataService.instance.name)
                    print("tush :", MessageService.instance.channels.count)
                    self.dismiss(animated: true, completion: nil)
                })
                
            }
        }
        
    }
    
    @IBAction func closeModalPrssed(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
}
