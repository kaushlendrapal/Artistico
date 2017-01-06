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

extension UIColor {
    
    static func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.characters.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    static func hexStringToUIColor (hex:String, alphaValue:Float) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.characters.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(alphaValue)
        )
    }
}
