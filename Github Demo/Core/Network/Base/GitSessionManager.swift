//
//  GitSessionManager.swift
//  Github Demo
//
//  Created by Mo-Ramadan Abdelhafez on 11/30/18.
//  Copyright © 2018 Mo-Ramadan Abdelhafez. All rights reserved.
//

import Foundation
import Alamofire

final class GitSessionManager: NSObject {
    
    private static var sessionManager: SessionManager?
    
    static var current: SessionManager {
        if sessionManager == nil {
            sessionManager = SessionManager()
        }
        
        if let token = UserDefaults.standard.string(forKey: UserDefaultsKey.UserKeys.token.rawValue) {
            sessionManager!.adapter = AccessTokenAdapter(token: token)
        }
        
        return sessionManager!
    }
    
    private override init() {
        super.init()
    }
    
    static func cancelAllRequests() {
        sessionManager?.session.invalidateAndCancel()
        sessionManager = nil
    }
}


class AccessTokenAdapter: RequestAdapter {
    private let token: String
    
    init(token: String) {
        self.token = token
    }
    
    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        var urlRequest = urlRequest
        
        if let urlString = urlRequest.url?.absoluteString, urlString.hasPrefix(Constants.baseURL) {
            urlRequest.setValue("token " + token, forHTTPHeaderField: "Authorization")
        }
        
        debugPrint(urlRequest)
        return urlRequest
    }
}
