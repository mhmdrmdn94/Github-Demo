//
//  Alert.swift
//  Github Demo
//
//  Created by Mo-Ramadan Abdelhafez on 11/30/18.
//  Copyright © 2018 Mo-Ramadan Abdelhafez. All rights reserved.
//

import Foundation
import UIKit

class Alert {
    static func show(_ viewController: UIViewController? = nil,
                     message: String,
                     title: String? = nil) {
        
        var viewController = viewController
        if viewController == nil {
            viewController = UIApplication.shared.keyWindow?.rootViewController
        }
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .cancel) { action in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(okAction)
        viewController?.present(alert, animated: true, completion: nil)
    }
}
