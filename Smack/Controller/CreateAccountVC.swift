//
//  CreateAccountVC.swift
//  Smack
//
//  Created by Tushar Katyal on 19/08/17.
//  Copyright © 2017 Tushar Katyal. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {

    // outlets
    @IBOutlet weak var userEmailTxt : UITextField!
    @IBOutlet weak var userPasswordTxt : UITextField!
    @IBOutlet weak var userNameTxt : UITextField!
    @IBOutlet weak var userAvatarImg : UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

         }

    // Actions
    @IBAction func createAccountPressed( _ sender : Any) {
        
        guard let userEmail = userEmailTxt.text , userEmail != ""  else { return }
        guard let userPass = userPasswordTxt.text , userPass != ""  else { return }
        
        AuthService.instance.registerUSer(email: userEmail, password: userPass) { (success) in
            if success {
                print("registered user!")
            }
        }
    }
    @IBAction func pickAvatarPressed(_ sender : Any) {
        
    }
    @IBAction func pickBgColorPressed( _ sender : Any) {
        
    }
    
    @IBAction func closeBtnPressed(_ sender : Any) {
        
        performSegue(withIdentifier: UNWIND, sender: nil)
    }
}
