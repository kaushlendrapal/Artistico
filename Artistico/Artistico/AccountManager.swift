//
//  AccountManager.swift
//  Artistico
//
//  Created by kaushal on 11/22/16.
//  Copyright © 2016 kaushal. All rights reserved.
//

/// Singleton class to handle user shitch on logout / login actions

import UIKit
import Firebase

typealias FIRAuthUserCallback = (FIRUser?, String?) -> ()
typealias FIRSignOutCallback = (String?) -> ()


class AccountManager: NSObject {
    
    static let sharedInstance = AccountManager()
    
    var signedIn = false
    var displayName: String?
    var photoURL: URL?
    
    override var description: String {
        return "User { displayName : \(displayName)" +
        "photoURL : \(photoURL)}"
       
    }
    
}

// Firebase authentication
extension AccountManager {
    
    func FIR_Authenticate(withEmail email:String, password:String,completion: FIRAuthUserCallback? = nil) -> Void {
        
        FIRAuth.auth()?.signIn(withEmail:email, password: password) { (user, error) in
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
                completion!(nil,errorDescription)
                return
            }
            AccountManager.sharedInstance.displayName = user?.displayName ?? user?.email
            AccountManager.sharedInstance.photoURL = user?.photoURL
            AccountManager.sharedInstance.signedIn = true
            print(AccountManager.description())
            
            let notificationName = Notification.Name(rawValue:NotificationKeys.SignedIn)
            NotificationCenter.default.post(name:notificationName, object: nil, userInfo: nil)
            completion!(user,Global.kEmptyString)
        }
    }
    
}
