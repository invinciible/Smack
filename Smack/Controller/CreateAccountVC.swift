//
//  CreateAccountVC.swift
//  Smack
//
//  Created by Tushar Katyal on 19/08/17.
//  Copyright © 2017 Tushar Katyal. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    @IBAction func closeBtnPressed(_ sender : Any) {
        
        performSegue(withIdentifier: UNWIND, sender: nil)
    }
}
