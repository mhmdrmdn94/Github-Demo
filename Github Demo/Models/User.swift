//
//  User.swift
//  Github Demo
//
//  Created by Mo-Ramadan Abdelhafez on 12/1/18.
//  Copyright © 2018 Mo-Ramadan Abdelhafez. All rights reserved.
//

import Foundation
import ObjectMapper

class User: BaseModel, NSCoding {
    var id: Int?
    var nodeId: String?
    var login: String?
    var publicReposCount: Int?
    
    public override func mapping(map: Map) {
        super.mapping(map: map)
        id <- map["id"]
        nodeId <- map["node_id"]
        login <- map["login"]
        publicReposCount <- map["public_repos"]
    }
 
    required public init(coder aDecoder: NSCoder) {
        super.init()
        id = aDecoder.decodeObject(forKey: "id") as? Int
        nodeId = aDecoder.decodeObject(forKey: "node_id") as? String
        login = aDecoder.decodeObject(forKey: "login") as? String
        publicReposCount = aDecoder.decodeObject(forKey: "repos") as? Int
    }
    
    public required init?(map: Map) {
        super.init(map: map)
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(nodeId, forKey: "node_id")
        aCoder.encode(login, forKey: "login")
        aCoder.encode(publicReposCount, forKey: "repos")
    }
}
