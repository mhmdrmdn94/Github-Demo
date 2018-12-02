//
//  BaseNavigationController.swift
//  Github Demo
//
//  Created by Mo-Ramadan Abdelhafez on 11/30/18.
//  Copyright © 2018 Mo-Ramadan Abdelhafez. All rights reserved.
//

import Foundation
import UIKit

class BaseNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.prefersLargeTitles = true
        let searchCancelAttributes = [NSAttributedStringKey.foregroundColor: GitColor.primary.value]
        UIBarButtonItem.appearance().setTitleTextAttributes(searchCancelAttributes , for: .normal)
        UINavigationBar.appearance().largeTitleTextAttributes =
            [NSAttributedStringKey.foregroundColor: GitColor.primary.value]
    }
}
