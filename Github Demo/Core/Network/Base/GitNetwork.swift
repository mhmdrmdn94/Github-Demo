//
//  GitNetwork.swift
//  Github Demo
//
//  Created by Mo-Ramadan Abdelhafez on 11/30/18.
//  Copyright © 2018 Mo-Ramadan Abdelhafez. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

final class GitNetwork {
    typealias DataResponseType  = DataResponse<Any>
    typealias OnSuccessCallback = (DataResponseType, Any?)   -> ()
    typealias OnFailureCallback = (DataResponseType?, Error) -> ()
    
    private init() {}
    
    static func request(request: URLRequestConvertible,
                        onSuccess: OnSuccessCallback? = nil,
                        onFailure: OnFailureCallback? = nil) {
        
        requestWillBeSent(request: request)
        debugPrint(request)
        GitSessionManager.current.request(request).validate().responseJSON { dataResponse in
            responseded(response: dataResponse)
            switch dataResponse.result {
            case .success(let result):
                onSuccess?(dataResponse, result)
            case .failure(let error):
                onFailure?(dataResponse, error)
            }
        }
    }
    
    private static func requestWillBeSent(request: URLRequestConvertible) {
        print("Sending Request.")
        print("=================================================")
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    private static func responseded(response: DataResponseType) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
}
