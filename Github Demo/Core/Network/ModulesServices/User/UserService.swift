//
//  UserService.swift
//  Github Demo
//
//  Created by Mo-Ramadan Abdelhafez on 12/1/18.
//  Copyright © 2018 Mo-Ramadan Abdelhafez. All rights reserved.
//

import Foundation
import ObjectMapper

public class UserService {
    static func getProfile(onSuccess: @escaping (User?) -> (),
                               onFailure: @escaping (Error) -> ()) {
        
        let request = UserRouter.getProfile(parameters: [:])
        
        GitNetwork.request(request: request, onSuccess: { (dataresponse, result) in
            if let resultJson = result as? [String:Any] {
                let user = Mapper<User>().map(JSON: resultJson)
                onSuccess(user)
            } else {
                onSuccess(nil)
            }
        }) { (dataresponse, error) in
            onFailure(error)
        }
    }
}
