//
//  RoundedButton.swift
//  Smack
//
//  Created by Tushar Katyal on 20/08/17.
//  Copyright © 2017 Tushar Katyal. All rights reserved.
//

import UIKit

class RoundedButton: UIButton {

   
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.cornerRadius = 5.0
    }

}
