//
//  GradientView.swift
//  Smack
//
//  Created by Tushar Katyal on 19/08/17.
//  Copyright © 2017 Tushar Katyal. All rights reserved.
//

import UIKit

@IBDesignable
class GradientView: UIView {

    @IBInspectable var topColor : UIColor = #colorLiteral(red: 0, green: 0.7843137255, blue: 0.3254901961, alpha: 1) {
        
        didSet {
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable var bottomColor : UIColor = #colorLiteral(red: 0.5098039216, green: 0.6941176471, blue: 1, alpha: 1) {
        
        didSet {
            self.setNeedsLayout()
        }
    }
    override func layoutSubviews() {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [topColor.cgColor,bottomColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at: 0)
    }

}
