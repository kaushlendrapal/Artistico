//
//  AccountManager.swift
//  Artistico
//
//  Created by kaushal on 11/22/16.
//  Copyright © 2016 kaushal. All rights reserved.
//

/// Singleton class to handle user shitch on logout / login actions

import UIKit

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
