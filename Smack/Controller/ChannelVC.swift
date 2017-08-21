//
//  ChannelVC.swift
//  Smack
//
//  Created by Tushar Katyal on 19/08/17.
//  Copyright © 2017 Tushar Katyal. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController {
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var userImg: RoundedImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 70
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.userDataDidChange(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
    }

    @objc func userDataDidChange(_ notif : Notification) {
        
        if AuthService.instance.isLoggedIn {
        loginBtn.setTitle(UserDataService.instance.name, for: .normal)
            userImg.image = UIImage(named : UserDataService.instance.avatarName)
            userImg.backgroundColor = UserDataService.instance.returnUIColor(components: UserDataService.instance.avatarColor)
        } else {
             loginBtn.setTitle("Login", for: .normal)
            userImg.image = UIImage(named: "menuProfileIcon")
            userImg.backgroundColor = UIColor.lightGray
        }
    }
    
    
    
    @IBAction func loginBtnPressed(_ sender: Any) {
        
        if AuthService.instance.isLoggedIn {
           
            let profile = ProfileVC()
            profile.modalPresentationStyle = .custom
            present(profile, animated: true, completion: nil)
            
        } else {
            
            performSegue(withIdentifier: TO_LOGIN, sender: nil)
        }
        
        
    }
    @IBAction func prepareForUnwind(segue : UIStoryboardSegue){}
}
