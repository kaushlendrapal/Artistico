//
//  User.swift
//  Artistico
//
//  Created by kaushal on 11/22/16.
//  Copyright © 2016 kaushal. All rights reserved.
//

import UIKit
import Alamofire
import CoreData

struct UserJson {
    static let userNeme = "lastname"
    static let accessToken = "lastname"
    static let refreshToken = "lastname"
    static let expiresIn = "lastname"
    static let tokenType = "lastname"
}


 final class UserLogin: NSObject, ModelObjectSerializable {
    
    private(set) var userName:String = Global.kEmptyString
    private(set) var password:String = Global.kEmptyString
    var accessToken:String?
    var refreshToken:String?
    var expiresIn:String?
    var tokenType:String?
    
    override var description: String {
        return "User { username : \(userName)" +
                "password : \(password)}"
    }
    
     init?(representation: Any) {
        
        guard
            let representation = representation as?[String : Any],
            let name = representation[UserJson.userNeme] as?String,
            let accessToken = representation[UserJson.accessToken] as?String,
            let refreshToken = representation[UserJson.refreshToken] as?String,
            let expiresIn = representation[UserJson.expiresIn] as?String,
            let tokenType = representation[UserJson.tokenType] as?String
        else { return nil }
        
        self.userName = name
        self.accessToken = accessToken
        self.refreshToken = refreshToken
        self.expiresIn = expiresIn
        self.tokenType = tokenType
    }
    
    init(name:String, password:String) {
        self.userName = name
        self.password = password
    }
    
}
