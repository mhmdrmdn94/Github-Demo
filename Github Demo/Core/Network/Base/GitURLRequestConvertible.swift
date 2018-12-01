//
//  GitURLRequestConvertible.swift
//  Github Demo
//
//  Created by Mo-Ramadan Abdelhafez on 11/30/18.
//  Copyright © 2018 Mo-Ramadan Abdelhafez. All rights reserved.
//

import Foundation
import Alamofire

protocol GitURLRequestConvertible: URLRequestConvertible {
    var baseUrl:    String?             { get }
    var method:     HTTPMethod          { get }
    var name:       String?             { get }
    var path:       String              { get }
    var parameters: Parameters?         { get }
    
}

extension GitURLRequestConvertible {
    
    //these can be overriden
    var baseUrl: String? {
        return nil
    }
    
    var parameters: Parameters? {
        return nil
    }
    
    var name: String? {
        return nil
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try (baseUrl ?? Constants.baseURL).asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        if let params = parameters {
            urlRequest = try URLEncoding.default.encode(urlRequest, with: params)
        }
        
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        
        return urlRequest
    }
}
