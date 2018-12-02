//
//  ReposService.swift
//  Github Demo
//
//  Created by Mo-Ramadan Abdelhafez on 11/30/18.
//  Copyright © 2018 Mo-Ramadan Abdelhafez. All rights reserved.
//

import Foundation
import Alamofire
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
    
    //MARK:-
    // Sorry, I did NOT have time to refactor the next method as I faced issues
    //  with [+user:username] encoding  - -  issues related to percent escaping while sending params.
    static func searchInLoggedInUserRepositories(keyword: String,
                                                 page: Int,
                                                 username: String,
                                                 onSuccess: @escaping ([Repository]) -> (),
                                                 onFailure: @escaping (Error) -> ()) {
        
        let paramsString = "q=\(keyword)+user:\(username)&page=\(page)"
        let urlString = "https://api.github.com/search/repositories?" + paramsString
        
        Alamofire.request(urlString).responseJSON { dataResponse in
            switch dataResponse.result {
            case .success(let result):
                if let resultJson = result as? [String:Any],
                    let items = resultJson["items"] as? [[String:Any]] {
                    let repositories = Mapper<Repository>().mapArray(JSONObject: items) ?? []
                    onSuccess(repositories)
                } else {
                    onSuccess([])
                }
            
            case .failure(let error):
                onFailure(error)
            }
        }
    }
}
