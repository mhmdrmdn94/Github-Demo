//
//  ActivityLoader.swift
//  Github Demo
//
//  Created by Mo-Ramadan Abdelhafez on 11/30/18.
//  Copyright © 2018 Mo-Ramadan Abdelhafez. All rights reserved.
//

import Foundation
import NVActivityIndicatorView

class Activity {
    static func showLoader() {
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(ActivityData(), nil)
    }
    
    static func hideLoader() {
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating(nil)
    }
}
