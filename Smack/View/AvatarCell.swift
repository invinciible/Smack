//
//  AvatarCell.swift
//  Smack
//
//  Created by Tushar Katyal on 20/08/17.
//  Copyright © 2017 Tushar Katyal. All rights reserved.
//

import UIKit

class AvatarCell: UICollectionViewCell {
    
    @IBOutlet weak var avatarImg : UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupView()
   
    }
    
    func setupView(){
        self.layer.backgroundColor = UIColor.lightGray.cgColor
        self.layer.cornerRadius = 10.0
        self.clipsToBounds = true
    }
}
