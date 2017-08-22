//
//  ChannelCell.swift
//  Smack
//
//  Created by Tushar Katyal on 22/08/17.
//  Copyright © 2017 Tushar Katyal. All rights reserved.
//

import UIKit

class ChannelCell: UITableViewCell {

    //outlets
    @IBOutlet weak var channelName : UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if selected {
            self.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.2003211273)
        } else {
            self.layer.backgroundColor = UIColor.clear.cgColor
        }
    }

    func configureCell(channel : Channel) {
        let title = channel.channelName ?? ""
        channelName.text = "#\(title)"
    }
}
