//
//  AccessTokenRouter.swift
//  Github Demo
//
//  Created by Mo-Ramadan Abdelhafez on 12/1/18.
//  Copyright © 2018 Mo-Ramadan Abdelhafez. All rights reserved.
//

import Foundation
import Alamofire


enum AccessTokenRouter: GitURLRequestConvertible {
    
    case getAccessToken(parameters: Parameters)
    
    var baseUrl: String? {
        return APIConstants.baseUrl.rawValue
    }
    
    var method: HTTPMethod {
        switch self {
        case .getAccessToken: return .post
        }
    }
    
    var path: String {
        switch self {
        case .getAccessToken: return "/login/oauth/access_token"
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .getAccessToken(let params): return params
        }
    }
}
