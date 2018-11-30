//
//  BaseModel.swift
//  Github Demo
//
//  Created by Mo-Ramadan Abdelhafez on 11/30/18.
//  Copyright © 2018 Mo-Ramadan Abdelhafez. All rights reserved.
//

import Foundation
import ObjectMapper

class BaseModel: NSObject, Mappable {
    
    override init() {
        super.init()
    }
    
    public required init?(map: Map) {
        map.shouldIncludeNilValues = true
        super.init()
    }
    
    public func mapping(map: Map) {}
}
