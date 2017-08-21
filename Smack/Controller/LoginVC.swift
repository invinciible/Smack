//
//  LoginVC.swift
//  Smack
//
//  Created by Tushar Katyal on 19/08/17.
//  Copyright © 2017 Tushar Katyal. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
   
    // outlets
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

          setUpView()
    }

    
    
    
    func setUpView() {
        
        spinner.isHidden = true
        userNameField.attributedPlaceholder = NSAttributedString(string: "Username", attributes: [NSAttributedStringKey.foregroundColor : SMACK_PLACEHOLDER])
        passwordField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedStringKey.foregroundColor : SMACK_PLACEHOLDER])
        
    }

    // Actions
    @IBAction func closeBtnPressed(_ sender: Any) {
       dismiss(animated: true, completion: nil)
    }
    
    @IBAction func createAccountBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_CREATE_ACCOUNT, sender: nil)
    }
    
    @IBAction func loginBtnPressed(_ sender: Any) {
        spinner.isHidden = false
        spinner.startAnimating()
        
        guard let email = userNameField.text , userNameField.text != "" else {return}
        guard let userPass = passwordField.text , passwordField.text != "" else {return}
        
        AuthService.instance.loginUser(email: email, password: userPass) { (success) in
            
            if success {
                
                AuthService.instance.findUserByEmail(completion: { (success) in
                    if success {
                        NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
                        self.spinner.isHidden = true
                        self.spinner.stopAnimating()
                        self.dismiss(animated: true, completion: nil)
                    }
                })
            }
        }
    }
    
    
}
