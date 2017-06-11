//
//  WebServiceManager.swift
//  2016-06-01-codelab-frontend
//
//  Created by Fatih Nayebi on 2016-06-01.
//  Copyright © 2016 Swift-Mtl. All rights reserved.
//

import Foundation
import ObjectMapper
import Alamofire
import AlamofireObjectMapper

class WebServiceManger {
    // add requestParameters for argument for this method
    class func sendRequest<T: Mappable>(_ requestParameters: [String: AnyObject]? , url: URL, requestMethod: Alamofire.HTTPMethod, responseType: T.Type, completion: @escaping (_ responseData: [T]?, _ error: Bool?) -> Void) {
        //print(requestParameters)
        // To execute in a different thread than main thread:
        let queue = DispatchQueue(label: "manager-response-queue", attributes: DispatchQueue.Attributes.concurrent)
        
        // Alamofire web service call:
        //let headers: HTTPHeaders = [ "X-APP-TOKEN" : Token().readToken() ]
        
//        Alamofire.request(url, method: requestMethod, parameters: requestParameters)
        // change the request argument, add headers instead of parameters.
        Alamofire.request(url, method: requestMethod, parameters: nil,encoding : JSONEncoding.default,
                          headers: requestParameters as? [String:String])
            .responseArray(queue: queue, completionHandler: {
                (response: DataResponse<[T]>) in
                
                print(response.request!)  // original URL request
                print(response.response!) // URL response
                print(response.result)   // result of response serialization
                
                if let mappedModel = response.result.value {
                    DispatchQueue.main.async(execute: {
                        // Save the data to DB:
                        
//                        saveData(mappedModel)
                        print("Mapped Model: \(mappedModel)")
                        // callback with the data
                        completion(mappedModel, nil)
                    })
                }
            })
        
    }
}
