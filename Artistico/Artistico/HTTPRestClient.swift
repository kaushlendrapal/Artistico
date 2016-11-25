//
//  HTTPRestClient.swift
//  Artistico
//
//  Created by kaushal on 11/22/16.
//  Copyright © 2016 kaushal. All rights reserved.
//

import UIKit
import Alamofire

let dafaultHTTPHeaders = ["Authorization": "Bearer"+"",
                          "Content-Type":"application/x-www-form-urlencoded;charset=utf-8",
                          "source" : "iphone"
                        ]
let kClientKey = "zByrNVHxNNRalyNo"
let kAPILoginGrantType = "password"
let utilityQueue = DispatchQueue.global(qos: .utility)

enum BackendError: Error {
    case network(error: Error) // Capture any underlying Error from the URLSession API
    case dataSerialization(error: Error)
    case jsonSerialization(error: Error)
    case xmlSerialization(error: Error)
    case objectSerialization(reason: String)
}

protocol ModelObjectSerializable {
    init?(representation: Any)
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
    
    func loginUser(withUser user:UserLogin, completionHandler:@escaping ((_ result:Result<Any>)->(Void))) -> Void {
        
        let param:[String: Any] = ["username":user.userName, "password" : user.password, "client_key": kClientKey, "grant_type" : kAPILoginGrantType]
        
        
        Alamofire.request(UserRouter.loginUser(parameters:param)).responseObject(queue: utilityQueue) { (response:DataResponse<RootJSON>) in
            
            debugPrint(response)
            
            switch response.result {
            case .success:
                if let rootJson:RootJSON = response.result.value {
                    
                    if let userJson:[String: Any] = rootJson.actualJSONData {
                        // end of common global JSON Object
                        if let userObjJson: [String: Any] = userJson["user"] as? [String : Any] {
                            let responseObject = UserLogin(representation: userObjJson)!
                            responseObject.accessToken = userJson["access_token"] as? String
                            responseObject.refreshToken = userJson["refresh_token"]as? String
                            responseObject.tokenType = userJson["token_type"]as? String
                            responseObject.expiresIn = userJson["expires_in"]as? String
                            
                            print("User: { username: \(responseObject.userName), accessToken: \(responseObject.accessToken) }")
                            completionHandler(.success(responseObject))
                        }
                    }
                }
            case .failure(let error):
                print(error)
                completionHandler(.failure(error))
            }
            

        }
        
        /*
        Alamofire.request(UserRouter.loginUser(parameters:param)).responseJSON(queue: utilityQueue) { response in
            
            print("Request: \(response.request)")
            
            switch response.result {
            case .success:
                if let json = response.result.value {
                    print("JSON: \(json)")
                }
            case .failure(let error):
                print(error)
            }
            
        }
  */
    }

}

extension DataRequest {
    
    @discardableResult
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


extension ResponseCollectionSerializable where Self: ResponseObjectSerializable {
    static func collection(from response: HTTPURLResponse, withRepresentation representation: Any) -> [Self] {
        var collection: [Self] = []
        
        if let representation = representation as? [[String: Any]] {
            for itemRepresentation in representation {
                if let item = Self(response: response, representation: itemRepresentation) {
                    collection.append(item)
                }
            }
        }
        
        return collection
    }
}

extension DataRequest {
    @discardableResult
    func responseCollection<T: ResponseCollectionSerializable>(
        queue: DispatchQueue? = nil,
        completionHandler: @escaping (DataResponse<[T]>) -> Void) -> Self
    {
        let responseSerializer = DataResponseSerializer<[T]> { request, response, data, error in
            guard error == nil else { return .failure(BackendError.network(error: error!)) }
            
            let jsonSerializer = DataRequest.jsonResponseSerializer(options: .allowFragments)
            let result = jsonSerializer.serializeResponse(request, response, data, nil)
            
            guard case let .success(jsonObject) = result else {
                return .failure(BackendError.jsonSerialization(error: result.error!))
            }
            
            guard let response = response else {
                let reason = "Response collection could not be serialized due to nil response."
                return .failure(BackendError.objectSerialization(reason: reason))
            }
            
            return .success(T.collection(from: response, withRepresentation: jsonObject))
        }
        
        return response(responseSerializer: responseSerializer, completionHandler: completionHandler)
    }
}







