//
//  SignInAuthService.swift
//  Artistico
//
//  Created by kaushal on 12/9/16.
//  Copyright © 2016 kaushal. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import GoogleSignIn


enum SignInOAuthType {
    case facebook
    case google
    case twitter
}

class SignInAuthService: NSObject, GIDSignInDelegate, GIDSignInUIDelegate {
    
    unowned var delegatedViewController:UIViewController
    var signInType:SignInOAuthType = .google
    var signInCallback:FIRAuthUserCallback?=nil
    
    required init(delegated:UIViewController, signInType:SignInOAuthType) {
        self.delegatedViewController = delegated
        self.signInType = signInType
        super.init()
        validateAuthPreCondition(signInType: self.signInType)
    }
    
    @discardableResult
    func validateAuthPreCondition(signInType:SignInOAuthType) -> Bool {
        
        switch signInType {
        case .facebook:
            return true
        case .google:
            GIDSignIn.sharedInstance().delegate = self
            GIDSignIn.sharedInstance().uiDelegate = self
            return true
        case .twitter :
            return true

        }
        
    }
    
    func signIn(_ completion:FIRAuthUserCallback?=nil) -> () {
        signInCallback = completion
        GIDSignIn.sharedInstance().signIn()
    }
    
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        if let error = error {
            print(error.localizedDescription)
            return
        }
        
        let authentication = user.authentication
        let credential = FIRGoogleAuthProvider.credential(withIDToken: (authentication?.idToken)!,
                                                          accessToken: (authentication?.accessToken)!)
        print(credential)
        FIRAuth.auth()?.signIn(with: credential) {[unowned self] (user, error) in
            
            guard let _:FIRUser = user else {
                var errorDescription:String? = "user and error are nil"
                if let error = error {
                    if let errCode = FIRAuthErrorCode(rawValue: error._code) {
                        switch errCode {
                        case .errorCodeUserNotFound:
                            errorDescription = "User account not found. Try registering"
                        case .errorCodeWrongPassword:
                            errorDescription = "Incorrect username/password combination"
                        default:
                            errorDescription = "Error:" + error.localizedDescription
                        }
                    }
                }
                self.signInCallback!(nil,errorDescription)
                return
            }
            self.signInCallback!(user,Global.kEmptyString)
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // ...
    }
    
    //GIDSignInUIDelegate
    
    func sign(inWillDispatch signIn: GIDSignIn!, error: Error!) {
        
    }
    
    func sign(_ signIn: GIDSignIn!, present viewController: UIViewController!) {
        delegatedViewController.present(viewController, animated: true, completion: nil)
    }
    
    func sign(_ signIn: GIDSignIn!, dismiss viewController: UIViewController!) {
        delegatedViewController.dismiss(animated: true, completion: nil)
        // add callback to handle loginSuccess
    }
}
