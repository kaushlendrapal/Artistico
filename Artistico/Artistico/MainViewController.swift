//
//  MainViewController.swift
//  Artistico
//
//  Created by kaushal on 11/25/16.
//  Copyright © 2016 kaushal. All rights reserved.
//

import UIKit

class MainViewController: UINavigationController, UIGestureRecognizerDelegate {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.isHidden = true;
        interactivePopGestureRecognizer?.isEnabled = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if responds(to: #selector(getter:interactivePopGestureRecognizer)) {
            interactivePopGestureRecognizer?.isEnabled = true
            interactivePopGestureRecognizer?.delegate = self
        }
    }
    
}

//MARK: UIGestureRecognizerDelegate
extension MainViewController {
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
