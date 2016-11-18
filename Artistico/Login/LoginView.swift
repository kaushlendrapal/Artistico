//
//  LoginView.swift
//  Artistico
//
//  Created by kaushal on 11/14/16.
//  Copyright © 2016 kaushal. All rights reserved.
//

import UIKit

class LoginView: UIView {
    
    var newView:UIView! = UIView.init(frame: CGRect.zero)
    var layoutConstraintGeneric = [NSLayoutConstraint]()
    var layoutConstraintHC = [NSLayoutConstraint]()
    var layoutConstraintHR = [NSLayoutConstraint]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
         super.init(coder: aDecoder)!
        setupView()
        addLayoutConstraintNewView()
        enableConstraintsForTraitCollection(myTraitCollection: traitCollection)
        newView.setNeedsUpdateConstraints()
        
    }
    
    func setupView() -> Void {
        
        newView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(newView)
        self.backgroundColor = UIColor.red
        newView.backgroundColor = UIColor.green
    }
    
}


extension LoginView {
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        
        super.traitCollectionDidChange(previousTraitCollection)
        
        if traitCollection.verticalSizeClass != previousTraitCollection?.verticalSizeClass {
            
            if let previousTrait = previousTraitCollection {
                enableConstraintsForTraitCollection(myTraitCollection: traitCollection)
                disableConstraintsForTraitCollection(myTraitCollection: previousTrait)
                newView.setNeedsUpdateConstraints()
            }
            
        }
    }
    
    func addLayoutConstraintNewView() -> Void {
        
        layoutConstraintHC += [
            newView.widthAnchor.constraint(equalToConstant:100),
            newView.heightAnchor.constraint(equalToConstant:100)
        ]
        
        layoutConstraintHR += [
            newView.widthAnchor.constraint(equalToConstant:200),
            newView.heightAnchor.constraint(equalToConstant:500)
        ]
        layoutConstraintGeneric += [
            newView.centerXAnchor.constraint(equalTo: centerXAnchor, constant:10) ,
            newView.centerYAnchor.constraint(equalTo: centerYAnchor, constant:10)
        ]
        NSLayoutConstraint.activate(layoutConstraintGeneric)
    }
    
    func enableConstraintsForTraitCollection(myTraitCollection: UITraitCollection) -> Void {
        
        switch myTraitCollection.verticalSizeClass {
            
        case UIUserInterfaceSizeClass.compact:
            NSLayoutConstraint.activate(layoutConstraintHC)
            
        case UIUserInterfaceSizeClass.unspecified:
             NSLayoutConstraint.activate(layoutConstraintHC)
            
        case UIUserInterfaceSizeClass.regular:
            NSLayoutConstraint.activate(layoutConstraintHR)
            
        }
    }
    
    func disableConstraintsForTraitCollection(myTraitCollection: UITraitCollection) -> Void {
        
        switch myTraitCollection.verticalSizeClass {
            
        case UIUserInterfaceSizeClass.compact:
            NSLayoutConstraint.deactivate(layoutConstraintHC)
            
        case UIUserInterfaceSizeClass.unspecified:
            NSLayoutConstraint.deactivate(layoutConstraintHC)
            
        case UIUserInterfaceSizeClass.regular:
            NSLayoutConstraint.deactivate(layoutConstraintHR)
        }

    }
    
    func disableAllConstraint() -> Void {
        
        NSLayoutConstraint.deactivate(layoutConstraintGeneric)
        NSLayoutConstraint.deactivate(layoutConstraintHC)
        NSLayoutConstraint.deactivate(layoutConstraintHR)
        
        let myTraitCollection :(UIUserInterfaceIdiom, UIUserInterfaceSizeClass, UIUserInterfaceSizeClass, CGFloat) = (traitCollection.userInterfaceIdiom, traitCollection.horizontalSizeClass, traitCollection.verticalSizeClass, traitCollection.displayScale)
        
        switch myTraitCollection {
            
        case (.phone,_, _,_):
            break
        case (.pad,_, _,_):
            break
            
        default:
            NSLayoutConstraint.deactivate(layoutConstraintHC)
            
       
        }
        
    }
    
}









