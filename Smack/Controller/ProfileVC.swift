//
//  ProfileVC.swift
//  Smack
//
//  Created by Tushar Katyal on 21/08/17.
//  Copyright © 2017 Tushar Katyal. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {

    
    @IBOutlet weak var profileImg: RoundedImage!
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var bgView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showProfileView()
        
    }
    
    func showProfileView() {
        userName.text = UserDataService.instance.name
        profileImg.image = UIImage(named: UserDataService.instance.avatarName)
        userEmail.text = UserDataService.instance.email
        profileImg.backgroundColor = UserDataService.instance.returnUIColor(components: UserDataService.instance.avatarColor)
        
        let closetouch = UITapGestureRecognizer(target: self, action:#selector(ProfileVC.closeTap(_:)))
        view.addGestureRecognizer(closetouch)
    }
    
    @objc func closeTap(_ recognizer : UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func closeModelPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func logoutPressed(_ sender: Any) {
        UserDataService.instance.logoutUser()
        NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        dismiss(animated: true, completion: nil)
    }
    
   
   
    
}
