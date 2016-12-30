//
//  HelpViewController.swift
//  Artistico
//
//  Created by kaushal on 11/28/16.
//  Copyright © 2016 kaushal. All rights reserved.
//

import UIKit

class HelpViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem()
    }
    
    @IBAction func loadProductCategoryScreen(sander:Any)-> () {
        
        let productCategoryVC:CategoryTableViewController = CategoryTableViewController.init(style: .plain)
        show(productCategoryVC, sender: nil)
        
    }
    
}
