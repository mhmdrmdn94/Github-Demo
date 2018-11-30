//
//  Repository.swift
//  Github Demo
//
//  Created by Mo-Ramadan Abdelhafez on 11/30/18.
//  Copyright © 2018 Mo-Ramadan Abdelhafez. All rights reserved.
//

import Foundation
import ObjectMapper

class Repository: BaseModel {
    var id: Int?
    var nodeId: String?
    var name: String?
    var repoDescription: String?
    var numberOfForks: Int?
    var numberOfWatchers: Int?
    var ownerId: Int?
    var ownerLogin: String?
    var ownerAvatar: String?
    
    public override func mapping(map: Map) {
        super.mapping(map: map)
        id <- map["id"]
        nodeId <- map["node_id"]
        name <- map["name"]
        repoDescription <- map["description"]
        numberOfForks <- map["forks_count"]
        numberOfWatchers <- map["watchers"]
        
        if let ownerJson = map.JSON["owner"] as? [String:Any] {
            ownerId = ownerJson["id"] as? Int
            ownerLogin = ownerJson["login"] as? String
            ownerAvatar =  ownerJson["avatar_url"] as? String
        }
    }
}
