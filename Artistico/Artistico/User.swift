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

class User: NSObject, ResponseObjectSerializable {
    
    private(set) var userName:String = Global.kEmptyString
    
    override var description: String {
        return "User { username : \(userName)" +
                "password : (pass)}"
    }
    
    required init?(response: HTTPURLResponse, representation: Any){
        
        guard
            let representation = representation as?[String : Any],
            let name = representation["name"] as?String
            
        else { return nil }
        
        self.userName = name
    }
    
}
