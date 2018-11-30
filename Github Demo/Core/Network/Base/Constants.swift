//
//  Constants.swift
//  Github Demo
//
//  Created by Mo-Ramadan Abdelhafez on 11/30/18.
//  Copyright © 2018 Mo-Ramadan Abdelhafez. All rights reserved.
//

import Foundation


enum APIConstants: String {
    case baseUrl = "https://api.github.com"
}

enum Environment {
    case debug
    case staging
    case release
    
    static var current: Environment {
        return .release
    }
}

struct Constants {
    private init() {}
    
    static let environment = Environment.current
    
    static var baseURL: String {
        switch environment {
        case .debug:
            return "https://api.github.com"
        case .staging:
            return "https://api.github.com"
        case .release:
            return "https://api.github.com"
        }
    }
}
