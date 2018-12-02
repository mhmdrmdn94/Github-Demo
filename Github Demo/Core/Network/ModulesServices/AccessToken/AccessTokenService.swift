//
//  AccessTokenService.swift
//  Github Demo
//
//  Created by Mo-Ramadan Abdelhafez on 12/1/18.
//  Copyright © 2018 Mo-Ramadan Abdelhafez. All rights reserved.
//

import Foundation
import ObjectMapper

public class AccessTokenService {
    
    static func getAccessToken(usingVerificationCode code: String,
                               onSuccess: @escaping (String?) -> (),
                               onFailure: @escaping (Error) -> ()) {
        
        let params: [String:String] = [ "client_id" : APIConstants.githubClientId.rawValue,
                                        "client_secret" : APIConstants.githubClientSecret.rawValue,
                                        "code" : code,
                                        "scope": APIConstants.githubScope.rawValue]
        let request = AccessTokenRouter.getAccessToken(parameters: params)
        
        GitNetwork.request(request: request, onSuccess: { (dataresponse, result) in
            if let resultJson = result as? [String:Any],
                let accessToken = resultJson["access_token"] as? String {
                onSuccess(accessToken)
            } else {
                onSuccess(nil)
            }
        }) { (dataresponse, error) in
            onFailure(error)
        }
    }
}
