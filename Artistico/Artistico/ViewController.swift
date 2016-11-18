//
//  ViewController.swift
//  Artistico
//
//  Created by kaushal on 11/14/16.
//  Copyright © 2016 kaushal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var loginViewController : LoginViewController?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func loginButtonClicked(sender :Any) {
    
        if let loginVC = loginViewController {
            show(loginVC, sender: nil)
            
        } else {
        
            let storyboard : UIStoryboard = UIStoryboard.init(name:"Main", bundle: nil)
            
            self.loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController
            
            show(self.loginViewController!, sender: nil)
        }
    }
    
}

