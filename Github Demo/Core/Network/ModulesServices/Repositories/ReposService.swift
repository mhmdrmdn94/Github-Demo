//
//  ReposService.swift
//  Github Demo
//
//  Created by Mo-Ramadan Abdelhafez on 11/30/18.
//  Copyright © 2018 Mo-Ramadan Abdelhafez. All rights reserved.
//

import Foundation
import ObjectMapper

public class ReposService {
   
    static func search(keyword: String,
                              page: Int,
                              onSuccess: @escaping ([Repository]) -> (),
                              onFailure: @escaping (Error) -> ()) {
        
        let parameters: [String:Any] = ["q": keyword, "page": page]
        let request = ReposRouter.search(parameters: parameters)
        
        GitNetwork.request(request: request, onSuccess: { (dataresponse, result) in
            if let resultJson = result as? [String:Any],
                let items = resultJson["items"] as? [[String:Any]] {
                let repositories = Mapper<Repository>().mapArray(JSONObject: items) ?? []
                onSuccess(repositories)
            } else {
                onSuccess([])
            }
        }) { (dataresponse, error) in
            onFailure(error)
        }
    }
}
