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
