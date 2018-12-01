//
//  ForksRouter.swift
//  Github Demo
//
//  Created by Mo-Ramadan Abdelhafez on 12/1/18.
//  Copyright © 2018 Mo-Ramadan Abdelhafez. All rights reserved.
//

import Foundation
import Alamofire


enum ForksRouter: GitURLRequestConvertible {
    
    case getForks(parameters: Parameters, ownerName: String, repoName: String)
    
    var method: HTTPMethod {
        switch self {
        case .getForks: return .get
            
        }
    }
    
    var path: String {
        switch self {
        case .getForks( _, let ownerName, let repoName):
            return "/repos/\(ownerName)/\(repoName)/forks"
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .getForks(let params, _, _): return params
        }
    }
}
