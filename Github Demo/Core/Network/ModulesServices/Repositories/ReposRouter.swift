//
//  ReposRouter.swift
//  Github Demo
//
//  Created by Mo-Ramadan Abdelhafez on 11/30/18.
//  Copyright © 2018 Mo-Ramadan Abdelhafez. All rights reserved.
//

import Foundation
import Alamofire

enum ReposRouter: GitURLRequestConvertible {
    
    case search(parameters: Parameters)
    
    var method: HTTPMethod {
        switch self {
        case .search: return .get
            
        }
    }
    
    var path: String {
        switch self {
        case .search: return "/search/repositories"
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .search(let params): return params
            
        }
    }
}
