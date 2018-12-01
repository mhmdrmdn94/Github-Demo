//
//  Fork.swift
//  Github Demo
//
//  Created by Mo-Ramadan Abdelhafez on 12/1/18.
//  Copyright © 2018 Mo-Ramadan Abdelhafez. All rights reserved.
//

import Foundation
import ObjectMapper

class Fork: Repository {
    
    public override func mapping(map: Map) {
        super.mapping(map: map)
    }
    
    func getForkViewModel() -> ForkViewModel {
        let username = ownerLogin ?? "Name N/A"
        let avatarUrlString = ownerAvatar ?? ""
        let forkViewModel = ForkViewModel(username: username, avatarUrl: avatarUrlString)
        return forkViewModel
    }
    
}
