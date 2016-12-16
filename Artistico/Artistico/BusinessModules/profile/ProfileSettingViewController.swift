//
//  ProfileSettingViewController.swift
//  Artistico
//
//  Created by kaushal on 11/28/16.
//  Copyright © 2016 kaushal. All rights reserved.
//

import UIKit

class ProfileSettingViewController: UIViewController {
    
    var signInAuthService:SignInAuthService?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signInAuthService = SignInAuthService.init(delegated: self, signInType: .google)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem()
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func app_LogoutButtonTapped(sander:Any) -> () {
        signInAuthService?.signOut(){[unowned self] error in
            
            if let error = error {
                // show alert
                print(error.description)
            } else {
                // pop to root view controller.
                let _ =  self.navigationController?.popToRootViewController(animated: false)
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                if let loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController {
                    let mainViewController:MainViewController = MainViewController(rootViewController:loginViewController);
                    appDelegate.window?.rootViewController = mainViewController
                }
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
