//
//  Gradiant.swift
//  Artistico
//
//  Created by kaushal on 11/19/16.
//  Copyright © 2016 kaushal. All rights reserved.
//

import UIKit

extension UIView {
    
    //MARK: View extension to add gradiant
    
    func setDefaultGradient() -> Void {
        let gradiantLayer:CAGradientLayer = CAGradientLayer.init()
        gradiantLayer.frame = bounds
        gradiantLayer.colors = [UIColor.green, UIColor.yellow]
        gradiantLayer.locations = [0.4, 0.7, 1.0]
        layer.insertSublayer(gradiantLayer, at: 0)
    }
    
    func setGradientWithColors(colors:[UIColor]) -> Void {
        let gradiantLayer:CAGradientLayer = CAGradientLayer.init()
        gradiantLayer.frame = bounds
        gradiantLayer.colors = colors
        gradiantLayer.locations = [0.4, 0.7, 1.0]
        layer.insertSublayer(gradiantLayer, at: 0)
    }
    
}
