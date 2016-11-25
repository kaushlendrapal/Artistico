//
//  RootJSON.swift
//  Artistico
//
//  Created by kaushal on 11/24/16.
//  Copyright © 2016 kaushal. All rights reserved.
//

import UIKit



struct RootJSON : ResponseObjectSerializable {
    
    var rootData:[String: Any]
    var actualJSONData:[String: Any]?
    
    init?(response: HTTPURLResponse, representation: Any) {
        guard
            let jsonObject = representation as? [String : Any],
            let rootData = jsonObject["data"] as?[String: Any]
            else {return nil}
        // update check for sucess , message value.
        
        guard
            let actualJSONData = rootData["data"] as? [String : Any]
            else { return nil }
        // update check for top lavel key value.
        self.rootData = rootData
        self.actualJSONData = actualJSONData
    }
    
}

