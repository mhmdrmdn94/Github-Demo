//
//  UserRouter.swift
//  Github Demo
//
//  Created by Mo-Ramadan Abdelhafez on 12/1/18.
//  Copyright © 2018 Mo-Ramadan Abdelhafez. All rights reserved.
//

import Foundation
import Alamofire


enum UserRouter: GitURLRequestConvertible {
    
    case getProfile(parameters: Parameters)
    
    var method: HTTPMethod {
        switch self {
        case .getProfile: return .get
        }
    }
    
    var path: String {
        switch self {
        case .getProfile: return "/user"
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .getProfile(let params): return params
        }
    }
}
