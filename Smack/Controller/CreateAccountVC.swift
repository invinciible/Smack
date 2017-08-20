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
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    //Variables
    var avatarName = "profileDefault"
    var avatarColor = "[0.5 ,0.5 ,0.5 ,1]"
    var bgColor : UIColor?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        spinner.isHidden = true
         }

    override func viewDidAppear(_ animated: Bool) {
        if UserDataService.instance.avatarName != "" {
            
            userAvatarImg.image = UIImage(named : UserDataService.instance.avatarName)
            avatarName = UserDataService.instance.avatarName
            if avatarName.contains("light") && bgColor == nil {
                userAvatarImg.backgroundColor = UIColor.lightGray
            }
        }
    }
    
    // Actions
    @IBAction func createAccountPressed( _ sender : Any) {
        
        spinner.isHidden = false
        spinner.startAnimating()
        
        guard let userEmail = userEmailTxt.text , userEmail != ""  else { return }
        guard let userPass = userPasswordTxt.text , userPass != ""  else { return }
        guard let userName = userNameTxt.text , userName != "" else {return}
        AuthService.instance.registerUSer(email: userEmail, password: userPass) { (success) in
            if success {
                print("registered user!")
                AuthService.instance.loginUser(email: userEmail, password: userPass, completion: { (success) in
                    if success {
                        AuthService.instance.createUser(name: userName, email: userEmail, avatarName: self.avatarName, avatarColor: self.avatarColor, completion: { (success) in
                            if success {
                                self.spinner.isHidden = true
                                self.spinner.stopAnimating()
                                self.performSegue(withIdentifier: UNWIND, sender: nil)
                                NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
                            }
                        })
                    }
                })
            }
        }
    }
    @IBAction func pickAvatarPressed(_ sender : Any) {
        performSegue(withIdentifier: TO_AVATAR_PICKER, sender: nil)
        
    }
    @IBAction func pickBgColorPressed( _ sender : Any) {
        
        let r = CGFloat(arc4random_uniform(255)) / 255
        let g = CGFloat(arc4random_uniform(255)) / 255
        let b = CGFloat(arc4random_uniform(255)) / 255
        
        bgColor = UIColor(red: r, green: g, blue: b, alpha: 1)
        
        UIView.animate(withDuration: 0.2) {
            self.userAvatarImg.backgroundColor = self.bgColor
        }
        
    }
    
    @IBAction func closeBtnPressed(_ sender : Any) {
        
        performSegue(withIdentifier: UNWIND, sender: nil)
    }
    
    func setupView() {
        
        userNameTxt.attributedPlaceholder = NSAttributedString(string: "Username", attributes: [NSAttributedStringKey.foregroundColor : SMACK_PLACEHOLDER])
        userEmailTxt.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedStringKey.foregroundColor : SMACK_PLACEHOLDER])
         userPasswordTxt.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedStringKey.foregroundColor : SMACK_PLACEHOLDER])
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(CreateAccountVC.handleTap))
        view.addGestureRecognizer(tap)
    }
    @objc func handleTap() {
        view.endEditing(true)
    }
}
