//
//  HTTPRestClient.swift
//  Artistico
//
//  Created by kaushal on 11/22/16.
//  Copyright © 2016 kaushal. All rights reserved.
//

import UIKit
import Alamofire

let dafaultHTTPHeaders = ["outhkey": "test"]

enum BackendError: Error {
    case network(error: Error) // Capture any underlying Error from the URLSession API
    case dataSerialization(error: Error)
    case jsonSerialization(error: Error)
    case xmlSerialization(error: Error)
    case objectSerialization(reason: String)
}

protocol ResponseObjectSerializable {
    init?(response: HTTPURLResponse, representation: Any)
}

protocol ResponseCollectionSerializable {
    static func collection(from response: HTTPURLResponse, withRepresentation representation: Any) -> [Self]
}

final class HTTPRestClient: NSObject {
    
    static let DefaultRestClient = { () -> HTTPRestClient in 
        let sharedInstance = HTTPRestClient()
        // done custon initilization 
        
        return sharedInstance
    }()
    
   private(set) var sessionManager : SessionManager = {
       let sessionManager = Alamofire.SessionManager(configuration: URLSessionConfiguration.default)
        sessionManager.session.configuration.httpAdditionalHeaders = dafaultHTTPHeaders
        return sessionManager;
    }()
    
    
    private override init() {
        super.init()
    }
    
    func loginUser(withUser user:User) -> Void {
        
        var dataRequest:DataRequest = Alamofire.request(UserRouter.readUser(username: user.userName))
    }
    
}


extension DataRequest {
    
    func responseObject<T: ResponseObjectSerializable>(
        queue: DispatchQueue? = nil,
        completionHandler: @escaping (DataResponse<T>) -> Void)
        -> Self
    {
        let responseSerializer = DataResponseSerializer<T> { request, response, data, error in
            guard error == nil else { return .failure(BackendError.network(error: error!)) }
            
            let jsonResponseSerializer = DataRequest.jsonResponseSerializer(options: .allowFragments)
            let result = jsonResponseSerializer.serializeResponse(request, response, data, nil)
            
            guard case let .success(jsonObject) = result else {
                return .failure(BackendError.jsonSerialization(error: result.error!))
            }
            
            guard let response = response, let responseObject = T(response: response, representation: jsonObject) else {
                return .failure(BackendError.objectSerialization(reason: "JSON could not be serialized: \(jsonObject)"))
            }
            
            return .success(responseObject)
        }
        
        return response(queue: queue, responseSerializer: responseSerializer, completionHandler: completionHandler)
    }
}
