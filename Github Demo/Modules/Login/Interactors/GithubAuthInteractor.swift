//
//  GithubAuthInteractor.swift
//  Github Demo
//
//  Created by Mo-Ramadan Abdelhafez on 12/1/18.
//  Copyright © 2018 Mo-Ramadan Abdelhafez. All rights reserved.
//

import Foundation

class GithubAuthInteractor: NSObject {
    static let shared = GithubAuthInteractor()
    
    private override init() {
        super.init()
    }
    
    func loadUserAccessTocken(usingCode code: String,
                              onSuccess: @escaping (String?) -> (),
                              onFailure: @escaping (Error) -> ()) {
        
        AccessTokenService.getAccessToken(usingVerificationCode: code,
                                          onSuccess: { (accessToken) in
                                            guard let token = accessToken else {
                                                onSuccess(nil)
                                                return
                                            }
                                            //TODO:- Persist access token
                                            let key = UserDefaultsKey.UserKeys.token.rawValue
                                            UserDefaults.standard.set(token, forKey: key)
                                            onSuccess(accessToken)
        }) { (error) in
            onFailure(error)
        }
    }
    
    func loadUserProfile(onSuccess: @escaping (User?) -> (),
                         onFailure: @escaping (Error) -> ()) {
       
        UserService.getProfile(onSuccess: { (user) in
            guard let user = user else {
                onSuccess(nil)
                return
            }
            //TODO:- Persist User Object
            UserSessionManager.persistUser(user)
            onSuccess(user)
        }) { (error) in
            onFailure(error)
        }
    }
}
