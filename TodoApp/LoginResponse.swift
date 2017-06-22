//
//  LoginResponse.swift
//  TodoApp
//
//  Created by seyedamirhossein hashemi on 2017-06-16.
//  Copyright © 2017 Fatih Nayebi. All rights reserved.
//

import Foundation
import ObjectMapper
import Alamofire
import ObjectMapper

class LoginResponse: Mappable {
    
    var success: Bool = false
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        success <- map["success"]
    }
}

class LoginManager {
    class func logIn(userName: String,
                     password: String,
                     _ completion: @escaping (_ responseData: LoginResponse?, _ error: Bool?) -> ()) {
        
        let url = URL(string: "http://localhost:8080/login")!
        
        let headers: HTTPHeaders = [
            "userName": userName,
            "password": password
        ]
        
        WebServiceManger.sendRequestLogin(requestHeaders: headers,
                                     url: url,
                                     requestMethod: .get,
                                     responseType: LoginResponse.self) {
                                        (responseData: LoginResponse?, error: Bool?) in
                                        completion(responseData, error)
        }
    }
    
    class func addLogin(_ requestParameters: [String: AnyObject]?,_ completion:@escaping (_ responseData:LoginResponse?, _ error: Bool?) -> ()) {
        
        let url = URL(string: "http://localhost:8080/postLogin")!
        WebServiceManger.sendRequestLogin(requestHeaders: requestParameters as! HTTPHeaders,
                                          url: url,
                                          requestMethod: .post,
                                          responseType: LoginResponse.self) {
                                            (responseData: LoginResponse?, error: Bool?) in
                                            completion(responseData!, error)
        }    }
    
    
}
