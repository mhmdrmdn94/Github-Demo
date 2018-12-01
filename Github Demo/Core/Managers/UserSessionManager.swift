//
//  UserSessionManager.swift
//  Github Demo
//
//  Created by Mo-Ramadan Abdelhafez on 12/1/18.
//  Copyright © 2018 Mo-Ramadan Abdelhafez. All rights reserved.
//

import Foundation
import UIKit

class UserSessionManager: NSObject {
    
    private override init() { super.init() }
    
    static var currentUser: User? {
        guard let userData = UserDefaults.standard.data(forKey: UserDefaultsKey.UserKeys.currentUser.rawValue) else {
            return nil
        }
        return NSKeyedUnarchiver.unarchiveObject(with: userData) as? User
    }
    
    static func persistUser(_ user: User) {
        let userData = NSKeyedArchiver.archivedData(withRootObject: user)
        UserDefaults.standard.set(userData, forKey:  UserDefaultsKey.UserKeys.currentUser.rawValue)
        UserDefaults.standard.synchronize()
    }

    static func removeUser() {
        UserDefaults.standard.removeObject(forKey:  UserDefaultsKey.UserKeys.currentUser.rawValue)
        UserDefaults.standard.synchronize()
    }

    static func logoutUser() {
        removeUser()
        UserDefaults.standard.removeObject(forKey:  UserDefaultsKey.UserKeys.token.rawValue)
        //TODO: redirect to login view controller
    }
}
