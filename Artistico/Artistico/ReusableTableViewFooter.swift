//
//  ReusableTableViewFooter.swift
//  Artistico
//
//  Created by kaushal on 12/19/16.
//  Copyright © 2016 kaushal. All rights reserved.
//

import UIKit

class ReusableTableViewFooter: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override class var requiresConstraintBasedLayout: Bool {
        return true
    }
    
}
