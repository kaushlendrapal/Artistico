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
}


 final class User: NSObject, ModelObjectSerializable {
    
    private(set) var userName:String = Global.kEmptyString
    private(set) var password:String = Global.kEmptyString

    
    override var description: String {
        return "User { username : \(userName)" +
                "password : \(password)}"
    }
    
     init?(representation: Any) {
        
        guard
            let representation = representation as?[String : Any],
            let name = representation[UserJson.userNeme] as?String
            
        else { return nil }
        
        self.userName = name
    }
    
    init(name:String, password:String) {
        self.userName = name
        self.password = password
    }
    
}
