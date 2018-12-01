//
//  ForksService.swift
//  Github Demo
//
//  Created by Mo-Ramadan Abdelhafez on 12/1/18.
//  Copyright © 2018 Mo-Ramadan Abdelhafez. All rights reserved.
//

import Foundation
import ObjectMapper

public class ForksService {
    
    static func getForks(forRepo repoName: String,
                         forOwner ownerName: String,
                         page: Int,
                         onSuccess: @escaping ([Fork]) -> (),
                         onFailure: @escaping (Error) -> ()) {
        
        let parameters: [String:Any] = ["page": page]
        let request = ForksRouter.getForks(parameters: parameters,
                                           ownerName: ownerName,
                                           repoName: repoName)
        
        GitNetwork.request(request: request, onSuccess: { (dataresponse, result) in
            if let itemsJson = result as? [[String:Any]] {
                let forks = Mapper<Fork>().mapArray(JSONObject: itemsJson) ?? []
                onSuccess(forks)
            } else {
                onSuccess([])
            }
        }) { (dataresponse, error) in
            onFailure(error)
        }
    }
}
