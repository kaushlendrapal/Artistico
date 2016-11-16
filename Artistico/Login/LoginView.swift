//
//  LoginView.swift
//  Artistico
//
//  Created by kaushal on 11/14/16.
//  Copyright © 2016 kaushal. All rights reserved.
//

import UIKit

class LoginView: UIView {
    
   @IBOutlet var tableView: UITableView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
         super.init(coder: aDecoder)!
    }
    
    //MARK: update view constraint
    
    override func updateConstraints() {
        super.updateConstraints()
    }
    
}

extension LoginView {
    
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        
        super.traitCollectionDidChange(previousTraitCollection)
        
        if traitCollection.verticalSizeClass != previousTraitCollection?.verticalSizeClass {
            
            switch traitCollection.verticalSizeClass {
                
            case UIUserInterfaceSizeClass.compact:
                updateConstraints()
                
            case UIUserInterfaceSizeClass.unspecified:
                    fallthrough
            
            case UIUserInterfaceSizeClass.regular:
                updateConstraints()
            
            }
        }
    }
    
}
